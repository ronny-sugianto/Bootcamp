package main

import (
	"GoIris/Models"
	"GoIris/Drivers"
	"github.com/subosito/gotenv"
)
func init() {
	gotenv.Load()
}
func mains() {
	db := Drivers.Connect()


	defer db.Close()

	db.Exec("DROP TABLE IF EXISTS pengguna;")
	db.AutoMigrate(&Models.User{})
	db.Create(&Models.User{Name: "Rinso Cair 150gr",Password: "admin"})
	db.Create(&Models.User{Name: "Indomie Seblak 50gr",Password: "user"})
	db.Create(&Models.User{Name: "Pepsodent White 80gr",Password: "demo"})
}
