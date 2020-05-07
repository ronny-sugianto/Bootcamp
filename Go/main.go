package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)


func tambah(x,y int) int {

	return x+y;
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	fmt.Print("gocalc>")
	scanner.Scan()
	inputA := scanner.Text()
	var response, _ = http.Get("http://jsonplaceholder.typicode.com/posts/" + inputA)
	data,_ := ioutil.ReadAll(response.Body)
	var datas = string(data);
	if datas == "{}" {
		fmt.Println("Data Not Found");
	} else {
		fmt.Println(string(data))
	}


	//inputB := scanner.Scan()
}
