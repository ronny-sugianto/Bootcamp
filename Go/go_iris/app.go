package main

import (
	"fmt"
	"github.com/kataras/iris/v12"
	"github.com/kataras/iris/v12/middleware/logger"
	"github.com/kataras/iris/v12/middleware/recover"
	_ "goiris/Middlewares"
)

func main() {
	app := iris.New()
app.Logger().SetLevel("debug")

	app.Use(recover.New())
	app.Use(logger.New())
	app.OnErrorCode(iris.StatusNotFound,appFound)
	users := app.Party("/users/", myAuthMiddlewareHandler)

	fmt.Println(users)

	app.Run(iris.Addr(":5000"))
}
