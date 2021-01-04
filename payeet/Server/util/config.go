package util

import (
	"log"

	"github.com/spf13/viper"
)

// Config holds the config data
type Config struct {
	Port                 string `mapstructure:"PORT"`
	AccessTokenKey       string `mapstructure:"ACCESS_TOKEN_KEY"`
	RefreshTokenKey      string `mapstructure:"REFRESH_TOKEN_KEY"`
	AccessTokenDuration  string `mapstructure:"ACCESS_TOKEN_DURATION"`
	RefreshTokenDuration string `mapstructure:"REFRESH_TOKEN_DURATION"`
	ConnectionString     string `mapstructure:"CONNECTION_STRING"`
	DBName               string `mapstructure:"DB_NAME"`
	CollectionName       string `mapstructure:"COLLECTION_NAME"`
}

// LoadConfig is used to load the config from the config file.
func LoadConfig(path string) (config Config, err error) {
	log.Printf("Loading config...")
	viper.AddConfigPath(path)
	viper.SetConfigName("config")
	viper.SetConfigType("env")
	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	err = viper.Unmarshal(&config)
	log.Printf("Done! ✅")
	return

}
