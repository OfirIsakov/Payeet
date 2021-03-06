package services

import (
	"context"
	"fmt"
	pb "galil-maaravi-802-payeet/payeet/Server/protos"
	"sort"
	"time"

	log "github.com/sirupsen/logrus"

	codes "google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// PayeetServer is the logic for the server
type PayeetServer struct {
	mongoDBWrapper MongoDBWrapper
	jwtManager     *JWTManager
	ProfileImages  []string
}

// NewPayeetServer creates a logic server
func NewPayeetServer(mongoDBWrapper MongoDBWrapper, jwtManager *JWTManager, ProfileImages []string) *PayeetServer {
	return &PayeetServer{mongoDBWrapper, jwtManager, ProfileImages}
}

//GetProfileImages returns the profile images from the config.
func (server *PayeetServer) GetProfileImages(ctx context.Context, in *pb.ImagesRequest) (*pb.ImagesResponse, error) {

	return &pb.ImagesResponse{Images: server.ProfileImages}, nil
}

// GetBalance returns the blances of the user.
func (server *PayeetServer) GetBalance(ctx context.Context, in *pb.BalanceRequest) (*pb.BalanceResponse, error) {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	// get the balance of the user with the email from claims.
	balance, err := server.mongoDBWrapper.GetBalance(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Something went wrong while fetching balance!")
	}

	log.WithFields(log.Fields{"balance": balance, "user": claims.Email}).Info()
	return &pb.BalanceResponse{Balance: fmt.Sprint(balance)}, nil
}

// TransferBalance moves balance from one user to another.
func (server *PayeetServer) TransferBalance(ctx context.Context, in *pb.TransferRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	if in.GetReceiverMail() == claims.Email {
		return nil, status.Errorf(codes.InvalidArgument, "Same mail used")
	}

	// get the balance of the user with the email from claims.
	senderBalance, err := server.mongoDBWrapper.GetBalance(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Cant get balance")
	}

	if int(in.GetAmount()) < 0 {
		return nil, status.Errorf(codes.InvalidArgument, "Amount cant be below zero")
	}

	if senderBalance >= int(in.GetAmount()) {
		recvBalance, err := server.mongoDBWrapper.GetBalance(in.GetReceiverMail())
		if err != nil {
			return nil, status.Errorf(codes.InvalidArgument, "No such user")
		}

		senderBalance = senderBalance - int(in.GetAmount())
		recvBalance = recvBalance + int(in.GetAmount())

		// create a doc in the transaction collecion.
		transaction := &Transaction{
			Sender:   claims.Email,
			Receiver: in.GetReceiverMail(),
			Amount:   int(in.GetAmount()),
			Time:     time.Now().Unix()}

		server.mongoDBWrapper.AddTransaction(transaction)

		// update the fields.
		server.mongoDBWrapper.SetBalance(in.GetReceiverMail(), recvBalance)
		server.mongoDBWrapper.SetBalance(claims.Email, senderBalance)

		log.WithFields(log.Fields{"ReceiverBalance": recvBalance, "SenderBalance": senderBalance, "Sender": claims.Email, "Receiver": in.GetReceiverMail(), "Amount": in.GetAmount()}).Infof("Transfered")

	} else {
		return nil, status.Errorf(codes.Aborted, "Insufficient balance")
	}

	return &pb.StatusResponse{}, nil
}

// GetUserInfo returns the blances of the user.
func (server *PayeetServer) GetUserInfo(ctx context.Context, in *pb.UserInfoRequest) (*pb.UserInfoResponse, error) {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	user, err := server.mongoDBWrapper.GetUserByEmail(claims.Email)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "")
	}

	return &pb.UserInfoResponse{FirstName: user.FirstName, LastName: user.LastName, Mail: user.Email, ImageID: int64(user.ImageID)}, nil
}

// AddFriend adds a friend to the user
func (server *PayeetServer) AddFriend(ctx context.Context, in *pb.AddFriendRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	err = server.mongoDBWrapper.AddFriend(claims.Email, in.GetMail())
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}

// RemoveFriend removes a friend from the user
func (server *PayeetServer) RemoveFriend(ctx context.Context, in *pb.RemoveFriendRequest) (*pb.StatusResponse, error) {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(ctx)
	if err != nil {
		return nil, err
	}

	err = server.mongoDBWrapper.RemoveFriend(claims.Email, in.GetMail())
	if err != nil {
		return nil, err
	}

	return &pb.StatusResponse{}, nil
}

