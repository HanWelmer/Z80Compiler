  0 :acc= constant 9
  1 :acc=> stack
  2 :call write
  3 :acc= constant 1
  4 :acc=> variable 0
  5 :acc= variable 0
  6 :accom constant 1
  7 :brne 11
  8 :acc= constant 8
  9 :acc=> stack
 10 :call write
 11 :acc= variable 0
 12 :accom constant 0
 13 :breq 17
 14 :acc= constant 7
 15 :acc=> stack
 16 :call write
 17 :acc= variable 0
 18 :accom constant 0
 19 :brle 23
 20 :acc= constant 6
 21 :acc=> stack
 22 :call write
 23 :acc= variable 0
 24 :accom constant 0
 25 :brlt 29
 26 :acc= constant 5
 27 :acc=> stack
 28 :call write
 29 :acc= variable 0
 30 :accom constant 1
 31 :brlt 35
 32 :acc= constant 4
 33 :acc=> stack
 34 :call write
 35 :acc= variable 0
 36 :accom constant 2
 37 :brge 41
 38 :acc= constant 3
 39 :acc=> stack
 40 :call write
 41 :acc= variable 0
 42 :accom constant 2
 43 :brgt 47
 44 :acc= constant 2
 45 :acc=> stack
 46 :call write
 47 :acc= variable 0
 48 :accom constant 1
 49 :brgt 53
 50 :acc= constant 1
 51 :acc=> stack
 52 :call write
 53 :acc= constant 0
 54 :acc=> stack
 55 :call write
 56 :stop
