  0 :acc= constant 9
  1 :acc=> variable 1
  2 :acc= variable 1
  3 :accom constant 7
  4 :brlt 12
  5 :acc= variable 1
  6 :acc=> stack
  7 :call write
  8 :acc= variable 1
  9 :acc- constant 1
 10 :acc=> variable 1
 11 :br 2
 12 :acc= variable 1
 13 :acc=> stack
 14 :call write
 15 :acc= variable 1
 16 :acc- constant 1
 17 :acc=> variable 1
 18 :<acc= variable 1
 19 :accom constant 6
 20 :brge 12
 21 :acc= constant 5
 22 :acc=> variable 2
 23 :<acc= variable 2
 24 :accom constant 0
 25 :breq 33
 26 :br 29
 27 :decr variable 2
 28 :br 23
 29 :acc= variable 2
 30 :acc=> stack
 31 :call write
 32 :br 27
 33 :acc= constant 0
 34 :acc=> stack
 35 :call write
 36 :acc= constant 0
 37 :acc=> variable 3
 38 :<acc= variable 3
 39 :accom constant 9
 40 :brgt 48
 41 :br 44
 42 :incr variable 3
 43 :br 38
 44 :acc= variable 3
 45 :acc=> stack
 46 :call write
 47 :br 42
 48 :stop
