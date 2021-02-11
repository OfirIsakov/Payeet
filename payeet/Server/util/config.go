package util

import (
	"reflect"
	"strings"

	log "github.com/sirupsen/logrus"

	"github.com/spf13/viper"
)

// Config holds the config data
type Config struct {
	Port                  string `mapstructure:"PORT"`
	AccessTokenKey        string `mapstructure:"ACCESS_TOKEN_KEY"`
	RefreshTokenKey       string `mapstructure:"REFRESH_TOKEN_KEY"`
	AccessTokenDuration   string `mapstructure:"ACCESS_TOKEN_DURATION"`
	RefreshTokenDuration  string `mapstructure:"REFRESH_TOKEN_DURATION"`
	ConnectionString      string `mapstructure:"CONNECTION_STRING"`
	DBName                string `mapstructure:"DB_NAME"`
	UserCollection        string `mapstructure:"USER_COLLECTION"`
	TransactionCollection string `mapstructure:"TRANSACTION_COLLECTION"`
}

func BindEnvs(iface interface{}, parts ...string) {
	ifv := reflect.ValueOf(iface)
	ift := reflect.TypeOf(iface)
	for i := 0; i < ift.NumField(); i++ {
		v := ifv.Field(i)
		t := ift.Field(i)
		tv, ok := t.Tag.Lookup("mapstructure")
		if !ok {
			continue
		}
		switch v.Kind() {
		case reflect.Struct:
			BindEnvs(v.Interface(), append(parts, tv)...)
		default:
			viper.BindEnv(strings.Join(append(parts, tv), "."))
		}
	}
}

// LoadConfig is used to load the config from the config file.
func LoadConfig(path string) (c Config, err error) {
	log.Infof("Loading config...")

	viper.AddConfigPath(path)
	viper.SetConfigName("config")
	viper.SetConfigType("env")
	BindEnvs(c)
	if viper.ReadInConfig() != nil {
		return
	}
	if viper.Unmarshal(&c) != nil {
		return
	}

	log.Infof("Done! ✅")
	return

}
