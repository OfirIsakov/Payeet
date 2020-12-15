package services

import (
	"context"

	pb "galil-maaravi-802-payeet/payeet/protos/go"

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
	user, err := server.userStore.FindWithMail(req.GetMail())
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cannot find user: %v", err)
	}

	if user == nil || user.validatePassword(req.GetPassword()) != nil {
		return nil, status.Errorf(codes.NotFound, "invalid username or password")
	}

	token, err := server.jwtManager.Generate(user) // create a new token
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cannot generate access token")
	}

	res := &pb.LoginResponse{FirstName: user.firstName, LastName: user.lastName, Session: token, User_ID: user.uuid}
	return res, nil
}

// LoginS function
func (server *AuthServer) LoginS(ctx context.Context, req *pb.LoginRequest_S) (*pb.LoginResponse, error) {

	userClaims, err := server.jwtManager.Verify(req.GetSession())
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cannot verify access token")
	}

	user, err := server.userStore.FindWithUUID(userClaims.UUID)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cannot find user: %v", err)
	}

	token, err := server.jwtManager.Generate(user) // create a new token
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cannot generate access token")
	}

	res := &pb.LoginResponse{FirstName: user.firstName, LastName: user.lastName, Session: token, User_ID: user.uuid}
	return res, nil

}

// Register creates a new user.
func (server *AuthServer) Register(ctx context.Context, req *pb.RegisterRequest) (*pb.StatusResponse, error) {

	user, err := NewUser(req.GetFirstName(), req.GetLastName(), req.GetMail(), req.GetPassword(), "user")

	// add checks for password requirements

	if err != nil {
		return nil, err
	}

	server.userStore.AddUser(user)
	return &pb.StatusResponse{}, nil
}
