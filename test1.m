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
 19 :accom constant 5
 20 :brge 12
 21 :acc= constant 4
 22 :acc=> variable 2
 23 :<acc= variable 2
 24 :accom constant 2
 25 :breq 33
 26 :br 29
 27 :decr variable 2
 28 :br 23
 29 :acc= variable 2
 30 :acc=> stack
 31 :call write
 32 :br 27
 33 :acc= constant 2
 34 :acc=> variable 1
 35 :acc= constant 0
 36 :acc=> variable 3
 37 :<acc= variable 3
 38 :accom constant 2
 39 :brgt 48
 40 :br 43
 41 :incr variable 3
 42 :br 37
 43 :acc= variable 1
 44 :acc=> stack
 45 :call write
 46 :decr variable 1
 47 :br 41
 48 :stop
