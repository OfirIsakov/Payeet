package services

import (
	"fmt"

	"go.mongodb.org/mongo-driver/bson"
	"golang.org/x/crypto/bcrypt"
)

// User struct conains user info.
type User struct {
	FirstName    string   `bson:"FirstName" json:"FirstName"`
	LastName     string   `bson:"LastName" json:"LastName"`
	Email        string   `bson:"Email" json:"Email"`
	Password     string   `bson:"Password" json:"Password"`
	Role         string   `bson:"Role" json:"Role"`
	Balance      int      `bson:"Balance" json:"Balance"`
	RefreshToken string   `bson:"RefreshToken" json:"RefreshToken"`
	Friends      []string `bson:"Friends" json:"Friends"`
}

// NewUser returns a new user.
func NewUser(firstName string, lastName string, email string, password string, Role string) (*User, error) {

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, fmt.Errorf("cannot hash password")
	}

	user := &User{
		FirstName:    firstName,
		LastName:     lastName,
		Email:        email,
		Password:     string(hashedPassword),
		Role:         Role,
		Balance:      0,
		RefreshToken: "",
		Friends:      []string{}}

	return user, nil

}

func (user *User) validatePassword(password string) error {

	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))

	return err

}

// Clone returns a clone of a user.
func (user *User) Clone() *User {
	return &User{
		FirstName:    user.FirstName,
		LastName:     user.LastName,
		Email:        user.Email,
		Password:     user.Password,
		Role:         user.Role,
		Balance:      user.Balance,
		RefreshToken: user.RefreshToken,
		Friends:      user.Friends}
}

// ToBson truns a user object into bson
func (user *User) ToBson() bson.D {

	a := bson.D{
		{Key: "FirstName", Value: user.FirstName},
		{Key: "LastName", Value: user.LastName},
		{Key: "Email", Value: user.Email},
		{Key: "Password", Value: user.Password},
		{Key: "Role", Value: user.Role},
		{Key: "Balance", Value: user.Balance},
		{Key: "RefreshToken", Value: user.RefreshToken},
		{Key: "Friends", Value: user.Friends},
	}

	return a
}
