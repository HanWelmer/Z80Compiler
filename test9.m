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
  50 acc16= variable 1
  51 acc8CompareAcc16
  52 brge 56
  53 acc8= constant 18
  54 call writeAcc8
  55 br 59
  56 acc8= constant 0
  57 call writeAcc8
  58 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
  59 acc16= variable 1
  60 <acc16
  61 acc8= variable 0
  62 acc8* constant 1
  63 acc16= unstack16
  64 acc16CompareAcc8
  65 brle 69
  66 acc8= constant 17
  67 call writeAcc8
  68 br 72
  69 acc8= constant 0
  70 call writeAcc8
  71 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
  72 acc8= variable 0
  73 <acc8
  74 acc16= variable 1
  75 acc16* constant 1
  76 acc8= unstack8
  77 acc8CompareAcc16
  78 brge 82
  79 acc8= constant 16
  80 call writeAcc8
  81 br 85
  82 acc8= constant 0
  83 call writeAcc8
  84 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
  85 acc8= constant 3
  86 acc8* constant 3
  87 acc16= variable 1
  88 acc8CompareAcc16
  89 brge 93
  90 acc8= constant 15
  91 call writeAcc8
  92 br 96
  93 acc8= constant 0
  94 call writeAcc8
  95 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
  96 acc16= constant 6561
  97 acc16* constant 1
  98 acc8= variable 0
  99 acc16CompareAcc8
 100 brle 104
 101 acc8= constant 14
 102 call writeAcc8
 103 br 107
 104 acc8= constant 0
 105 call writeAcc8
 106 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
 107 acc16= variable 1
 108 <acc16
 109 acc8= constant 3
 110 acc8* constant 3
 111 acc16= unstack16
 112 acc16CompareAcc8
 113 brle 117
 114 acc8= constant 13
 115 call writeAcc8
 116 br 120
 117 acc8= constant 0
 118 call writeAcc8
 119 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
 120 acc8= variable 0
 121 <acc8
 122 acc16= constant 6561
 123 acc16* constant 1
 124 acc8= unstack8
 125 acc8CompareAcc16
 126 brge 130
 127 acc8= constant 12
 128 call writeAcc8
 129 br 133
 130 acc8= constant 0
 131 call writeAcc8
 132 ;test9.p(14)   if (i > b) write (11); else write (0);
 133 acc16= variable 1
 134 acc8= variable 0
 135 acc16CompareAcc8
 136 brle 140
 137 acc8= constant 11
 138 call writeAcc8
 139 br 143
 140 acc8= constant 0
 141 call writeAcc8
 142 ;test9.p(15)   if (b < i) write (10); else write (0);
 143 acc8= variable 0
 144 acc16= variable 1
 145 acc8CompareAcc16
 146 brge 150
 147 acc8= constant 10
 148 call writeAcc8
 149 br 154
 150 acc8= constant 0
 151 call writeAcc8
 152 ;test9.p(16) 
 153 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
 154 acc8= constant 3
 155 acc8* constant 3
 156 <acc8
 157 acc16= constant 6561
 158 acc16* constant 1
 159 acc8= unstack8
 160 acc8CompareAcc16
 161 brge 165
 162 acc8= constant 9
 163 call writeAcc8
 164 br 168
 165 acc8= constant 0
 166 call writeAcc8
 167 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
 168 acc16= constant 6561
 169 acc16* constant 1
 170 <acc16
 171 acc8= constant 3
 172 acc8* constant 3
 173 acc16= unstack16
 174 acc16CompareAcc8
 175 brle 179
 176 acc8= constant 8
 177 call writeAcc8
 178 br 182
 179 acc8= constant 0
 180 call writeAcc8
 181 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
 182 acc16= constant 6561
 183 acc16* constant 1
 184 acc8= constant 9
 185 acc8CompareAcc16
 186 brge 190
 187 acc8= constant 7
 188 call writeAcc8
 189 br 193
 190 acc8= constant 0
 191 call writeAcc8
 192 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
 193 acc16= constant 6561
 194 acc16* constant 1
 195 acc8= constant 9
 196 acc16CompareAcc8
 197 brle 201
 198 acc8= constant 6
 199 call writeAcc8
 200 br 204
 201 acc8= constant 0
 202 call writeAcc8
 203 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
 204 acc8= constant 3
 205 acc8* constant 3
 206 acc16= constant 6561
 207 acc16CompareAcc8
 208 brle 212
 209 acc8= constant 5
 210 call writeAcc8
 211 br 215
 212 acc8= constant 0
 213 call writeAcc8
 214 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
 215 acc8= constant 3
 216 acc8* constant 3
 217 acc16= constant 6561
 218 acc8CompareAcc16
 219 brge 223
 220 acc8= constant 4
 221 call writeAcc8
 222 br 226
 223 acc8= constant 0
 224 call writeAcc8
 225 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
 226 acc8= constant 9
 227 acc16= constant 6561
 228 acc8CompareAcc16
 229 brge 233
 230 acc8= constant 3
 231 call writeAcc8
 232 br 236
 233 acc8= constant 0
 234 call writeAcc8
 235 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
 236 acc16= constant 6561
 237 acc8= constant 9
 238 acc16CompareAcc8
 239 brle 243
 240 acc8= constant 2
 241 call writeAcc8
 242 br 246
 243 acc8= constant 0
 244 call writeAcc8
 245 ;test9.p(25)   write(1);
 246 acc8= constant 1
 247 call writeAcc8
 248 ;test9.p(26)   write(0);
 249 acc8= constant 0
 250 call writeAcc8
 251 ;test9.p(27) }
 252 stop
