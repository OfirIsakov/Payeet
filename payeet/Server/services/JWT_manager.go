package services

import (
	"fmt"
	"time"

	"github.com/dgrijalva/jwt-go"
)

// JWTManager handels the JWT actions.
type JWTManager struct {
	secretKey     string
	tokenDuration time.Duration
}

/*
UserClaims is a custom JWT claims that contains some user info.
the UserClaims is part of the JWT token.
*/
type UserClaims struct {
	jwt.StandardClaims
	UUID string `json:"uuid"`
	Role string `json:"role"`
}

// NewJWTManager creates a new JWTManager.
func NewJWTManager(secretKey string, duration string) (*JWTManager, error) {

	tokenDuration, err := time.ParseDuration(duration)
	if err != nil {
		return nil, err
	}

	return &JWTManager{secretKey, tokenDuration}, nil
}

// Generate Generate and sings a new token for a given user.
func (manager *JWTManager) Generate(user *User) (string, error) {
	claims := UserClaims{
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(manager.tokenDuration).Unix(),
		},
		UUID: user.uuid,
		Role: user.Role,
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims) // change this to a more secure method!!

	return token.SignedString([]byte(manager.secretKey))
}

// Verify Verifies the given token and returns a UserClaims if valid.
func (manager *JWTManager) Verify(accessToken string) (*UserClaims, error) {

	// add a check if the toekn hasn't expired !!!
	token, err := jwt.ParseWithClaims(
		accessToken,
		&UserClaims{},

		func(token *jwt.Token) (interface{}, error) {
			_, ok := token.Method.(*jwt.SigningMethodHMAC) // change this to a more secure method!!

			if !ok {
				return nil, fmt.Errorf("wrong signing method used")
			}

			return []byte(manager.secretKey), nil
			// if the token uses the same signing method as our server,
			// we send ParseWithClaims the manager's secret key so we can decode it.
		},
	)

	if err != nil {
		return nil, fmt.Errorf("invalid token: %w", err)
	}

	claims, ok := token.Claims.(*UserClaims)

	if !ok {
		return nil, fmt.Errorf("invalid token claims: %w", err)
	}

	return claims, nil

}
