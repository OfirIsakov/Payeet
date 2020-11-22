package main

import (
	"context"
	"net"
	pb "payeet/protos/go"

	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type server struct {
	pb.UnimplementedPayeetServer
}

func main() {
	lis, err := net.Listen("tcp", ":6969")
	if err != nil {
		panic(err)
	}

	srv := grpc.NewServer()
	pb.RegisterPayeetServer(srv, &server{})
	reflection.Register(srv)

	if e := srv.Serve(lis); e != nil {
		panic(e)
	}

}

func (s *server) login(ctx context.Context, in *pb.LoginRequest) (*pb.LoginResponse, error) {

	return &pb.LoginResponse{}, nil
}

func (s *server) loginS(ctx context.Context, in *pb.LoginRequest_S) (*pb.LoginResponse, error) {

	return &pb.LoginResponse{}, nil
}

func (s *server) register(ctx context.Context, in *pb.RegisterRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}

func (s *server) getBalance(ctx context.Context, in *pb.BalanceRequest) (*pb.BalanceResponse, error) {

	return &pb.BalanceResponse{}, nil
}

func (s *server) transferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}
