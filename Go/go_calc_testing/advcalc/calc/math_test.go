package calc

import "testing"

func TestAdd(t *testing.T) {
	result, _ := Add(1, 8, 3)
	if result != 12 {
		t.Errorf("Add(1,8,3) Failed, harapannya %v tapi hasilnya %v", 12, result)
	} else {
		t.Logf("Add(1,8,3) berhasil")
	}
}

func TestAddOnly1Parameter(t *testing.T) {
	resultFor1Number, err := Add(1)
	if err == nil && resultFor1Number == 0 {
		t.Error("Must return nil when only 1 number")
	}
}
