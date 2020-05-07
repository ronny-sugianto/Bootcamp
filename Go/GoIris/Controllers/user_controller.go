package Controllers

import (
	"GoIris/Drivers"
	"GoIris/Models"
	"GoIris/Repositories"
	"encoding/json"
	"fmt"
	"github.com/kataras/iris"
)



func GetUser(ctx iris.Context) {

	idParam := ctx.Params().Get("id")
 	idQuery := ctx.URLParam("id")
	if idParam != ""{
		userList,err := Repositories.User(Drivers.Connect()).GetUserByID(idParam)
		fmt.Println(idParam)
		if err != nil {
			ctx.JSON(iris.Map{"status":"User Not Found"})
			return
		}
		ctx.JSON(userList)
		return
	}
	if idQuery != "" {
		userList,err := Repositories.User(Drivers.Connect()).GetUserByID(idQuery)
		if err != nil {
			ctx.JSON(iris.Map{"status":"User Not Found"})
			return
		}
		ctx.JSON(userList)
		return
	}
	userList, err := Repositories.User(Drivers.Connect()).GetAllUser()
	if err != nil {
		fmt.Println(err)
	}
	ctx.JSON(userList)

}
func AddUser(ctx iris.Context) {
	var user Models.User
	ctx.Header("Content-type","application/json")
	errors := json.NewDecoder(ctx.Request().Body).Decode(&user)
	if errors != nil {
		ctx.JSON(iris.Map{"status":errors})
		return
	}
	userAdd,err := Repositories.User(Drivers.Connect()).AddUser(&user)
	if err != nil {
		ctx.JSON(iris.Map{"status":"Add User Error"})
	}
	ctx.JSON(iris.Map{"IK":userAdd})

}
func UpdateUser(ctx iris.Context) {
	var user Models.User
	ctx.Header("Content-type","application/json")
	id,_ := ctx.Params().GetUint("id")
	errors := json.NewDecoder(ctx.Request().Body).Decode(&user)
	if errors != nil {
		ctx.JSON(iris.Map{"status":"Please Input Body - Update User Error"})
	}




	userUpdate,err := Repositories.User(Drivers.Connect()).UpdateUser(id,&user)
	if err != nil {
		ctx.JSON(iris.Map{"status":"Update User Error"})
	}
	ctx.JSON(userUpdate)

}
func DeleteUser(ctx iris.Context) {
	lastname := ctx.URLParam("lastname")
	fmt.Println(lastname)
}
