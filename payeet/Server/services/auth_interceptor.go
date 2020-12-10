package services

import (
	"context"
	"log"

	"google.golang.org/grpc"
)

// Is a server intercepor for authentication and autharization
type AuthInterceptor struct {
	jwtManager      *jwtManager
	accessibleRoles map[string][]string
}

// Returns a new auth interceptor
func NewAuthInterceptor(jwtManager *jwtManager, accessibleRole map[string][]string) *AuthInterceptor {
	return &AuthInterceptor{jwtManager, accessibleRole}
}

// Returns a server interceptor function to authenticate and autharize unary RPC
func (interceptor *AuthInterceptor) Unary() grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {
		log.Println("[DEBUG] This is the UNARY interceptor: ", info.FullMthod)
		return handler(ctx, req)
	}
}

// Returns a server interceptor function to authenticate and autharize stream RPC
func (interceptor *AuthInterceptor) Stream() grpc.StreamServerInterceptor {
	return func(
		srv interface{},
		stream grpc.ServerStream,
		info *grpc.StreamServerInfo,
		handler grpc.StreamHandler,
	) (interface{}, error) {
		log.Println("[DEBUG] This is the STREAM interceptor: ", info.FullMthod)
		return handler(srv, stream)
	}
}
