   0 ;test9.p(0) /* Program to test multiplication */
   1 ;test9.p(1) class TestMuliply {
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
  39 <acc16
  40 acc16= unstack16
  41 acc8= variable 0
  42 acc16CompareAcc8
  43 brle 47
  44 acc8= constant 19
  45 call writeAcc8
  46 br 50
  47 acc8= constant 0
  48 call writeAcc8
  49 ;test9.p(7)   if (b * 1 < i) write (18); else write (0);
  50 acc8= variable 0
  51 acc8* constant 1
  52 <acc8
  53 acc8= unstack8
  54 acc16= variable 1
  55 acc8CompareAcc16
  56 brge 60
  57 acc8= constant 18
  58 call writeAcc8
  59 br 63
  60 acc8= constant 0
  61 call writeAcc8
  62 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
  63 acc16= variable 1
  64 <acc16
  65 acc8= variable 0
  66 acc8* constant 1
  67 acc16= unstack16
  68 acc16CompareAcc8
  69 brle 73
  70 acc8= constant 17
  71 call writeAcc8
  72 br 76
  73 acc8= constant 0
  74 call writeAcc8
  75 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
  76 acc8= variable 0
  77 <acc8
  78 acc16= variable 1
  79 acc16* constant 1
  80 acc8= unstack8
  81 acc8CompareAcc16
  82 brge 86
  83 acc8= constant 16
  84 call writeAcc8
  85 br 89
  86 acc8= constant 0
  87 call writeAcc8
  88 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
  89 acc8= constant 3
  90 acc8* constant 3
  91 <acc8
  92 acc8= unstack8
  93 acc16= variable 1
  94 acc8CompareAcc16
  95 brge 99
  96 acc8= constant 15
  97 call writeAcc8
  98 br 102
  99 acc8= constant 0
 100 call writeAcc8
 101 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
 102 acc16= constant 6561
 103 acc16* constant 1
 104 <acc16
 105 acc16= unstack16
 106 acc8= variable 0
 107 acc16CompareAcc8
 108 brle 112
 109 acc8= constant 14
 110 call writeAcc8
 111 br 115
 112 acc8= constant 0
 113 call writeAcc8
 114 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
 115 acc16= variable 1
 116 <acc16
 117 acc8= constant 3
 118 acc8* constant 3
 119 acc16= unstack16
 120 acc16CompareAcc8
 121 brle 125
 122 acc8= constant 13
 123 call writeAcc8
 124 br 128
 125 acc8= constant 0
 126 call writeAcc8
 127 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
 128 acc8= variable 0
 129 <acc8
 130 acc16= constant 6561
 131 acc16* constant 1
 132 acc8= unstack8
 133 acc8CompareAcc16
 134 brge 138
 135 acc8= constant 12
 136 call writeAcc8
 137 br 141
 138 acc8= constant 0
 139 call writeAcc8
 140 ;test9.p(14)   if (i > b) write (11); else write (0);
 141 acc16= variable 1
 142 <acc16
 143 acc16= unstack16
 144 acc8= variable 0
 145 acc16CompareAcc8
 146 brle 150
 147 acc8= constant 11
 148 call writeAcc8
 149 br 153
 150 acc8= constant 0
 151 call writeAcc8
 152 ;test9.p(15)   if (b < i) write (10); else write (0);
 153 acc8= variable 0
 154 <acc8
 155 acc8= unstack8
 156 acc16= variable 1
 157 acc8CompareAcc16
 158 brge 162
 159 acc8= constant 10
 160 call writeAcc8
 161 br 166
 162 acc8= constant 0
 163 call writeAcc8
 164 ;test9.p(16) 
 165 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
 166 acc8= constant 3
 167 acc8* constant 3
 168 <acc8
 169 acc16= constant 6561
 170 acc16* constant 1
 171 acc8= unstack8
 172 acc8CompareAcc16
 173 brge 177
 174 acc8= constant 9
 175 call writeAcc8
 176 br 180
 177 acc8= constant 0
 178 call writeAcc8
 179 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
 180 acc16= constant 6561
 181 acc16* constant 1
 182 <acc16
 183 acc8= constant 3
 184 acc8* constant 3
 185 acc16= unstack16
 186 acc16CompareAcc8
 187 brle 191
 188 acc8= constant 8
 189 call writeAcc8
 190 br 194
 191 acc8= constant 0
 192 call writeAcc8
 193 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
 194 acc16= constant 6561
 195 acc16* constant 1
 196 acc8= constant 9
 197 acc8CompareAcc16
 198 brge 202
 199 acc8= constant 7
 200 call writeAcc8
 201 br 205
 202 acc8= constant 0
 203 call writeAcc8
 204 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
 205 acc16= constant 6561
 206 acc16* constant 1
 207 <acc16
 208 acc16= unstack16
 209 acc8= constant 9
 210 acc16CompareAcc8
 211 brle 215
 212 acc8= constant 6
 213 call writeAcc8
 214 br 218
 215 acc8= constant 0
 216 call writeAcc8
 217 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
 218 acc8= constant 3
 219 acc8* constant 3
 220 acc16= constant 6561
 221 acc16CompareAcc8
 222 brle 226
 223 acc8= constant 5
 224 call writeAcc8
 225 br 229
 226 acc8= constant 0
 227 call writeAcc8
 228 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
 229 acc8= constant 3
 230 acc8* constant 3
 231 <acc8
 232 acc8= unstack8
 233 acc16= constant 6561
 234 acc8CompareAcc16
 235 brge 239
 236 acc8= constant 4
 237 call writeAcc8
 238 br 242
 239 acc8= constant 0
 240 call writeAcc8
 241 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
 242 acc8= constant 9
 243 acc16= constant 6561
 244 acc8CompareAcc16
 245 brge 249
 246 acc8= constant 3
 247 call writeAcc8
 248 br 252
 249 acc8= constant 0
 250 call writeAcc8
 251 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
 252 acc16= constant 6561
 253 acc8= constant 9
 254 acc16CompareAcc8
 255 brle 259
 256 acc8= constant 2
 257 call writeAcc8
 258 br 262
 259 acc8= constant 0
 260 call writeAcc8
 261 ;test9.p(25)   write(1);
 262 acc8= constant 1
 263 call writeAcc8
 264 ;test9.p(26)   write(0);
 265 acc8= constant 0
 266 call writeAcc8
 267 ;test9.p(27) }
 268 stop
