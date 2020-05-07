package User

import "gomux/Models"

type UserRepo interface {
	ViewAll() (*[]Models.Users, error)
}