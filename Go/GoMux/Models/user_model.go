package Models

import "github.com/jinzhu/gorm"

type Users struct {
	gorm.Model
	Email string
	Password string
}
//func (u Users) TableName() string {
//	return "user"
//}