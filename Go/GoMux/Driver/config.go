package Driver

import (
	"github.com/jinzhu/gorm"
	"log"
	"os"
)

func Connect() *gorm.DB{
	conn := os.Getenv("URL")
	db,err := gorm.Open("postgres", conn)
	if err != nil {
		log.Fatal(err)

	}
	return db
}
