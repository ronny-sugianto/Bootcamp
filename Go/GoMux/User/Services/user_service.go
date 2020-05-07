package Services

import (
	"gomux/Models"
	"gomux/User"
)

type UserServiceImpl struct {
	userRepo User.UserRepo

}

func CreateUserService(userRepo User.UserRepo) User.UserService{
return &UserServiceImpl{userRepo}
}

func (e *UserServiceImpl) ViewAll()(*[]Models.Users,error) {
	return e.userRepo.ViewAll()
}