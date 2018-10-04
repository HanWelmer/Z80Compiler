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
 25 :breq 35
 26 :br 31
 27 :<acc= variable 2
 28 :acc- constant 1
 29 :acc=> variable 2
 30 :br 23
 31 :acc= variable 2
 32 :acc=> stack
 33 :call write
 34 :br 27
 35 :acc= constant 0
 36 :acc=> stack
 37 :call write
 38 :stop
