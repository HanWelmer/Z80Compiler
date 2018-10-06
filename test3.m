  0 :acc= constant 14
  1 :acc=> stack
  2 :call write
  3 :acc= constant 14
  4 :acc=> variable 1
  5 :decr variable 1
  6 :acc= variable 1
  7 :acc=> stack
  8 :call write
  9 :acc= constant 11
 10 :acc=> variable 1
 11 :incr variable 1
 12 :acc= variable 1
 13 :acc=> stack
 14 :call write
 15 :acc= constant 9
 16 :acc* constant 9
 17 :acc* constant 9
 18 :acc* constant 9
 19 :acc* constant 9
 20 :accom constant 59049
 21 :brne 26
 22 :acc= constant 11
 23 :acc=> stack
 24 :call write
 25 :br 29
 26 :acc= constant 0
 27 :acc=> stack
 28 :call write
 29 :acc= constant 9
 30 :acc* constant 9
 31 :acc* constant 9
 32 :acc* constant 9
 33 :accom constant 6561
 34 :brne 39
 35 :acc= constant 10
 36 :acc=> stack
 37 :call write
 38 :br 42
 39 :acc= constant 0
 40 :acc=> stack
 41 :call write
 42 :acc= constant 9
 43 :acc* constant 9
 44 :acc* constant 9
 45 :accom constant 729
 46 :brne 51
 47 :acc= constant 9
 48 :acc=> stack
 49 :call write
 50 :br 54
 51 :acc= constant 0
 52 :acc=> stack
 53 :call write
 54 :acc= constant 2
 55 :acc* constant 9
 56 :acc* constant 9
 57 :accom constant 162
 58 :brne 63
 59 :acc= constant 8
 60 :acc=> stack
 61 :call write
 62 :br 66
 63 :acc= constant 0
 64 :acc=> stack
 65 :call write
 66 :acc= constant 7
 67 :acc* constant 5
 68 :accom constant 35
 69 :brne 74
 70 :acc= constant 7
 71 :acc=> stack
 72 :call write
 73 :br 77
 74 :acc= constant 0
 75 :acc=> stack
 76 :call write
 77 :acc= constant 2
 78 :acc=> variable 1
 79 :acc= constant 3
 80 :acc* variable 1
 81 :acc=> stack
 82 :call write
 83 :acc= constant 1
 84 :acc=> variable 1
 85 :acc= variable 1
 86 :acc* constant 5
 87 :acc=> stack
 88 :call write
 89 :acc= constant 2
 90 :acc* constant 2
 91 :acc=> variable 1
 92 :acc= variable 1
 93 :acc=> stack
 94 :call write
 95 :acc= constant 1
 96 :acc* constant 3
 97 :acc=> stack
 98 :call write
 99 :acc= constant 2
100 :acc* constant 1
101 :acc=> stack
102 :call write
103 :acc= constant 1
104 :acc* constant 1
105 :acc=> stack
106 :call write
107 :acc= constant 1
108 :acc* constant 0
109 :acc=> stack
110 :call write
111 :stop
