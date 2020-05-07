package Drivers

import (
	"fmt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/kataras/iris"
	"log"
	"os"
)

var App = iris.New()

func Connect() *gorm.DB {
	conn := os.Getenv("DB_URL")

	db, err := gorm.Open("postgres", conn)
	if err != nil {
		fmt.Println(err)
		log.Fatal(err)
	}
	return db
}
