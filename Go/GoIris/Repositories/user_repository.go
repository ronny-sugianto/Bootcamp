package Repositories

import (
	"GoIris/Models"
	"fmt"
	"github.com/jinzhu/gorm"
)

type userRepo struct {
	Conn *gorm.DB
}

func User(Conn *gorm.DB) *userRepo {
	return &userRepo{
		Conn: Conn,
	}
}
func (user *userRepo) GetAllUser() (*[]Models.User, error) {
	userList := new([]Models.User)
	result := user.Conn.Find(&userList)
	return userList,result.Error
}
func (user *userRepo) GetUserByID(id string) (*Models.User,error) {
	userList := new(Models.User)
	result := user.Conn.First(&userList,"ID = ?",id)
	return userList,result.Error
}
func (user *userRepo) AddUser(data *Models.User) (*Models.User,error) {
	err := user.Conn.Table("users").Create(&data).Error

	if err != nil {
		fmt.Errorf("[UserRepoImpl.SignUp] Error when trying to create use error is : %v\n", err)
		return nil, err
	}
	return data,err
}
func (user *userRepo) UpdateUser(id uint,data *Models.User) (*Models.User,error) {
	err := user.Conn.Debug().Model(&data).Where("ID = ?", id).Updates(data).Error
	println(err != nil)
	if err != nil {
		return nil, fmt.Errorf("Error : %w\n",err)
	}
	return data, nil
}