// SearchFriend gets a sub mail and returns a stream of mails
func (server *PayeetServer) SearchFriend(in *pb.SearchFriendRequest, stream pb.Payeet_SearchFriendServer) error {
	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	mails, err := server.mongoDBWrapper.GetMailsByStart(in.GetSearch())
	if err != nil {
		return err
	}

	for _, mail := range mails {
		if mail != claims.Email {

			user, _ := server.mongoDBWrapper.GetUserByEmail(mail)

			stream.Send(&pb.GenericUser{Mail: mail, ImageID: int64(user.ImageID)})
		}
	}

	return nil
}

// GetFullHistory sends the full message history of the user if the requster is him or someone that follows him
func (server *PayeetServer) GetFullHistory(in *pb.HistoryRequest, stream pb.Payeet_GetFullHistoryServer) error {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	user, err := server.mongoDBWrapper.GetUserByEmail(claims.Email)
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
	transfers, err := server.mongoDBWrapper.GetFullHistory(in.SenderMail)
	if err != nil {
		return status.Errorf(codes.Internal, "Something went wrong!")
	}

	for _, transfer := range transfers {
		stream.Send(&pb.HistoryResponse{SenderMail: transfer.Sender, ReceiverMail: transfer.Receiver, Amount: int32(transfer.Amount), Time: transfer.Time})
	}
	return nil
}

// GetFriends returns all the user's friends as a stream
func (server *PayeetServer) GetFriends(in *pb.GetFriendsRequest, stream pb.Payeet_GetFriendsServer) error {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return status.Errorf(codes.Internal, err.Error())
	}

	user, err := server.mongoDBWrapper.GetUserByEmail(claims.Email)
	if err != nil {
		return status.Errorf(codes.Internal, err.Error())
	}

	for _, friend := range user.Friends {
		f, err := server.mongoDBWrapper.GetUserByEmail(friend)
		if err != nil {
			continue
		}
		err = stream.Send(&pb.GenericUser{Mail: friend, ImageID: int64(f.ImageID)})
		if err != nil {
			return status.Errorf(codes.Internal, "Could not send friend")
		}
	}

	return nil
}

// GetFollowers returns a stream of all the users that follow the requeseter
func (server *PayeetServer) GetFollowers(in *pb.GetFollowersRequest, stream pb.Payeet_GetFollowersServer) error {

	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	followers, err := server.mongoDBWrapper.GetFollowers(claims.Email)
	if err != nil {
		return err
	}

	for _, follower := range followers {
		user, _ := server.mongoDBWrapper.GetUserByEmail(follower)
		err = stream.Send(&pb.GenericUser{Mail: follower, ImageID: int64(user.ImageID)})
		if err != nil {
			return status.Errorf(codes.Internal, "Error while trying to send the stream message")
		}
	}

	return nil
}

// GetTopUsers returns the 3 users with the most balance in the database.
func (server *PayeetServer) GetTopUsers(ctx context.Context, in *pb.TopUsersRequest) (*pb.TopUsersResponse, error) {

	users, err := server.mongoDBWrapper.GetAllUsers()
	if err != nil {
		return nil, err
	}

	sort.Slice(users, func(i, j int) bool {
		return users[i].Balance > users[j].Balance
	})

	response := []*pb.UserInfoResponse{}

	// Append the user to the response list, empty if less than 3 users in the DB
	for i := 0; i < 3; i++ {
		if i >= len(users) {
			response = append(response, &pb.UserInfoResponse{FirstName: "", LastName: "", Mail: ""})
		} else {
			response = append(response, &pb.UserInfoResponse{FirstName: users[i].FirstName, LastName: users[i].LastName, Mail: users[i].Email})
		}
	}

	return &pb.TopUsersResponse{Users: response}, nil
}

// GetFiveFriendsTransfers returns the 5 latest friend's transactions of the user
func (server *PayeetServer) GetFiveFriendsTransfers(in *pb.FiveFriendsHistoryRequest, stream pb.Payeet_GetFiveFriendsTransfersServer) error {
	// get the claims from ctx.
	claims, err := server.jwtManager.ExtractClaims(stream.Context())
	if err != nil {
		return err
	}

	transactions, err := server.mongoDBWrapper.GetFiveFriendsTransfers(claims.Email)
	if err != nil {
		return status.Errorf(codes.Internal, "Something went wrong!")
	}

	for _, transaction := range transactions {
		stream.Send(&pb.HistoryResponse{SenderMail: transaction.Sender, ReceiverMail: transaction.Receiver, Amount: int32(transaction.Amount), Time: transaction.Time})
	}

	return nil
}
