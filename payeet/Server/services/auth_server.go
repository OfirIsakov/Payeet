package services

import (
	"context"
	"net"
	"regexp"
	"strings"

	"github.com/sirupsen/logrus"
	log "github.com/sirupsen/logrus"

	pb "galil-maaravi-802-payeet/payeet/Server/protos"

	"github.com/go-passwd/validator"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// AuthServer manages the auth.
type AuthServer struct {
	userStore  UserStore
	jwtManager *JWTManager
}

// NewAuthServer creates a new auth server
func NewAuthServer(userStore UserStore, jwtManager *JWTManager) *AuthServer {
	return &AuthServer{userStore, jwtManager}
}

// Login function
func (server *AuthServer) Login(ctx context.Context, req *pb.LoginRequest) (*pb.LoginResponse, error) {
	// find the user in the database.
	user, err := server.userStore.GetUserByEmail(req.GetMail())
	if err != nil {
		return nil, err
	}

	// check if the password is correct
	if user == nil || user.validatePassword(req.GetPassword()) != nil {
		return nil, status.Errorf(codes.NotFound, "invalid username or password")
	}

	// generate JWT token
	accessToken, err := server.jwtManager.GenerateAccessToken(user) // create a new token
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// generate refresh toke
	refreshToken, err := server.jwtManager.GenerateRefreshToken(user) // create a new token
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// get userclaims from the token so we could get the expire time.
	userClaims, err := server.jwtManager.VerifyAccessToken(accessToken)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// save the refresh token in the database.
	if server.userStore.SetRefreshToken(user.Email, refreshToken) != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// grant user his daily bonus if he should
	server.userStore.DailyBonus(user.Email)

	log.WithFields(logrus.Fields{
		"email": user.Email}).Info("Login")

	// sending a new JWT token, expire time, new refresh token.
	res := &pb.LoginResponse{AccessToken: accessToken, ExpiresOn: userClaims.ExpiresAt, RefreshToken: refreshToken}
	return res, nil
}

// RefreshToken function
func (server *AuthServer) RefreshToken(ctx context.Context, req *pb.RefreshTokenRequest) (*pb.LoginResponse, error) {

	// get the userclims from the refresh token
	userClaims, err := server.jwtManager.VerifyRefreshToken(req.GetRefreshToken())
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// get the user from the userclaims.
	user, err := server.userStore.GetUserByEmail(userClaims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// verify refresh token against database.
	if user.RefreshToken != req.GetRefreshToken() {
		return nil, status.Errorf(codes.Internal, "")
	}

	// generate JWT token
	accessToken, err := server.jwtManager.GenerateAccessToken(user)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// generate refresh token
	refreshToken, err := server.jwtManager.GenerateRefreshToken(user) // create a new token
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// get the userclims from the accessToken token
	userClaims, err = server.jwtManager.VerifyAccessToken(accessToken)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	// sending a new JWT token, expire time, new refresh token.
	res := &pb.LoginResponse{AccessToken: accessToken, ExpiresOn: userClaims.ExpiresAt, RefreshToken: refreshToken}
	return res, nil

}

// Register creates a new user.
func (server *AuthServer) Register(ctx context.Context, req *pb.RegisterRequest) (*pb.StatusResponse, error) {

	user, err := NewUser(req.GetFirstName(), req.GetLastName(), req.GetMail(), req.GetPassword(), "user")

	if err != nil {
		return nil, err
	}

	passwordValidator := validator.New(validator.MinLength(5, status.Errorf(codes.InvalidArgument, "password is too short")), validator.ContainsAtLeast("~<=>+-@!#$%^&*", 1, status.Errorf(codes.InvalidArgument, "password must contains at least 1 special character")), validator.CommonPassword(nil), validator.Similarity([]string{req.GetFirstName(), req.GetLastName(), req.GetMail()}, nil, nil))
	err = passwordValidator.Validate(req.GetPassword())
	if err != nil {
		//panic(err)
		return nil, err
	}

	if !isEmailValid(req.GetMail()) {
		return nil, status.Errorf(codes.InvalidArgument, "not a valid email")
	}

	err = server.userStore.AddUser(user)
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}

// isEmailValid checks if the email provided passes the required structure
// and length test. It also checks the domain has a valid MX record.
func isEmailValid(e string) bool {
	var emailRegex = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")

	if len(e) < 3 && len(e) > 254 {
		return false
	}
	if !emailRegex.MatchString(e) {
		return false
	}
	parts := strings.Split(e, "@")
	mx, err := net.LookupMX(parts[1])
	if err != nil || len(mx) == 0 {
		return false
	}
	return true
}
