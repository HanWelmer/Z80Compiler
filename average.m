  0 :acc= constant 0
  1 :acc=> variable 1
  2 :acc= constant 0
  3 :acc=> variable 2
  4 :call read
  5 :acc=> variable 0
  6 :acc= variable 0
  7 :acc=> stack
  8 :call write
  9 :acc= variable 0
 10 :accom constant 0
 11 :breq 24
 12 :acc= variable 1
 13 :acc+ variable 0
 14 :acc=> variable 1
 15 :acc= variable 2
 16 :acc+ constant 1
 17 :acc=> variable 2
 18 :call read
 19 :acc=> variable 0
 20 :acc= variable 0
 21 :acc=> stack
 22 :call write
 23 :br 9
 24 :acc= variable 2
 25 :acc=> stack
 26 :call write
 27 :acc= variable 1
 28 :acc=> stack
 29 :call write
 30 :acc= variable 2
 31 :accom constant 0
 32 :breq 39
 33 :acc= variable 1
 34 :acc/ variable 2
 35 :acc=> variable 3
 36 :acc= variable 3
 37 :acc=> stack
 38 :call write
 39 :stop