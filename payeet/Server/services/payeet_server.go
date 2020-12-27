package services

import (
	"context"
	"fmt"
	pb "galil-maaravi-802-payeet/payeet/protos/go"

	codes "google.golang.org/grpc/codes"
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

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "%v", err)
	}

	// get the balance of the user with the email from claims.
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

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "%v", err)
	}

	user, err := s.userStore.GetUserByEmail(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "%v", err)
	}

	return &pb.UserInfoResponse{FirstName: user.FirstName, LastName: user.LastName, User_ID: user.Email}, nil
}
