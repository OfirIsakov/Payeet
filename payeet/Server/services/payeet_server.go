package services

import (
	"context"
	"fmt"
	pb "galil-maaravi-802-payeet/payeet/protos/go"

	codes "google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

// PayeetServer is the logic for the server
type PayeetServer struct {
	userStore  UserStore
	jwtManager *JWTManager
}

// NewPayeetServer creates a logic server
func NewPayeetServer(userStore UserStore, jwtManager *JWTManager) *PayeetServer {
	return &PayeetServer{userStore, jwtManager}
}

// GetBalance returns the blances of the user.
func (s *PayeetServer) GetBalance(ctx context.Context, in *pb.BalanceRequest) (*pb.BalanceResponse, error) {

	// get the email from requetst.

	metaData, ok := metadata.FromIncomingContext(ctx) // extract metadata form ctx
	if !ok {
		return nil, status.Errorf(codes.Unauthenticated, "metadata not provided")
	}

	values := metaData["authorization"] // check if the user provided a token
	if len(values) == 0 {
		return nil, status.Errorf(codes.Unauthenticated, "authorization token is not provided")
	}

	accessToken := values[0]                                   // the access token is always in the first cell
	claims, err := s.jwtManager.VerifyAccessToken(accessToken) // check if the token is valid
	if err != nil {
		return nil, status.Errorf(codes.Unauthenticated, "access token is invalid %v", err)
	}

	balance, err := s.userStore.GetBalance(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cant get balance %v", err)
	}

	return &pb.BalanceResponse{Balance: fmt.Sprint(balance)}, nil
}

// TransferBalance moves balance from one user to another.
func (s *PayeetServer) TransferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}

// GetUserInfo returns the blances of the user.
func (s *PayeetServer) GetUserInfo(ctx context.Context, in *pb.UserInfoRequest) (*pb.UserInfoResponse, error) {

	return &pb.UserInfoResponse{FirstName: "aaa", LastName: "aaa", User_ID: "dddd"}, nil
}
