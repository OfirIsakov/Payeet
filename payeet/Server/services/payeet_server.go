package services

import (
	"context"
	"fmt"
	pb "galil-maaravi-802-payeet/payeet/Server/protos"
	"time"

	log "github.com/sirupsen/logrus"

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
		return nil, status.Errorf(codes.Internal, "cant get balance")
	}

	log.WithFields(log.Fields{"balance": balance, "user": claims.Email}).Info()
	return &pb.BalanceResponse{Balance: fmt.Sprint(balance)}, nil
}

// TransferBalance moves balance from one user to another.
func (s *PayeetServer) TransferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "%v", err)
	}

	if in.GetReceiverMail() == claims.Email {
		return nil, status.Errorf(codes.InvalidArgument, "same mail used.")
	}

	// get the balance of the user with the email from claims.
	senderBalance, err := s.userStore.GetBalance(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "cant get balance")
	}

	if int(in.GetAmount()) < 0 {
		return nil, status.Errorf(codes.InvalidArgument, "amount cant be below zero")
	}

	if senderBalance >= int(in.GetAmount()) {

		recvBalance, err := s.userStore.GetBalance(in.GetReceiverMail())
		if err != nil {
			return nil, status.Errorf(codes.InvalidArgument, "no such user.")
		}

		senderBalance = senderBalance - int(in.GetAmount())
		recvBalance = recvBalance + int(in.GetAmount())

		// create a doc in the transaction collecion.
		t := &Transaction{
			Sender:   claims.Email,
			Receiver: in.GetReceiverMail(),
			Amount:   int(in.GetAmount()),
			Time:     time.Now().Unix()}

		s.userStore.AddTransaction(t)

		// update the fields.
		s.userStore.SetBalance(in.GetReceiverMail(), recvBalance)
		s.userStore.SetBalance(claims.Email, senderBalance)

		log.WithFields(log.Fields{"ReceiverBalance": recvBalance, "SenderBalance": senderBalance, "Sender": claims.Email, "Receiver": in.GetReceiverMail()}).Infof("transfered $%v", in.GetAmount())

		//log.Infof("➤ transfered $%v \n%s --> %s", in.GetAmount(), claims.Email, in.GetReceiverMail())

	} else {
		log.Println("Transfer aborted insufficient balance in " + claims.Email + "'s account")

		return nil, status.Errorf(codes.Aborted, "insufficient balance")
	}

	return &pb.StatusResponse{}, nil
}

// GetUserInfo returns the blances of the user.
func (s *PayeetServer) GetUserInfo(ctx context.Context, in *pb.UserInfoRequest) (*pb.UserInfoResponse, error) {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	user, err := s.userStore.GetUserByEmail(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	return &pb.UserInfoResponse{FirstName: user.FirstName, LastName: user.LastName, Friends: user.Friends, User_ID: user.Email}, nil
}

// AddFriend adds a friend to the user
func (s *PayeetServer) AddFriend(ctx context.Context, in *pb.AddFriendRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	err = s.userStore.AddFriend(claims.Email, in.GetMail())
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}

// RemoveFriend removes a friend from the user
func (s *PayeetServer) RemoveFriend(ctx context.Context, in *pb.RemoveFriendRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	err = s.userStore.RemoveFriend(claims.Email, in.GetMail())
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}
