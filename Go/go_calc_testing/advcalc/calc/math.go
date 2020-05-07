package calc

import "errors"

func Add(numbers ...int) (int, error) {
	sum := 0
	if len(numbers) < 2 {
		return sum, errors.New("Kurang dari 2 angka")
	} else {
		for _, num := range numbers {
			sum = sum + num
		}
		return sum, nil
	}
}
