package services

import (
	"context"

	"github.com/sirupsen/logrus"
	log "github.com/sirupsen/logrus"

	pb "galil-maaravi-802-payeet/payeet/Server/protos"

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

	// add checks for password requirements

	if err != nil {
		return nil, err
	}

	err = server.userStore.AddUser(user)
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}
