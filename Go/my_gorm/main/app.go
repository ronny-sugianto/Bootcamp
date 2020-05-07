package main

import (
	"fmt"
	"os"

	_ "github.com/jinzhu/gorm/dialects/sqlite"
	"github.com/spf13/viper"
	"mylabstudio.info/mygorm/main/config"
	"mylabstudio.info/mygorm/repositories"
)

func main() {
	viper.SetConfigName("config")
	viper.SetConfigType("yml")
	viper.AddConfigPath(".")
	viper.SetEnvPrefix("app")
	viper.AutomaticEnv()

	var c config.Configurations

	if err := viper.ReadInConfig(); err != nil {
		fmt.Printf("Error reading config file, %s", err)
	} else {
		err := viper.Unmarshal(&c)
		if err != nil {
			fmt.Printf("Unable to decode into struct, %v", err)
		}
		connInit := repositories.DriverInfo(c.DbDialect, c.DbSource)
		conn, err := connInit.Connect()
		if err != nil {
			fmt.Println(err)
			os.Exit(-1)
		}
		defer connInit.Close(conn)
		selectedProduct := repositories.NewProductRepo(conn.Sql)
		product, err := selectedProduct.GetProductById("ABC123")
		fmt.Println(product.Code, product.Price)

		productList, err := selectedProduct.GetAllProduct()
		fmt.Println((*productList)[1])
	}

}
 ?