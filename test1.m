  0 :acc= constant 14
  1 :acc=> stack
  2 :call write
  3 :acc= constant 13
  4 :acc=> variable 0
  5 :acc= variable 0
  6 :acc=> stack
  7 :call write
  8 :acc= constant 12
  9 :acc=> variable 2
 10 :acc= variable 2
 11 :accom constant 11
 12 :brle 22
 13 :acc= constant 1
 14 :acc=> variable 3
 15 :acc= variable 2
 16 :acc=> stack
 17 :call write
 18 :acc= variable 2
 19 :acc- constant 1
 20 :acc=> variable 2
 21 :br 10
 22 :acc= variable 2
 23 :accom constant 9
 24 :brle 34
 25 :acc= constant 2
 26 :acc=> variable 5
 27 :acc= variable 2
 28 :acc=> stack
 29 :call write
 30 :acc= variable 2
 31 :acc- constant 1
 32 :acc=> variable 2
 33 :br 22
 34 :acc= constant 9
 35 :acc=> variable 7
 36 :acc= variable 7
 37 :accom constant 7
 38 :brlt 46
 39 :acc= variable 7
 40 :acc=> stack
 41 :call write
 42 :acc= variable 7
 43 :acc- constant 1
 44 :acc=> variable 7
 45 :br 36
 46 :acc= constant 1
 47 :acc=> variable 8
 48 :acc= variable 7
 49 :acc=> stack
 50 :call write
 51 :acc= variable 7
 52 :acc- constant 1
 53 :acc=> variable 7
 54 :<acc= variable 7
 55 :accom constant 5
 56 :brge 46
 57 :acc= constant 3
 58 :acc=> variable 10
 59 :<acc= variable 10
 60 :accom constant 4
 61 :brgt 72
 62 :br 65
 63 :incr variable 10
 64 :br 59
 65 :acc= constant 1
 66 :acc=> variable 11
 67 :acc= variable 7
 68 :acc=> stack
 69 :call write
 70 :decr variable 7
 71 :br 63
 72 :acc= constant 2
 73 :acc=> variable 13
 74 :<acc= variable 13
 75 :accom constant 0
 76 :breq 87
 77 :br 80
 78 :decr variable 13
 79 :br 74
 80 :acc= constant 1
 81 :acc=> variable 15
 82 :acc= variable 13
 83 :acc=> stack
 84 :call write
 85 :decr variable 7
 86 :br 78
 87 :acc= variable 7
 88 :acc=> stack
 89 :call write
 90 :stop
