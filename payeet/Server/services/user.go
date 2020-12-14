package services

import (
	"crypto/sha256"
	"encoding/hex"
	"errors"

	"github.com/google/uuid"
)

// User struct conains user info.
type User struct {
	uuid      string
	firstName string
	lastName  string
	salt      string
	email     string
	password  string
	Role      string
}

// NewUser returns a new user.
func NewUser(firstName string, lastName string, email string, password string, Role string) (*User, error) {
	salt := genSalt()

	hp := hashPassword(password, salt)

	user := &User{
		uuid:      getUUID(),
		firstName: firstName,
		lastName:  lastName,
		salt:      salt,
		email:     email,
		password:  hp,
		Role:      Role}

	return user, nil

}

func genSalt() string {
	salt := uuid.New().String()

	return salt
}

func getUUID() string {
	u := uuid.New().String()
	// check if the uuid is being used already

	// if you are genarting one uuid every sec you will need 1 billion years for it to dupe.

	// if not return it
	return u
}

func hashPassword(password string, salt string) string {

	h := sha256.New()
	h.Write([]byte(password))
	h.Write([]byte(salt)) // adding the salt to the password.

	return hex.EncodeToString(h.Sum(nil))

}

func (user *User) validatePassword(password string) error {

	if hashPassword(password, user.salt) == user.password {
		return nil
	}
	return errors.New("passwords do not match")

}

// Clone returns a clone of a user.
func (user *User) Clone() *User {
	return &User{
		uuid:      user.uuid,
		firstName: user.firstName,
		lastName:  user.lastName,
		email:     user.email,
		salt:      user.salt,
		password:  user.password,
		Role:      user.Role}
}
