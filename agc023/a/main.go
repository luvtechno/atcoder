package main

import (
	"fmt"
)

func main() {
	var (
		n int
	)
	fmt.Scan(&n)
	ii := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scan(&ii[i])
	}

	ans := 0

	for i := 0; i < n; i++ {
		sum := 0
		for j := i; j < n; j++ {
			sum += ii[j]
			if sum == 0 {
				ans++
			}
		}
	}

	fmt.Printf("%d\n", ans)
}
