package services

import (
	"context"

	log "github.com/sirupsen/logrus"

	"go.mongodb.org/mongo-driver/mongo/readpref"
	codes "google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// UserStore is an interface that handles storing users.
type UserStore interface {

	// save a new user to the storge.

	// Add a Transaction

	// get all transactions of the receiver
	// get all transactions of the sender.

	// get all transactions of user. (Sender or Receiver)
	// |---> the tansactions from the functions above and sort them by time.

	// Add a friend
	// Remove a friend

	Connect() error
	Disconnect() error

	AddUser(user *User) error
	AddTransaction(t *Transaction) error

	GetUserByEmail(mail string) (*User, error)
	GetAllUsers() (a []*User, err error)

	SetRefreshToken(email string, refreshToken string) error
	SetBalance(email string, balance int) error
	GetBalance(email string) (int, error)

	AddFriend(mail, friendMail string) error
	RemoveFriend(mail, friendMail string) error
}

// MongoUserStore is a warpper for mongodb
type MongoUserStore struct { // change name to db wapper or something

	// add collection for transactions.

	TransactionsCollection *mongo.Collection
	UsersCollection        *mongo.Collection
	Client                 *mongo.Client
}

// NewMongoUserStore d
func NewMongoUserStore(ConnectionString, DBName, UserCollection, TransactionCollection string) *MongoUserStore {

	client, err := mongo.NewClient(options.Client().ApplyURI(ConnectionString))
	if err != nil {
		log.Fatal(err)
	}

	return &MongoUserStore{
		TransactionsCollection: client.Database(DBName).Collection(TransactionCollection),
		UsersCollection:        client.Database(DBName).Collection(UserCollection),
		Client:                 client,
	}
}

// CheckConnection pings the database.
func (store *MongoUserStore) CheckConnection() {

	err := store.Client.Ping(context.TODO(), readpref.Primary())
	if err != nil {
		log.Fatalf("DB Connection failed.. ❌\n %v", err)
	}

	log.Info("Connected to DB successfully ✅")
}

// Connect makes a connection to the database.
func (store *MongoUserStore) Connect() error {

	err := store.Client.Connect(context.TODO())
	if err != nil {
		return err
	}

	return nil
}

// Disconnect closes the connection to the database.
func (store *MongoUserStore) Disconnect() error {

	err := store.Client.Disconnect(context.TODO())
	if err != nil {
		return err
	}

	return nil
}

// AddUser adds a new user to the database.
func (store *MongoUserStore) AddUser(user *User) error {

	_, err := store.UsersCollection.InsertOne(
		context.TODO(),
		user.ToBson(),
	)

	if err != nil {
		return err
	}

	return nil
}

// AddTransaction adds a new transaction to the transaction collection.
func (store *MongoUserStore) AddTransaction(t *Transaction) error {

	_, err := store.TransactionsCollection.InsertOne(
		context.TODO(),
		t.ToBson(),
	)

	if err != nil {
		return err
	}

	return nil
}

// GetUserByEmail finds a user in the database that have the given email.
func (store *MongoUserStore) GetUserByEmail(mail string) (*User, error) {

	result := &User{}

	err := store.UsersCollection.FindOne(context.TODO(), bson.M{"Email": mail}).Decode(&result)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "Invalid username or password")
	}

	return result, nil
}

// GetAllUsers returns every user stored in the database.
func (store *MongoUserStore) GetAllUsers() (a []*User, err error) {

	cursor, err := store.UsersCollection.Find(
		context.TODO(),
		bson.D{},
	)

	for cursor.Next(context.TODO()) {
		elem := &User{}

		if err := cursor.Decode(elem); err != nil {
			return nil, err
		}

		a = append(a, elem)
	}

	return a, nil

}

//SetRefreshToken makes changes to a field name.
func (store *MongoUserStore) SetRefreshToken(email string, refreshToken string) error {
	return store.ChangeFieldValue(email, "RefreshToken", refreshToken)
}

//SetBalance sets the balance field.
func (store *MongoUserStore) SetBalance(email string, balance int) error {
	return store.ChangeFieldValue(email, "Balance", balance)
}

//ChangeFieldValue sets a new value in the given field name
func (store *MongoUserStore) ChangeFieldValue(email string, fieldName string, value interface{}) error {

	_, err := store.UsersCollection.UpdateOne(
		context.TODO(),
		bson.D{
			{Key: "Email", Value: email},
		},
		bson.D{
			{Key: "$set",
				Value: bson.D{
					{Key: fieldName, Value: value},
				},
			},
		},
	)

	if err != nil {
		return err
	}

	return nil
}

// GetBalance returns the balance of the given user's email.
func (store *MongoUserStore) GetBalance(email string) (int, error) {

	user, err := store.GetUserByEmail(email)
	if err != nil {
		return -1, err
	}

	balance := user.Balance

	return balance, nil
}

// AddFriend gets user's mail and adds the firend mail to the friend list
func (store *MongoUserStore) AddFriend(mail, friendMail string) error {

	// check if tries to add itself
	if mail == friendMail {
		return status.Errorf(codes.Aborted, "Cannot add yourself as friend")
	}

	// check to see if the friend exists
	_, err := store.GetUserByEmail(friendMail)
	if err != nil {
		return err
	}

	user, err := store.GetUserByEmail(mail)
	if err != nil {
		return err
	}

	// check if already a friend with them
	for _, friend := range user.Friends {
		if friend == friendMail {
			return status.Errorf(codes.Aborted, "Already friends!")
		}
	}

	user.Friends = append(user.Friends, friendMail)

	err = store.ChangeFieldValue(mail, "Friends", user.Friends)
	if err != nil {
		return err
	}

	return nil
}

// RemoveFriend gets user's mail and removes the firend mail from the friend list
func (store *MongoUserStore) RemoveFriend(mail, friendMail string) error {

	user, err := store.GetUserByEmail(mail)
	if err != nil {
		return status.Errorf(codes.Internal, "")
	}

	// find the index of the friend mail and remove him, if not found return error
	for i, friend := range user.Friends {
		if friend == friendMail {
			// in order to remove the friend we swap the last element in the friend list with the index we found and discard the last element
			user.Friends[len(user.Friends)-1], user.Friends[i] = user.Friends[i], user.Friends[len(user.Friends)-1]
			user.Friends = user.Friends[:len(user.Friends)-1]

			err = store.ChangeFieldValue(mail, "Friends", user.Friends)
			if err != nil {
				return err
			}

			return nil
		}
	}

	return status.Errorf(codes.NotFound, "No such friend")
}
