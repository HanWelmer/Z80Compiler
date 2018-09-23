  0 :acc= constant 0
  1 :acc=> variable 1
  2 :acc= constant 12
  3 :acc=> stack
  4 :call write
  5 :acc= constant 9
  6 :acc* constant 9
  7 :acc* constant 9
  8 :acc* constant 9
  9 :acc* constant 9
 10 :accom constant 59049
 11 :brne 16
 12 :acc= constant 11
 13 :acc=> stack
 14 :call write
 15 :br 19
 16 :acc= constant 0
 17 :acc=> stack
 18 :call write
 19 :acc= constant 9
 20 :acc* constant 9
 21 :acc* constant 9
 22 :acc* constant 9
 23 :accom constant 6561
 24 :brne 29
 25 :acc= constant 10
 26 :acc=> stack
 27 :call write
 28 :br 32
 29 :acc= constant 0
 30 :acc=> stack
 31 :call write
 32 :acc= constant 9
 33 :acc* constant 9
 34 :acc* constant 9
 35 :accom constant 729
 36 :brne 41
 37 :acc= constant 9
 38 :acc=> stack
 39 :call write
 40 :br 44
 41 :acc= constant 0
 42 :acc=> stack
 43 :call write
 44 :acc= constant 2
 45 :acc* constant 9
 46 :acc* constant 9
 47 :accom constant 162
 48 :brne 53
 49 :acc= constant 8
 50 :acc=> stack
 51 :call write
 52 :br 56
 53 :acc= constant 0
 54 :acc=> stack
 55 :call write
 56 :acc= constant 7
 57 :acc* constant 5
 58 :accom constant 35
 59 :brne 64
 60 :acc= constant 7
 61 :acc=> stack
 62 :call write
 63 :br 67
 64 :acc= constant 0
 65 :acc=> stack
 66 :call write
 67 :acc= constant 2
 68 :acc=> variable 1
 69 :acc= constant 3
 70 :acc* variable 1
 71 :acc=> stack
 72 :call write
 73 :acc= constant 1
 74 :acc=> variable 1
 75 :acc= variable 1
 76 :acc* constant 5
 77 :acc=> stack
 78 :call write
 79 :acc= constant 2
 80 :acc* constant 2
 81 :acc=> variable 1
 82 :acc= variable 1
 83 :acc=> stack
 84 :call write
 85 :acc= constant 1
 86 :acc* constant 3
 87 :acc=> stack
 88 :call write
 89 :acc= constant 2
 90 :acc* constant 1
 91 :acc=> stack
 92 :call write
 93 :acc= constant 1
 94 :acc* constant 1
 95 :acc=> stack
 96 :call write
 97 :acc= constant 1
 98 :acc* constant 0
 99 :acc=> stack
100 :call write
101 :stop
