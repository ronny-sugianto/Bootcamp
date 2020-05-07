package Middlewares

import "github.com/kataras/iris/v12"

func appNotFound(ctx iris.Context) {
	ctx.JSON(iris.Map{"status": "404 not found"})
}
