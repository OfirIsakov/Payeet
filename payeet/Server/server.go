package main

import (
	"log"
	"net"
	"time"

	"galil-maaravi-802-payeet/payeet/Server/services"
	pb "galil-maaravi-802-payeet/payeet/protos/go"

	"google.golang.org/grpc"

	"google.golang.org/grpc/reflection"
)

const (
	// load this from config file!!!!.
	port          = ":6969"
	secretKey     = "secret"
	tokenDuration = 10 * time.Minute
)

func seedUsers(userStore services.UserStore) error {
	err := createUser(userStore, "admin1", "admin", "admin@admin.admin", "secret", "admin")
	if err != nil {
		return err
	}
	return createUser(userStore, "user1", "user", "user@user.user", "secret", "user")
}

func createUser(userStore services.UserStore, firstName string, lastName string, email string, password string, Role string) error {
	user, err := services.NewUser(firstName, lastName, email, password, Role)
	if err != nil {
		return err
	}

	return userStore.AddUser(user)
}

func accessibleRoles() map[string][]string {
	const path = "/payeet.payeet/"
	return map[string][]string{
		path + "TransferBalance": {"user"},
		path + "GetBalance":      {"user"},
	}

}

func main() {
	log.Printf("Starting server on port [%s]", port)

	userStore := services.NewMemoryUserStore()
	jwtManger := services.NewJWTManager(secretKey, tokenDuration)
	authServer := services.NewAuthServer(userStore, jwtManger)
	logic := services.NewPayeetServer()

	err := seedUsers(userStore)
	if err != nil {
		log.Fatal("cannot seed users")
	}

	interceptor := services.NewAuthInterceptor(jwtManger, accessibleRoles())
	srv := grpc.NewServer(
		grpc.UnaryInterceptor(interceptor.Unary()),
	)

	pb.RegisterPayeetAuthServer(srv, authServer)
	pb.RegisterPayeetServer(srv, logic)
	reflection.Register(srv)

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Panic(err)
	}

	log.Printf("Serving... ")
	if e := srv.Serve(lis); e != nil {
		log.Panic(e)
	}

}
