  0 :acc= constant 1
  1 :accom constant 1
  2 :brne 6
  3 :acc= constant 12
  4 :acc=> stack
  5 :call write
  6 :acc= constant 1
  7 :accom constant 1
  8 :brne 13
  9 :acc= constant 11
 10 :acc=> stack
 11 :call write
 12 :br 16
 13 :acc= constant 0
 14 :acc=> stack
 15 :call write
 16 :acc= constant 1
 17 :accom constant 0
 18 :brne 23
 19 :acc= constant 0
 20 :acc=> stack
 21 :call write
 22 :br 26
 23 :acc= constant 10
 24 :acc=> stack
 25 :call write
 26 :acc= constant 1
 27 :accom constant 0
 28 :breq 32
 29 :acc= constant 9
 30 :acc=> stack
 31 :call write
 32 :acc= constant 1
 33 :accom constant 0
 34 :breq 39
 35 :acc= constant 8
 36 :acc=> stack
 37 :call write
 38 :br 42
 39 :acc= constant 0
 40 :acc=> stack
 41 :call write
 42 :acc= constant 1
 43 :accom constant 1
 44 :breq 49
 45 :acc= constant 0
 46 :acc=> stack
 47 :call write
 48 :br 52
 49 :acc= constant 7
 50 :acc=> stack
 51 :call write
 52 :acc= constant 1
 53 :accom constant 0
 54 :brle 58
 55 :acc= constant 6
 56 :acc=> stack
 57 :call write
 58 :acc= constant 1
 59 :accom constant 0
 60 :brlt 64
 61 :acc= constant 5
 62 :acc=> stack
 63 :call write
 64 :acc= constant 1
 65 :accom constant 1
 66 :brlt 70
 67 :acc= constant 4
 68 :acc=> stack
 69 :call write
 70 :acc= constant 0
 71 :accom constant 1
 72 :brge 76
 73 :acc= constant 3
 74 :acc=> stack
 75 :call write
 76 :acc= constant 0
 77 :accom constant 1
 78 :brgt 82
 79 :acc= constant 2
 80 :acc=> stack
 81 :call write
 82 :acc= constant 1
 83 :accom constant 1
 84 :brgt 88
 85 :acc= constant 1
 86 :acc=> stack
 87 :call write
 88 :acc= constant 0
 89 :acc=> stack
 90 :call write
 91 :stop
