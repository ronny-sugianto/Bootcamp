package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
	"mylabstudio.info/mygorm/models"
)

func main() {
	db, _ := gorm.Open("sqlite3", "test.db")
	defer db.Close()
	db.Exec("DROP TABLE products;")
	db.AutoMigrate(&models.Product{})

	db.Create(&models.Product{Code: "ABC123", Price: 1000})
	db.Create(&models.Product{Code: "ABC456", Price: 3000})
	db.Create(&models.Product{Code: "ABC009", Price: 2750})

};
