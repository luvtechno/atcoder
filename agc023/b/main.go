package main

import (
	"fmt"
)

func main() {
	var (
		n int
	)
	fmt.Scan(&n)

	m := make([]string, n)
	goodM := make([][]int, n)
	for i := 0; i < n; i++ {
		fmt.Scan(&m[i])
		goodM[i] = make([]int, n)
	}

	// fmt.Println(m)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			v := 0
			for k := 1; k < n; k++ {
				if m[(i+k)%n][j] != m[i][(j+k)%n] {
					break
				}
				v++
			}
			goodM[i][j] = v
		}
	}

	// fmt.Println(goodM)

	ans := 0

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			good := true
			for k := 0; k < n; k++ {
				if goodM[(i+k)%n][(j+k)%n] < n-1-k {
					good = false
					break
				}
			}
			if good {
				ans++
			}
		}
	}

	fmt.Printf("%d\n", ans)
}
