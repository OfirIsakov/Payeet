package main

import (
	"net"

	log "github.com/sirupsen/logrus"

	pb "galil-maaravi-802-payeet/payeet/Server/protos"
	"galil-maaravi-802-payeet/payeet/Server/services"
	"galil-maaravi-802-payeet/payeet/Server/util"

	"google.golang.org/grpc"

	"github.com/joho/godotenv"
	"google.golang.org/grpc/reflection"
)

func accessibleRoles() map[string][]string {
	const path = "/payeet.payeet/"
	return map[string][]string{
		path + "GetUserInfo":     {"user"},
		path + "TransferBalance": {"user"},
		path + "GetBalance":      {"user"},
		path + "SearchFriend":    {"user"},
	}

}

// init is invoked before main()
func init() {
	// loads values from .env into the system
	if err := godotenv.Load("config.env"); err != nil {
		log.Warning("No .env file found")
	}
}

func main() {
	log.SetLevel(log.DebugLevel)
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("❌\n", err)
	}

	userStore := services.NewMongoUserStore(config.ConnectionString, config.DBName, config.UserCollection, config.TransactionCollection)
	log.Info("Connecting to DB...")
	userStore.Connect()
	defer userStore.Disconnect()
	userStore.CheckConnection()
	jwtManger, err := services.NewJWTManager(config.AccessTokenDuration, config.RefreshTokenDuration, config.AccessTokenKey, config.RefreshTokenKey)

	if err != nil {
		log.Fatal("❌\n", err)
	}

	authServer := services.NewAuthServer(userStore, jwtManger)
	logic := services.NewPayeetServer(userStore, jwtManger)

	interceptor := services.NewAuthInterceptor(jwtManger, accessibleRoles())
	srv := grpc.NewServer(
		grpc.UnaryInterceptor(interceptor.Unary()),
	)

	pb.RegisterPayeetAuthServer(srv, authServer)
	pb.RegisterPayeetServer(srv, logic)
	reflection.Register(srv)

	log.Infof("Starting server on port [%s]", config.Port)
	lis, err := net.Listen("tcp", ":"+config.Port)
	if err != nil {
		log.Fatal(err)
	}
	log.Info("Done! ✅")

	log.Info("Serving... 🥳")
	if e := srv.Serve(lis); e != nil {
		log.Fatal("❌\n", e)
	}

}
