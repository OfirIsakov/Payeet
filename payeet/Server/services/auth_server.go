package services

import (
	"context"
	"net"
	"regexp"
	"strings"

	log "github.com/sirupsen/logrus"

	pb "galil-maaravi-802-payeet/payeet/Server/protos"

	"github.com/go-passwd/validator"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// AuthServer manages the authentication
type AuthServer struct {
	mongoDBWrapper MongoDBWrapper
	jwtManager     *JWTManager
	emailManager   *EmailManager
}

// NewAuthServer creates a new authentication server
func NewAuthServer(mongoDBWrapper MongoDBWrapper, jwtManager *JWTManager, emailManager *EmailManager) *AuthServer {
	return &AuthServer{mongoDBWrapper, jwtManager, emailManager}
}

// Login checks if the details are good and sends a new jet token to the user
func (server *AuthServer) Login(ctx context.Context, req *pb.LoginRequest) (*pb.LoginResponse, error) {
	// find the user in the database.
	user, err := server.mongoDBWrapper.GetUserByEmail(req.GetMail())
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "Invalid username or password")
	}

	// check if the password is correct
	if user == nil || user.validatePassword(req.GetPassword()) != nil {
		return nil, status.Errorf(codes.NotFound, "Invalid username or password")
	}

	accessToken, refreshToken, expiresAt, err := server.GenerateTokens(user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Something went wrong!")
	}

	// grant user his daily bonus if he should
	// the function returns an error if it shouldnt add the bonus,
	// we safely ignore it here
	server.mongoDBWrapper.DailyBonus(user.Email)

	log.WithFields(log.Fields{"email": user.Email}).Info("Login")

	// sending a new JWT token, expire time, new refresh token.
	res := &pb.LoginResponse{AccessToken: accessToken, ExpiresOn: expiresAt, RefreshToken: refreshToken}
	return res, nil
}

// RefreshToken will generate a new token for the user
func (server *AuthServer) RefreshToken(ctx context.Context, req *pb.RefreshTokenRequest) (*pb.LoginResponse, error) {

	// get the userclims from the refresh token
	userClaims, err := server.jwtManager.VerifyRefreshToken(req.GetRefreshToken())
	if err != nil {
		return nil, err
	}

	// get the user from the user claims.
	user, err := server.mongoDBWrapper.GetUserByEmail(userClaims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Something went wrong!")
	}

	// verify refresh token against database.
	if user.RefreshToken != req.GetRefreshToken() {
		return nil, status.Errorf(codes.Internal, "Something went wrong!")
	}

	accessToken, refreshToken, expiresAt, err := server.GenerateTokens(user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Something went wrong!")
	}

	// sending a new JWT token, expire time, new refresh token.
	res := &pb.LoginResponse{AccessToken: accessToken, ExpiresOn: expiresAt, RefreshToken: refreshToken}
	return res, nil

}

// Register creates a new user.
func (server *AuthServer) Register(ctx context.Context, req *pb.RegisterRequest) (*pb.StatusResponse, error) {

	user, err := NewUser(req.GetFirstName(), req.GetLastName(), req.GetMail(), req.GetPassword(), "user")

	if err != nil {
		return nil, err
	}

	passwordValidator := validator.New(
		validator.MinLength(
			5,
			status.Errorf(codes.InvalidArgument, "Password is too short")),
		validator.ContainsAtLeast(
			"~<=>+-@!#$%^&*",
			1,
			status.Errorf(codes.InvalidArgument, "Password must contain at least 1 special character(~<=>+-@!#$%%^&*)")), // %% is escaping the %
		validator.CommonPassword(nil),
		validator.Similarity(
			[]string{
				req.GetFirstName(),
				req.GetLastName(),
				req.GetMail()},
			nil,
			nil))
	err = passwordValidator.Validate(req.GetPassword())
	if err != nil {
		return nil, err
	}

	if !IsEmailValid(req.GetMail()) {
		return nil, status.Errorf(codes.InvalidArgument, "Invalid mail format!")
	}

	err = server.mongoDBWrapper.AddUser(user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Something went wrong while creating the user!")
	}

	server.emailManager.SendVerficationCode(user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Couldn't send verfication code")
	}

	return &pb.StatusResponse{}, nil
}

// IsEmailValid checks if the email provided passes the required structure
// and length test. It also checks the domain has a valid MX record.
func IsEmailValid(mail string) bool {
	var emailRegex = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")

	// mail must be bigger then 3 characters long and less then 254
	if len(mail) < 3 && len(mail) > 254 {
		return false
	}

	if !emailRegex.MatchString(mail) {
		return false
	}

	parts := strings.Split(mail, "@")
	mx, err := net.LookupMX(parts[1])
	if err != nil || len(mx) == 0 {
		return false
	}

	return true
}

// GenerateTokens will generate new access token, refresh token and thier expiration time for the given user
func (server *AuthServer) GenerateTokens(user *User) (accessToken string, refreshToken string, expiresAt int64, err error) {
	// generate JWT tokenn
	accessToken, err = server.jwtManager.GenerateAccessToken(user) // create a new token
	if err != nil {
		return
	}

	// generate refresh token
	refreshToken, err = server.jwtManager.GenerateRefreshToken(user) // create a new token
	if err != nil {
		return
	}

	// get userclaims from the token so we could get the expire time.
	userClaims, err := server.jwtManager.VerifyAccessToken(accessToken)
	if err != nil {
		return
	}

	// save the refresh token in the database.
	if server.mongoDBWrapper.SetRefreshToken(user.Email, refreshToken) != nil {
		return
	}

	expiresAt = userClaims.ExpiresAt

	return
}
