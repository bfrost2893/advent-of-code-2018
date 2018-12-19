package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func part1(ids []string) {
	fmt.Println("Part 1")
	twoCount := 0
	threeCount := 0
	for _, id := range ids {
		letterCounts := make(map[rune]int)

		// generate letter counts in id
		for _, letter := range id {
			if _, hasKey := letterCounts[letter]; !hasKey {
				letterCounts[letter] = 0
			}

			letterCounts[letter]++
		}

		// find first values that contain 2 or 3 counts
		hasTwo := false
		hasThree := false
		for _, count := range letterCounts {
			if !hasTwo && count == 2 {
				hasTwo = true
				twoCount++
			}

			if !hasThree && count == 3 {
				hasThree = true
				threeCount++
			}

			if hasTwo && hasThree {
				break
			}
		}
	}

	fmt.Println("Checksum", twoCount*threeCount)
}

func part2(ids []string) {
	fmt.Println("Part 2")
	// this is ugly...
	for i := 0; i < len(ids)-1; i++ {
		for j := i + 1; j < len(ids)-1; j++ {
			// if on the same word
			if i == j {
				continue
			}

			// iterate thru string
			differenceCount := 0
			differencePos := -1
			word1 := ids[i]
			word2 := ids[j]
			for k := 0; k < len(ids[i])-1; k++ {
				letter1 := word1[k]
				letter2 := word2[k]

				if letter1 != letter2 {
					differenceCount++
					differencePos = k
				}

				if differenceCount > 1 {
					break
				}
			}

			if differenceCount == 1 {
				replaced := word1[0:differencePos] + word1[differencePos+1:len(word1)]
				fmt.Printf("Word 1: %s\nWord 2: %s\nDifference Pos: %d\nReplaced: %s\n", word1, word2, differencePos, replaced)
				return
			}
		}
	}
}

func main() {
	data, _ := ioutil.ReadAll(os.Stdin)
	ids := strings.Split(string(data), "\n")
	part1(ids)
	part2(ids)
}
