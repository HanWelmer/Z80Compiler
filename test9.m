   0 ;test9.j(0) /* Program to test multiplication */
   1 ;test9.j(1) class TestMultiply {
   2 ;test9.j(2)   byte b = 9;
   3 acc8= constant 9
   4 acc8=> variable 0
   5 ;test9.j(3)   int i = 6561;
   6 acc16= constant 6561
   7 acc16=> variable 1
   8 ;test9.j(4)   if (i * 1 > b * 1) write (21); else write (0);
   9 acc16= variable 1
  10 acc16* constant 1
  11 <acc16
  12 acc8= variable 0
  13 acc8* constant 1
  14 acc16= unstack16
  15 acc16CompareAcc8
  16 brle 20
  17 acc8= constant 21
  18 call writeAcc8
  19 br 23
  20 acc8= constant 0
  21 call writeAcc8
  22 ;test9.j(5)   if (b * 1 < i * 1) write (20); else write (0);
  23 acc8= variable 0
  24 acc8* constant 1
  25 <acc8
  26 acc16= variable 1
  27 acc16* constant 1
  28 acc8= unstack8
  29 acc8CompareAcc16
  30 brge 34
  31 acc8= constant 20
  32 call writeAcc8
  33 br 37
  34 acc8= constant 0
  35 call writeAcc8
  36 ;test9.j(6)   if (i * 1 > b) write (19); else write (0);
  37 acc16= variable 1
  38 acc16* constant 1
  39 acc8= variable 0
  40 acc16CompareAcc8
  41 brle 45
  42 acc8= constant 19
  43 call writeAcc8
  44 br 48
  45 acc8= constant 0
  46 call writeAcc8
  47 ;test9.j(7)   if (b * 1 < i) write (18); else write (0);
  48 acc8= variable 0
  49 acc8* constant 1
  50 acc16= variable 1
  51 acc8CompareAcc16
  52 brge 56
  53 acc8= constant 18
  54 call writeAcc8
  55 br 59
  56 acc8= constant 0
  57 call writeAcc8
  58 ;test9.j(8)   if (i > b * 1) write (17); else write (0);
  59 acc8= variable 0
  60 acc8* constant 1
  61 acc16= variable 1
  62 acc16CompareAcc8
  63 brle 67
  64 acc8= constant 17
  65 call writeAcc8
  66 br 70
  67 acc8= constant 0
  68 call writeAcc8
  69 ;test9.j(9)   if (b < i * 1) write (16); else write (0);
  70 acc16= variable 1
  71 acc16* constant 1
  72 acc8= variable 0
  73 acc8CompareAcc16
  74 brge 78
  75 acc8= constant 16
  76 call writeAcc8
  77 br 81
  78 acc8= constant 0
  79 call writeAcc8
  80 ;test9.j(10)   if (3 * 3 < i) write (15); else write (0);
  81 acc8= constant 3
  82 acc8* constant 3
  83 acc16= variable 1
  84 acc8CompareAcc16
  85 brge 89
  86 acc8= constant 15
  87 call writeAcc8
  88 br 92
  89 acc8= constant 0
  90 call writeAcc8
  91 ;test9.j(11)   if (6561 * 1 > b) write (14); else write (0);
  92 acc16= constant 6561
  93 acc16* constant 1
  94 acc8= variable 0
  95 acc16CompareAcc8
  96 brle 100
  97 acc8= constant 14
  98 call writeAcc8
  99 br 103
 100 acc8= constant 0
 101 call writeAcc8
 102 ;test9.j(12)   if (i > 3 * 3) write (13); else write (0);
 103 acc8= constant 3
 104 acc8* constant 3
 105 acc16= variable 1
 106 acc16CompareAcc8
 107 brle 111
 108 acc8= constant 13
 109 call writeAcc8
 110 br 114
 111 acc8= constant 0
 112 call writeAcc8
 113 ;test9.j(13)   if (b < 6561 * 1) write (12); else write (0);
 114 acc16= constant 6561
 115 acc16* constant 1
 116 acc8= variable 0
 117 acc8CompareAcc16
 118 brge 122
 119 acc8= constant 12
 120 call writeAcc8
 121 br 125
 122 acc8= constant 0
 123 call writeAcc8
 124 ;test9.j(14)   if (i > b) write (11); else write (0);
 125 acc16= variable 1
 126 acc8= variable 0
 127 acc16CompareAcc8
 128 brle 132
 129 acc8= constant 11
 130 call writeAcc8
 131 br 135
 132 acc8= constant 0
 133 call writeAcc8
 134 ;test9.j(15)   if (b < i) write (10); else write (0);
 135 acc8= variable 0
 136 acc16= variable 1
 137 acc8CompareAcc16
 138 brge 142
 139 acc8= constant 10
 140 call writeAcc8
 141 br 146
 142 acc8= constant 0
 143 call writeAcc8
 144 ;test9.j(16) 
 145 ;test9.j(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
 146 acc8= constant 3
 147 acc8* constant 3
 148 <acc8
 149 acc16= constant 6561
 150 acc16* constant 1
 151 acc8= unstack8
 152 acc8CompareAcc16
 153 brge 157
 154 acc8= constant 9
 155 call writeAcc8
 156 br 160
 157 acc8= constant 0
 158 call writeAcc8
 159 ;test9.j(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
 160 acc16= constant 6561
 161 acc16* constant 1
 162 <acc16
 163 acc8= constant 3
 164 acc8* constant 3
 165 acc16= unstack16
 166 acc16CompareAcc8
 167 brle 171
 168 acc8= constant 8
 169 call writeAcc8
 170 br 174
 171 acc8= constant 0
 172 call writeAcc8
 173 ;test9.j(19)   if (9 < 6561 * 1) write (7); else write (0);
 174 acc16= constant 6561
 175 acc16* constant 1
 176 acc8= constant 9
 177 acc8CompareAcc16
 178 brge 182
 179 acc8= constant 7
 180 call writeAcc8
 181 br 185
 182 acc8= constant 0
 183 call writeAcc8
 184 ;test9.j(20)   if (6561 * 1 > 9) write (6); else write (0);
 185 acc16= constant 6561
 186 acc16* constant 1
 187 acc8= constant 9
 188 acc16CompareAcc8
 189 brle 193
 190 acc8= constant 6
 191 call writeAcc8
 192 br 196
 193 acc8= constant 0
 194 call writeAcc8
 195 ;test9.j(21)   if (6561 > 3 * 3) write (5); else write (0);
 196 acc8= constant 3
 197 acc8* constant 3
 198 acc16= constant 6561
 199 acc16CompareAcc8
 200 brle 204
 201 acc8= constant 5
 202 call writeAcc8
 203 br 207
 204 acc8= constant 0
 205 call writeAcc8
 206 ;test9.j(22)   if (3 * 3 < 6561) write (4); else write (0);
 207 acc8= constant 3
 208 acc8* constant 3
 209 acc16= constant 6561
 210 acc8CompareAcc16
 211 brge 215
 212 acc8= constant 4
 213 call writeAcc8
 214 br 218
 215 acc8= constant 0
 216 call writeAcc8
 217 ;test9.j(23)   if (9 < 6561) write (3); else write (0);
 218 acc8= constant 9
 219 acc16= constant 6561
 220 acc8CompareAcc16
 221 brge 225
 222 acc8= constant 3
 223 call writeAcc8
 224 br 228
 225 acc8= constant 0
 226 call writeAcc8
 227 ;test9.j(24)   if (6561 > 9) write (2); else write (0);
 228 acc16= constant 6561
 229 acc8= constant 9
 230 acc16CompareAcc8
 231 brle 235
 232 acc8= constant 2
 233 call writeAcc8
 234 br 238
 235 acc8= constant 0
 236 call writeAcc8
 237 ;test9.j(25)   write(1);
 238 acc8= constant 1
 239 call writeAcc8
 240 ;test9.j(26)   write(0);
 241 acc8= constant 0
 242 call writeAcc8
 243 ;test9.j(27) }
 244 stop
