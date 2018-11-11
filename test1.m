  0 :acc= constant 11
  1 :acc=> stack
  2 :call write
  3 :acc= constant 10
  4 :acc=> variable 0
  5 :acc= variable 0
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
 33 :brgt 44
 34 :br 37
 35 :incr variable 3
 36 :br 31
 37 :acc= variable 3
 38 :acc=> variable 4
 39 :acc= variable 2
 40 :acc=> stack
 41 :call write
 42 :decr variable 2
 43 :br 35
 44 :acc= constant 2
 45 :acc=> variable 5
 46 :<acc= variable 5
 47 :accom constant 0
 48 :breq 59
 49 :br 52
 50 :decr variable 5
 51 :br 46
 52 :acc= variable 5
 53 :acc=> variable 7
 54 :acc= variable 5
 55 :acc=> stack
 56 :call write
 57 :decr variable 2
 58 :br 50
 59 :acc= variable 2
 60 :acc=> stack
 61 :call write
 62 :stop
