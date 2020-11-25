package main

import (
	"context"
	"log"
	"net"

	pb "galil-maaravi-802-payeet/payeet/protos/go"

	"google.golang.org/grpc"

	"google.golang.org/grpc/reflection"
)

const (
	port = ":6969"
)

type server struct {
	pb.UnimplementedPayeetServer
}

func main() {
	lis, err := net.Listen("tcp", port)

	if err != nil {
		panic(err)
	}

	srv := grpc.NewServer()
	pb.RegisterPayeetServer(srv, &server{})
	reflection.Register(srv)
	log.Printf("Serving... ")
	if e := srv.Serve(lis); e != nil {
		panic(e)
	}

}

func (s *server) Login(ctx context.Context, in *pb.LoginRequest) (*pb.LoginResponse, error) {
	log.Printf("login")
	return &pb.LoginResponse{FirstName: "aa", LastName: "aa", Session: "aa", User_ID: "aa"}, nil
}

func (s *server) LoginS(ctx context.Context, in *pb.LoginRequest_S) (*pb.LoginResponse, error) {

	return &pb.LoginResponse{}, nil
}

func (s *server) Register(ctx context.Context, in *pb.RegisterRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}

func (s *server) GetBalance(ctx context.Context, in *pb.BalanceRequest) (*pb.BalanceResponse, error) {

	return &pb.BalanceResponse{}, nil
}

func (s *server) TransferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	return &pb.StatusResponse{}, nil
}
