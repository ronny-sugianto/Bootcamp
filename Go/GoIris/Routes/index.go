package Routes

import (
	"GoIris/Drivers"
	"github.com/kataras/iris/core/router"
)

var app = *Drivers.App
var User  router.Party
func IndexRoute() {


	User =	app.Party("/user")
	UserRoute()
}
