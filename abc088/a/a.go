package main

import (
	"fmt"
)

func main() {
	n, a := 0, 0
	fmt.Scan(&n, &a)

	n = n % 500

	if a >= n {
		fmt.Println("Yes")
	} else {
		fmt.Println("No")
	}
}
