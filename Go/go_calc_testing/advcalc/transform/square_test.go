package transform

import (
	"reflect"
	"testing"
)

func TestSquare(t *testing.T) {
	testSquares := []int{1, 2, 3, 4, 5}
	expectedResult := []int{1, 4, 9, 16, 25}

	result := Square(testSquares)

	if reflect.DeepEqual(expectedResult, result) {
		t.Logf("Square Ok")
	} else {
		t.Error("Square failed")
	}
}
