package services

import (
	"fmt"
	"math/rand"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"golang.org/x/crypto/bcrypt"
)

// User struct conains user info.
type User struct {
	FirstName            string   `bson:"FirstName" json:"FirstName"`
	LastName             string   `bson:"LastName" json:"LastName"`
	Email                string   `bson:"Email" json:"Email"`
	Password             string   `bson:"Password" json:"Password"`
	Role                 string   `bson:"Role" json:"Role"`
	Balance              int      `bson:"Balance" json:"Balance"`
	RefreshToken         string   `bson:"RefreshToken" json:"RefreshToken"`
	Friends              []string `bson:"Friends" json:"Friends"`
	DailyLoginMultiplier float64  `bson:"DailyLoginMultiplier" json:"DailyLoginMultiplier"`
	Karma                float64  `bson:"Karma" json:"Karma"`
	VerficationCode      string   `bson:"VerficationCode" json:"VerficationCode"`
	Activated            bool     `bson:"Activated" json:"Activated"`
	LastCodeRequest      int64    `bson:"LastCodeRequest" json:"LastCodeRequest"`
	Identifiers          []string `bson:"Identifiers" json:"Identifiers"`
	ImageID              int      `bson:"ImageID" json:"ImageID"`
}

// NewUser returns a new user.
func NewUser(firstName string, lastName string, email string, password string, Role string, TotalImages int) (*User, error) {

	hashedPassword, err := generatePassword(password)
	if err != nil {
		return nil, fmt.Errorf("cannot hash password")
	}

	code, err := generateNewCode(6)

	if err != nil {
		return nil, fmt.Errorf("cant create verfication code")
	}

	user := &User{
		FirstName:            firstName,
		LastName:             lastName,
		Email:                email,
		Password:             hashedPassword,
		Role:                 Role,
		Balance:              0,
		RefreshToken:         "",
		Friends:              []string{},
		DailyLoginMultiplier: 1.0,
		Karma:                1.0,
		VerficationCode:      code,
		Activated:            false,
		LastCodeRequest:      time.Now().Unix(),
		Identifiers:          []string{},
		ImageID:              rand.Intn(TotalImages),
	}

	return user, nil

}

// the function will perform our hash algorithm on the password and return it
func generatePassword(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", fmt.Errorf("cannot hash password")
	}

	return string(hashedPassword), nil
}

const otpChars = "1234567890"

func generateNewCode(length int) (string, error) {
	buffer := make([]byte, length)
	_, err := rand.Read(buffer)
	if err != nil {
		return "", err
	}

	otpCharsLength := len(otpChars)
	for i := 0; i < length; i++ {
		buffer[i] = otpChars[int(buffer[i])%otpCharsLength]
	}

	return string(buffer), nil
}

func (user *User) validatePassword(password string) error {

	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))

	return err

}

// Clone returns a clone of a user.
func (user *User) Clone() *User {
	return &User{
		FirstName:            user.FirstName,
		LastName:             user.LastName,
		Email:                user.Email,
		Password:             user.Password,
		Role:                 user.Role,
		Balance:              user.Balance,
		RefreshToken:         user.RefreshToken,
		Friends:              user.Friends,
		DailyLoginMultiplier: user.DailyLoginMultiplier,
		Karma:                user.Karma,
		VerficationCode:      user.VerficationCode,
		Activated:            user.Activated,
		LastCodeRequest:      user.LastCodeRequest,
		Identifiers:          user.Identifiers,
		ImageID:              user.ImageID,
	}
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
		{Key: "DailyLoginMultiplier", Value: user.DailyLoginMultiplier},
		{Key: "Karma", Value: user.Karma},
		{Key: "VerficationCode", Value: user.VerficationCode},
		{Key: "Activated", Value: user.Activated},
		{Key: "LastCodeRequest", Value: user.LastCodeRequest},
		{Key: "Identifiers", Value: user.Identifiers},
		{Key: "ImageID", Value: user.ImageID},
	}

	return a
}
