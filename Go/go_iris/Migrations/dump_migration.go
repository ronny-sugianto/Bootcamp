package main

import (
	"gakudev.net/iris/Models"
	"github.com/jinzhu/gorm"
)

func main() {
	db, _ := gorm.Open("sqlite3", "apps.db")
	defer db.Close()

	db.Exec("DROP TABLE users;")
	db.AutoMigrate(&Models.Users{})

	db.Create(&Models.Users{Email: "ronnysugianto.id@gmail.com",Password: "admin"})
}
