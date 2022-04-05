package main

import (
  "fmt"
  "regexp"
  "time"
)

func main() {
  r1 := ""
  r2 := ""

  for i := 0; i < 29; i++ {
    r1 += "a?"
    r2 += "a"
    regex := r1 + r2
    r, err := regexp.Compile(regex)

    if err != nil {
      fmt.Println(err)
    }

    start := time.Now()
    if r.MatchString(r2) {
      fmt.Printf("%8d us : %s matches %s\n", time.Since(start).Microseconds(), r2, regex)
    }
  }
}
