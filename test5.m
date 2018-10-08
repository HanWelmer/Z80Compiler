  0 :acc= constant 13
  1 :acc=> stack
  2 :call write
  3 :acc= constant 1
  4 :accom constant 1
  5 :brne 9
  6 :acc= constant 12
  7 :acc=> stack
  8 :call write
  9 :acc= constant 1
 10 :accom constant 1
 11 :brne 16
 12 :acc= constant 11
 13 :acc=> stack
 14 :call write
 15 :br 19
 16 :acc= constant 0
 17 :acc=> stack
 18 :call write
 19 :acc= constant 1
 20 :accom constant 0
 21 :brne 26
 22 :acc= constant 0
 23 :acc=> stack
 24 :call write
 25 :br 29
 26 :acc= constant 10
 27 :acc=> stack
 28 :call write
 29 :acc= constant 1
 30 :accom constant 0
 31 :breq 35
 32 :acc= constant 9
 33 :acc=> stack
 34 :call write
 35 :acc= constant 1
 36 :accom constant 0
 37 :breq 42
 38 :acc= constant 8
 39 :acc=> stack
 40 :call write
 41 :br 45
 42 :acc= constant 0
 43 :acc=> stack
 44 :call write
 45 :acc= constant 1
 46 :accom constant 1
 47 :breq 52
 48 :acc= constant 0
 49 :acc=> stack
 50 :call write
 51 :br 55
 52 :acc= constant 7
 53 :acc=> stack
 54 :call write
 55 :acc= constant 1
 56 :accom constant 0
 57 :brle 61
 58 :acc= constant 6
 59 :acc=> stack
 60 :call write
 61 :acc= constant 1
 62 :accom constant 0
 63 :brlt 67
 64 :acc= constant 5
 65 :acc=> stack
 66 :call write
 67 :acc= constant 1
 68 :accom constant 1
 69 :brlt 73
 70 :acc= constant 4
 71 :acc=> stack
 72 :call write
 73 :acc= constant 0
 74 :accom constant 1
 75 :brge 79
 76 :acc= constant 3
 77 :acc=> stack
 78 :call write
 79 :acc= constant 0
 80 :accom constant 1
 81 :brgt 85
 82 :acc= constant 2
 83 :acc=> stack
 84 :call write
 85 :acc= constant 1
 86 :accom constant 1
 87 :brgt 91
 88 :acc= constant 1
 89 :acc=> stack
 90 :call write
 91 :acc= constant 0
 92 :acc=> stack
 93 :call write
 94 :stop
