package main

import (
	"fmt"
)

func main() {
	var (
		n int
	)
	fmt.Scan(&n)

	m := make([][]int, n)
	for i := 0; i < n; i++ {
		m[i] = make([]int, n)
	}

	ans := 0

	for i := 0; i < n; i++ {
		// fmt.Printf("%d\n", ii[i])
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
