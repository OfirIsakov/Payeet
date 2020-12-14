package services

import (
	"context"
	"log"

	"google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

//AuthInterceptor Is a server intercepor for authentication and autharization
type AuthInterceptor struct {
	jwtManager      *JWTManager
	accessibleRoles map[string][]string
}

//NewAuthInterceptor Returns a new auth interceptor
func NewAuthInterceptor(jwtManager *JWTManager, accessibleRole map[string][]string) *AuthInterceptor {
	return &AuthInterceptor{jwtManager, accessibleRole}
}

//Unary Returns a server interceptor function to authenticate and authorize unary RPC
func (interceptor *AuthInterceptor) Unary() grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {

		log.Println("[DEBUG] Call to RPC --→ ", info.FullMethod)
		err := interceptor.authorize(ctx, info.FullMethod)
		if err != nil {
			return nil, err
		}

		return handler(ctx, req)
	}
}

// //Stream Returns a server interceptor function to authenticate and authorize stream RPC
// func (interceptor *AuthInterceptor) Stream() grpc.StreamServerInterceptor {
// 	return func(
// 		srv interface{},
// 		stream grpc.ServerStream,
// 		info *grpc.StreamServerInfo,
// 		handler grpc.StreamHandler,
// 	) (interface{}, error) {
// 		log.Println("[DEBUG] This is the STREAM interceptor: ", info.FullMethod)

// 		err := interceptor.authorize(stream.Context(), info.FullMethod)
// 		if err != nil {
// 			return nil, err
// 		}

// 		return handler(srv, stream)
// 	}
// }

func (interceptor *AuthInterceptor) authorize(ctx context.Context, method string) error {
	accessibleRoles, ok := interceptor.accessibleRoles[method]
	if !ok { // check if everyone can access the method
		return nil
	}

	metaData, ok := metadata.FromIncomingContext(ctx) // extract metadata form ctx
	if !ok {
		return status.Errorf(codes.Unauthenticated, "metadata not provided")
	}

	values := metaData["authorization"] // check if the user provided a token
	if len(values) == 0 {
		return status.Errorf(codes.Unauthenticated, "authorization token is not provided")
	}

	accessToken := values[0]                                  // the access token is always in the first cell
	claims, err := interceptor.jwtManager.Verify(accessToken) // check if the token is valid
	if err != nil {
		return status.Errorf(codes.Unauthenticated, "access token is invalid %v", err)
	}

	// check if the user has a role
	for _, role := range accessibleRoles {
		if role == claims.Role {
			return nil // reutrn nil to authorize the
		}
	}

	return status.Errorf(codes.Unauthenticated, "no permission to access this RPC")
}
