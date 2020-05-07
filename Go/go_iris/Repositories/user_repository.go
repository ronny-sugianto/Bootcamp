package Repositories

import (
	"gakudev.net/iris/Models"
	"github.com/jinzhu/gorm"
)

type userRepo struct {
	Conn *gorm.DB
}


func (user *userRepo) GetAllUser() (*[]Models.Users, error) {
	userList := new([]Models.Users)
	result := user.Conn.Find(&userList)
	return userList,result.Error
}

func (user *userRepo) GetUserById(id string) (*Models.Users, error) {
	userList := new(Models.Users)
	result := user.Conn.First(&user, "id = ?",id)
	return userList,result.Error
}
func AddUser(Conn *gorm.DB) *userRepo {
	return &userRepo{
		Conn: Conn,
	}
}
