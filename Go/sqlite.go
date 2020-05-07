package main

import (
	"database/sql"
	"fmt"
	_ "github.com/mattn/go-sqlite3"
	"strconv"
)

func main() {
	database, _ := sql.Open("sqlite3","./app.db")
	statement,_ := database.Prepare("CREATE TABLE IF NOT EXISTS product(id INTEGER PRIMARY KEY,name TEXT,price INTEGER)")
	statement.Exec()
	//statement,_ = database.Prepare("INSERT INTO product(name,price) VALUES (?,?)")
	//statement.Exec("Odol",8000)
	//statement,_ = database.Prepare("DELETE FROM product")
	//statement.Exec()
	rows, _ := database.Query("SELECT id,name,price FROM product")
	var id int
	var name string
	var price int
	for rows.Next() {
		rows.Scan(&id,&name,&price)
		fmt.Println(strconv.Itoa(id) + ":" + name + ":" + strconv.Itoa(price))
	}


}
