package services

import (
	"fmt"
	"time"

	"github.com/dgrijalva/jwt-go"
)

// JWTManager handels the JWT actions.
type JWTManager struct {
	AccessTokenDuration  time.Duration
	RefreshTokenDuration time.Duration
	AccessTokenKey       string
	RefreshTokenKey      string
}

/*
UserClaims is a custom JWT claims that contains some user info.
the UserClaims is part of the JWT token.
*/
type UserClaims struct {
	jwt.StandardClaims
	Email string `json:"email"`
	Role  string `json:"role"`
}

// NewJWTManager creates a new JWTManager.
func NewJWTManager(
	AccessTokenDuration,
	RefreshTokenDuration,
	AccessTokenKey,
	RefreshTokenKey string) (*JWTManager, error) {

	_AccessTokenDuration, err := time.ParseDuration(AccessTokenDuration)
	if err != nil {
		return nil, err
	}

	_RefreshTokenDuration, err := time.ParseDuration(RefreshTokenDuration)
	if err != nil {
		return nil, err
	}

	return &JWTManager{_AccessTokenDuration, _RefreshTokenDuration, AccessTokenKey, RefreshTokenKey}, nil
}

// GenerateAccessToken Generate and sings a new token for a given user.
func (manager *JWTManager) GenerateAccessToken(user *User) (string, error) {
	return manager.Generate(user, manager.AccessTokenDuration, manager.AccessTokenKey)
}

// GenerateRefreshToken Generate and sings a new token for a given user.
func (manager *JWTManager) GenerateRefreshToken(user *User) (string, error) {
	return manager.Generate(user, manager.RefreshTokenDuration, manager.RefreshTokenKey)
}

// Generate creates a token.
func (manager *JWTManager) Generate(user *User, t time.Duration, key string) (string, error) {

	claims := UserClaims{
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(t).Unix(),
		},
		Email: user.Email,
		Role:  user.Role,
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims) // change this to a more secure method!!

	return token.SignedString([]byte(key))
}

// VerifyAccessToken Verifies the given token and returns a UserClaims if valid.
func (manager *JWTManager) VerifyAccessToken(accessToken string) (*UserClaims, error) {

	token, err := jwt.ParseWithClaims(
		accessToken,
		&UserClaims{},

		func(token *jwt.Token) (interface{}, error) {
			_, ok := token.Method.(*jwt.SigningMethodHMAC) // change this to a more secure method!!

			if !ok {
				return nil, fmt.Errorf("wrong signing method used")
			}

			return []byte(manager.AccessTokenKey), nil
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

// VerifyRefreshToken Verifies the given token and returns a UserClaims if valid.
func (manager *JWTManager) VerifyRefreshToken(RefreshToken string) (*UserClaims, error) {

	token, err := jwt.ParseWithClaims(
		RefreshToken,
		&UserClaims{},

		func(token *jwt.Token) (interface{}, error) {
			_, ok := token.Method.(*jwt.SigningMethodHMAC) // change this to a more secure method!!

			if !ok {
				return nil, fmt.Errorf("wrong signing method used")
			}

			return []byte(manager.RefreshTokenKey), nil
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
