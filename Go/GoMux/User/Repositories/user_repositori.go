package Repositories

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"gomux/Models"
)

type UserRepoImplement struct {
	db *gorm.DB
}

func CreateUserRepo (db *gorm.DB) *UserRepoImplement {
	return &UserRepoImplement{db}
}
func (u UserRepoImplement) ViewAll() (*[]Models.Users,error) {
	var newUser []Models.Users

	err := u.db.Find(&newUser).Error
	if err != nil {
		fmt.Errorf("[UserRepoImplement.Login] email not found",err)
	}
	fmt.Println(newUser)
	return &newUser,nil
}
