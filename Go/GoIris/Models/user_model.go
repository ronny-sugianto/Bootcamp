package Models

import "github.com/jinzhu/gorm"

type User struct {
	*gorm.Model
	Name string	`json: "name"`
	Password string `json: "password"`
}