package Controllers

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"gomux/User"
	"net/http"
)

type UserController struct {
	userService User.UserService
}
func CreateUserHandler(r *mux.Router,userService User.UserService) {
	userController := UserController{userService}
	r.HandleFunc("/user", userController.viewAllUser).Methods(http.MethodGet)
}
func (e *UserController) viewAllUser(res http.ResponseWriter, req *http.Request)  {
	user, err := e.userService.ViewAll()
	if err != nil {
		res.Header().Set("Content-type", "application/json")
		res.WriteHeader(http.StatusInternalServerError)
		json,err := json.Marshal(err.Error())
		if err != nil {
			fmt.Printf("[userHandler.viewAllUser] error marhsal data %v \n",err)
			return
		}
		res.Write(json)
		return
	}
	res.Header().Set("Content-type", "application/json")
	json,err := json.Marshal(user)
	if err != nil {
		fmt.Printf("[userHandler.viewAllUser] error marhsal data %v \n",err)
		panic("error marshal")

	}
	res.Write(json)
	return
}