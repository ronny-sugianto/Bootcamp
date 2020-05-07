package User

import "gomux/Models"

type UserService interface {
ViewAll()(*[]Models.Users,error)
}
