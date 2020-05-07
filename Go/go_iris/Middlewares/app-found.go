package Middlewares

import "github.com/kataras/iris/v12"

func appFound(ctx iris.Context) {
	ctx.Next()
}
