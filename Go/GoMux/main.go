package main

import (
	"fmt"
	"github.com/gorilla/mux"
"github.com/subosito/gotenv"
	"gomux/Driver"
	"gomux/User/Controllers"
	"gomux/User/Repositories"
	"gomux/User/Services"
	"log"
	"net/http"
	"os"
)

func init() {
	gotenv.Load()
}
func main() {
	port := os.Getenv("PORT")
	db := Driver.Connect()
	defer db.Close()
	Driver.InitTable(db)
	router := mux.NewRouter().StrictSlash(true)
	Controllers.CreateUserHandler(router, Services.CreateUserService(Repositories.CreateUserRepo(db)) )
	fmt.Println("Starting web server at port ", port)
	err:=http.ListenAndServe(":" + port,router)
	if err != nil {
		log.Fatal(err)
	}

}
