  0 :acc= constant 10
  1 :acc=> stack
  2 :call write
  3 :acc= constant 9
  4 :acc=> variable 1
  5 :acc= variable 1
  6 :accom constant 7
  7 :brlt 15
  8 :acc= variable 1
  9 :acc=> stack
 10 :call write
 11 :acc= variable 1
 12 :acc- constant 1
 13 :acc=> variable 1
 14 :br 5
 15 :acc= variable 1
 16 :acc=> stack
 17 :call write
 18 :acc= variable 1
 19 :acc- constant 1
 20 :acc=> variable 1
 21 :<acc= variable 1
 22 :accom constant 5
 23 :brge 15
 24 :acc= constant 4
 25 :acc=> variable 2
 26 :<acc= variable 2
 27 :accom constant 2
 28 :breq 36
 29 :br 32
 30 :decr variable 2
 31 :br 26
 32 :acc= variable 2
 33 :acc=> stack
 34 :call write
 35 :br 30
 36 :acc= constant 2
 37 :acc=> variable 1
 38 :acc= constant 0
 39 :acc=> variable 3
 40 :<acc= variable 3
 41 :accom constant 2
 42 :brgt 51
 43 :br 46
 44 :incr variable 3
 45 :br 40
 46 :acc= variable 1
 47 :acc=> stack
 48 :call write
 49 :decr variable 1
 50 :br 44
 51 :stop
