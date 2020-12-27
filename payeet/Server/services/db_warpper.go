package services

import (
	"context"
	"log"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

// UserStore is an interface handels storing users.
type UserStore interface {

	// save a new user to the storge.
	AddUser(user *User) error

	Connect() error
	Disconnect() error
	GetUserByEmail(mail string) (*User, error)
	GetAllUsers() (a []*User, err error)

	SetRefreshToken(email string, refreshToken string) error
	SetBalance(email string, balance int) error
	GetBalance(email string) (int, error)
}

// MongoUserStore is a warpper for mongodb
type MongoUserStore struct {
	UsersCollection *mongo.Collection
	Client          *mongo.Client
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

// NewMongoUserStore d
func NewMongoUserStore(ConnectionString, DBName, CollectionName string) *MongoUserStore {

	client, err := mongo.NewClient(options.Client().ApplyURI(ConnectionString))
	if err != nil {
		log.Fatal(err)
	}

	return &MongoUserStore{
		UsersCollection: client.Database(DBName).Collection(CollectionName),
		Client:          client,
	}
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

// GetUserByEmail finds a user in the database that have the given email.
func (store *MongoUserStore) GetUserByEmail(mail string) (*User, error) {

	result := &User{}

	err := store.UsersCollection.FindOne(context.TODO(), bson.M{"Email": mail}).Decode(&result)
	if err != nil {
		return nil, err
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
