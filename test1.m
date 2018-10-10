  0 :acc= constant 11
  1 :acc=> stack
  2 :call write
  3 :acc= constant 10
  4 :acc=> variable 1
  5 :acc= variable 1
  6 :acc=> stack
  7 :call write
  8 :acc= constant 9
  9 :acc=> variable 2
 10 :acc= variable 2
 11 :accom constant 7
 12 :brlt 20
 13 :acc= variable 2
 14 :acc=> stack
 15 :call write
 16 :acc= variable 2
 17 :acc- constant 1
 18 :acc=> variable 2
 19 :br 10
 20 :acc= variable 2
 21 :acc=> stack
 22 :call write
 23 :acc= variable 2
 24 :acc- constant 1
 25 :acc=> variable 2
 26 :<acc= variable 2
 27 :accom constant 5
 28 :brge 20
 29 :acc= constant 3
 30 :acc=> variable 3
 31 :<acc= variable 3
 32 :accom constant 4
 33 :brgt 42
 34 :br 37
 35 :incr variable 3
 36 :br 31
 37 :acc= variable 2
 38 :acc=> stack
 39 :call write
 40 :decr variable 2
 41 :br 35
 42 :acc= constant 2
 43 :acc=> variable 4
 44 :<acc= variable 4
 45 :accom constant 0
 46 :breq 55
 47 :br 50
 48 :decr variable 4
 49 :br 44
 50 :acc= variable 4
 51 :acc=> stack
 52 :call write
 53 :decr variable 2
 54 :br 48
 55 :acc= variable 2
 56 :acc=> stack
 57 :call write
 58 :stop
