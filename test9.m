   0 ;test9.p(0) /* Program to test multiplication */
   1 ;test9.p(1) class TestMultiply {
   2 ;test9.p(2)   byte b = 9;
   3 acc8= constant 9
   4 acc8=> variable 0
   5 ;test9.p(3)   int i = 6561;
   6 acc16= constant 6561
   7 acc16=> variable 1
   8 ;test9.p(4)   if (i * 1 > b * 1) write (21); else write (0);
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
  22 ;test9.p(5)   if (b * 1 < i * 1) write (20); else write (0);
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
  36 ;test9.p(6)   if (i * 1 > b) write (19); else write (0);
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
  47 ;test9.p(7)   if (b * 1 < i) write (18); else write (0);
  48 acc8= variable 0
  49 acc8* constant 1
  50 <acc8
  51 acc8= unstack8
  52 acc16= variable 1
  53 acc8CompareAcc16
  54 brge 58
  55 acc8= constant 18
  56 call writeAcc8
  57 br 61
  58 acc8= constant 0
  59 call writeAcc8
  60 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
  61 acc16= variable 1
  62 <acc16
  63 acc8= variable 0
  64 acc8* constant 1
  65 acc16= unstack16
  66 acc16CompareAcc8
  67 brle 71
  68 acc8= constant 17
  69 call writeAcc8
  70 br 74
  71 acc8= constant 0
  72 call writeAcc8
  73 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
  74 acc8= variable 0
  75 <acc8
  76 acc16= variable 1
  77 acc16* constant 1
  78 acc8= unstack8
  79 acc8CompareAcc16
  80 brge 84
  81 acc8= constant 16
  82 call writeAcc8
  83 br 87
  84 acc8= constant 0
  85 call writeAcc8
  86 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
  87 acc8= constant 3
  88 acc8* constant 3
  89 <acc8
  90 acc8= unstack8
  91 acc16= variable 1
  92 acc8CompareAcc16
  93 brge 97
  94 acc8= constant 15
  95 call writeAcc8
  96 br 100
  97 acc8= constant 0
  98 call writeAcc8
  99 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
 100 acc16= constant 6561
 101 acc16* constant 1
 102 acc8= variable 0
 103 acc16CompareAcc8
 104 brle 108
 105 acc8= constant 14
 106 call writeAcc8
 107 br 111
 108 acc8= constant 0
 109 call writeAcc8
 110 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
 111 acc16= variable 1
 112 <acc16
 113 acc8= constant 3
 114 acc8* constant 3
 115 acc16= unstack16
 116 acc16CompareAcc8
 117 brle 121
 118 acc8= constant 13
 119 call writeAcc8
 120 br 124
 121 acc8= constant 0
 122 call writeAcc8
 123 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
 124 acc8= variable 0
 125 <acc8
 126 acc16= constant 6561
 127 acc16* constant 1
 128 acc8= unstack8
 129 acc8CompareAcc16
 130 brge 134
 131 acc8= constant 12
 132 call writeAcc8
 133 br 137
 134 acc8= constant 0
 135 call writeAcc8
 136 ;test9.p(14)   if (i > b) write (11); else write (0);
 137 acc16= variable 1
 138 acc8= variable 0
 139 acc16CompareAcc8
 140 brle 144
 141 acc8= constant 11
 142 call writeAcc8
 143 br 147
 144 acc8= constant 0
 145 call writeAcc8
 146 ;test9.p(15)   if (b < i) write (10); else write (0);
 147 acc8= variable 0
 148 <acc8
 149 acc8= unstack8
 150 acc16= variable 1
 151 acc8CompareAcc16
 152 brge 156
 153 acc8= constant 10
 154 call writeAcc8
 155 br 160
 156 acc8= constant 0
 157 call writeAcc8
 158 ;test9.p(16) 
 159 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
 160 acc8= constant 3
 161 acc8* constant 3
 162 <acc8
 163 acc16= constant 6561
 164 acc16* constant 1
 165 acc8= unstack8
 166 acc8CompareAcc16
 167 brge 171
 168 acc8= constant 9
 169 call writeAcc8
 170 br 174
 171 acc8= constant 0
 172 call writeAcc8
 173 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
 174 acc16= constant 6561
 175 acc16* constant 1
 176 <acc16
 177 acc8= constant 3
 178 acc8* constant 3
 179 acc16= unstack16
 180 acc16CompareAcc8
 181 brle 185
 182 acc8= constant 8
 183 call writeAcc8
 184 br 188
 185 acc8= constant 0
 186 call writeAcc8
 187 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
 188 acc16= constant 6561
 189 acc16* constant 1
 190 acc8= constant 9
 191 acc8CompareAcc16
 192 brge 196
 193 acc8= constant 7
 194 call writeAcc8
 195 br 199
 196 acc8= constant 0
 197 call writeAcc8
 198 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
 199 acc16= constant 6561
 200 acc16* constant 1
 201 acc8= constant 9
 202 acc16CompareAcc8
 203 brle 207
 204 acc8= constant 6
 205 call writeAcc8
 206 br 210
 207 acc8= constant 0
 208 call writeAcc8
 209 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
 210 acc8= constant 3
 211 acc8* constant 3
 212 acc16= constant 6561
 213 acc16CompareAcc8
 214 brle 218
 215 acc8= constant 5
 216 call writeAcc8
 217 br 221
 218 acc8= constant 0
 219 call writeAcc8
 220 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
 221 acc8= constant 3
 222 acc8* constant 3
 223 <acc8
 224 acc8= unstack8
 225 acc16= constant 6561
 226 acc8CompareAcc16
 227 brge 231
 228 acc8= constant 4
 229 call writeAcc8
 230 br 234
 231 acc8= constant 0
 232 call writeAcc8
 233 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
 234 acc8= constant 9
 235 acc16= constant 6561
 236 acc8CompareAcc16
 237 brge 241
 238 acc8= constant 3
 239 call writeAcc8
 240 br 244
 241 acc8= constant 0
 242 call writeAcc8
 243 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
 244 acc16= constant 6561
 245 acc8= constant 9
 246 acc16CompareAcc8
 247 brle 251
 248 acc8= constant 2
 249 call writeAcc8
 250 br 254
 251 acc8= constant 0
 252 call writeAcc8
 253 ;test9.p(25)   write(1);
 254 acc8= constant 1
 255 call writeAcc8
 256 ;test9.p(26)   write(0);
 257 acc8= constant 0
 258 call writeAcc8
 259 ;test9.p(27) }
 260 stop
