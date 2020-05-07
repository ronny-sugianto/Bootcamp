package Routes

import (
	"GoIris/Controllers"
)

func UserRoute() {
	User.Get("/",Controllers.GetUser)
	User.Get("/{id}",Controllers.GetUser)
	User.Post("/",Controllers.AddUser)
	User.Put("/{id:uint}",Controllers.UpdateUser)
	User.Delete("/{id}",Controllers.DeleteUser)
}
