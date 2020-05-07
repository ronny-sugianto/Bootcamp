package transform

func Square(s []int) []int {
	squareS := make([]int, len(s))
	for i, val := range s {
		squareS[i] = val * val
	}
	return squareS
}
