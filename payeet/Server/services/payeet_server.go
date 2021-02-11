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

	return &pb.UserInfoResponse{FirstName: user.FirstName, LastName: user.LastName, User_ID: user.Email}, nil
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


// SearchFriend gets a sub mail and returns a stream of mails
func (s *PayeetServer) SearchFriend(in *pb.SearchFriendRequest, stream pb.Payeet_SearchFriendServer) error {
	mails, err := s.userStore.GetMailsByStart(in.GetSearch())
	if err != nil {
		return err
	}

	for _, mail := range mails {
		stream.Send(&pb.SearchFriendResponse{Mail: mail})
	}

	return nil
}

// GetFullSelfHistory is a function that sends the full message history of the user in a stream
func (s *PayeetServer) GetFullSelfHistory(in *pb.HistoryRequest, stream pb.Payeet_GetFullSelfHistoryServer) error {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	user, err := s.userStore.GetUserByEmail(claims.Email)
	if err != nil {
		return err
	}

	// check if the person wants their own history
	if claims.Email != in.SenderMail {
		// check if the person wants the history of someone they follow
		isFriend := false

		for _, friend := range user.Friends {
			if in.SenderMail == friend {
				isFriend = true
				break
			}
		}

		if !isFriend {
			return status.Errorf(codes.Unauthenticated, "Sorry, you must follow the person to get their history!")
		}
	}

	// get the full history of the user
	senderTransfers, senderErr := s.userStore.GetSenderHistory(in.SenderMail)
	receiverTransfers, receiverErr := s.userStore.GetReceiverHistory(in.SenderMail)

	// if both of the functions gave an error return the first one
	if senderErr != nil && receiverErr != nil {
		return senderErr
	}

	// send the history of the functions that succeeded
	if senderErr == nil {
		for _, transfer := range senderTransfers {
			stream.Send(&pb.HistoryResponse{SenderMail: transfer.Sender, ReceiverMail: transfer.Receiver, Amount: int32(transfer.Amount), Time: transfer.Time})
		}
	}
	if receiverErr == nil {
		for _, transfer := range receiverTransfers {
			stream.Send(&pb.HistoryResponse{SenderMail: transfer.Sender, ReceiverMail: transfer.Receiver, Amount: int32(transfer.Amount), Time: transfer.Time})
		}
	}
	return nil
}

// GetFriends returns all the user's friends as a stream
func (s *PayeetServer) GetFriends(in *pb.GetFriendsRequest, stream pb.Payeet_GetFriendsServer) error {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return status.Errorf(codes.Internal, err.Error())
	}

	user, err := s.userStore.GetUserByEmail(claims.Email)
	if err != nil {
		return status.Errorf(codes.Internal, err.Error())
	}

	for _, friend := range user.Friends {
		err = stream.Send(&pb.GetFriendsResponse{Mail: friend})
		if err != nil {
			return status.Errorf(codes.Internal, "Could not send friend")
		}
	}

	return nil
}

// GetFollowers returns a stream of all the users that follow the requeseter
func (s *PayeetServer) GetFollowers(in *pb.GetFollowersRequest, stream pb.Payeet_GetFollowersServer) error {

	// get the claims from ctx.
	claims, err := s.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	followers, err := s.userStore.GetFollowers(claims.Email)
	if err != nil {
		return err
	}

	for _, follower := range followers {
		err = stream.Send(&pb.GetFollowersResponse{Mail: follower})
		if err != nil {
			return status.Errorf(codes.Internal, "Error while trying to send the stream message")
		}
	}

	return nil
}

