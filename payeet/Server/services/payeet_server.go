package services

import (
	"context"
	pb "galil-maaravi-802-payeet/payeet/protos/go"
)

// PayeetServer is the logic for the server
type PayeetServer struct {
	pb.UnimplementedPayeetServer
}

// NewPayeetServer creates a logic server
func NewPayeetServer() *PayeetServer {
	return &PayeetServer{}
}

// GetBalance returns the blances of the user.
func (s *PayeetServer) GetBalance(ctx context.Context, in *pb.BalanceRequest) (*pb.BalanceResponse, error) {

	return &pb.BalanceResponse{Balance: "100"}, nil
}

// TransferBalance moves balance from one user to another.
func (s *PayeetServer) TransferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}
