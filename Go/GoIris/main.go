package main

import (
	"GoIris/Drivers"

	"GoIris/Routes"
	"github.com/kataras/iris"
	"github.com/kataras/iris/_examples/mvc/login/repositories"
	"github.com/subosito/gotenv"

	"os"
)
var UserRepo repositories.UserRepository

func init() {
	gotenv.Load()
}
func main() {

	db := Drivers.Connect()
	port := os.Getenv("APP_PORT")
	defer db.Close()

	app:= Drivers.App
	app.Logger().SetLevel("debug")

	app.OnErrorCode(iris.StatusNotFound, notFoundHandler)


	Routes.IndexRoute()

	app.Run(iris.Addr(":" + port),iris.WithoutServerError(iris.ErrServerClosed))


}

func notFoundHandler(ctx iris.Context) {
	ctx.HTML("Custom route for 404 not found http code, here you can render a view, html, json <b>any valid response</b>.")
}
