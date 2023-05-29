   0 ;test9.j(0) /* Program to test multiplication */
   1 ;test9.j(1) class TestMultiply {
   2 ;test9.j(2)   byte b = 9;
   3 acc8= constant 9
   4 acc8=> variable 0
   5 ;test9.j(3)   word i = 6561;
   6 acc16= constant 6561
   7 acc16=> variable 1
   8 ;test9.j(4) 
   9 ;test9.j(5)   write(0);
  10 acc8= constant 0
  11 call writeAcc8
  12 ;test9.j(6)   write(1);
  13 acc8= constant 1
  14 call writeAcc8
  15 ;test9.j(7)   if (6561 > 9) write (2); else write (999);
  16 acc16= constant 6561
  17 acc8= constant 9
  18 acc16CompareAcc8
  19 brle 23
  20 acc8= constant 2
  21 call writeAcc8
  22 br 26
  23 acc16= constant 999
  24 call writeAcc16
  25 ;test9.j(8)   if (9 < 6561) write (3); else write (999);
  26 acc8= constant 9
  27 acc16= constant 6561
  28 acc8CompareAcc16
  29 brge 33
  30 acc8= constant 3
  31 call writeAcc8
  32 br 36
  33 acc16= constant 999
  34 call writeAcc16
  35 ;test9.j(9)   if (3 * 3 < 6561) write (4); else write (999);
  36 acc8= constant 3
  37 acc8* constant 3
  38 acc16= constant 6561
  39 acc8CompareAcc16
  40 brge 44
  41 acc8= constant 4
  42 call writeAcc8
  43 br 47
  44 acc16= constant 999
  45 call writeAcc16
  46 ;test9.j(10)   if (6561 > 3 * 3) write (5); else write (999);
  47 acc8= constant 3
  48 acc8* constant 3
  49 acc16= constant 6561
  50 acc16CompareAcc8
  51 brle 55
  52 acc8= constant 5
  53 call writeAcc8
  54 br 58
  55 acc16= constant 999
  56 call writeAcc16
  57 ;test9.j(11)   if (6561 * 1 > 9) write (6); else write (999);
  58 acc16= constant 6561
  59 acc16* constant 1
  60 acc8= constant 9
  61 acc16CompareAcc8
  62 brle 66
  63 acc8= constant 6
  64 call writeAcc8
  65 br 69
  66 acc16= constant 999
  67 call writeAcc16
  68 ;test9.j(12)   if (9 < 6561 * 1) write (7); else write (999);
  69 acc16= constant 6561
  70 acc16* constant 1
  71 acc8= constant 9
  72 acc8CompareAcc16
  73 brge 77
  74 acc8= constant 7
  75 call writeAcc8
  76 br 80
  77 acc16= constant 999
  78 call writeAcc16
  79 ;test9.j(13)   if (6561 * 1 > 3 * 3) write (8); else write (999);
  80 acc16= constant 6561
  81 acc16* constant 1
  82 <acc16
  83 acc8= constant 3
  84 acc8* constant 3
  85 acc16= unstack16
  86 acc16CompareAcc8
  87 brle 91
  88 acc8= constant 8
  89 call writeAcc8
  90 br 94
  91 acc16= constant 999
  92 call writeAcc16
  93 ;test9.j(14)   if (3 * 3 < 6561 * 1) write (9); else write (999);
  94 acc8= constant 3
  95 acc8* constant 3
  96 <acc8
  97 acc16= constant 6561
  98 acc16* constant 1
  99 acc8= unstack8
 100 acc8CompareAcc16
 101 brge 105
 102 acc8= constant 9
 103 call writeAcc8
 104 br 109
 105 acc16= constant 999
 106 call writeAcc16
 107 ;test9.j(15) 
 108 ;test9.j(16)   if (b < i) write (10); else write (999);
 109 acc8= variable 0
 110 acc16= variable 1
 111 acc8CompareAcc16
 112 brge 116
 113 acc8= constant 10
 114 call writeAcc8
 115 br 119
 116 acc16= constant 999
 117 call writeAcc16
 118 ;test9.j(17)   if (i > b) write (11); else write (999);
 119 acc16= variable 1
 120 acc8= variable 0
 121 acc16CompareAcc8
 122 brle 126
 123 acc8= constant 11
 124 call writeAcc8
 125 br 129
 126 acc16= constant 999
 127 call writeAcc16
 128 ;test9.j(18)   if (b < 6561 * 1) write (12); else write (999);
 129 acc16= constant 6561
 130 acc16* constant 1
 131 acc8= variable 0
 132 acc8CompareAcc16
 133 brge 137
 134 acc8= constant 12
 135 call writeAcc8
 136 br 140
 137 acc16= constant 999
 138 call writeAcc16
 139 ;test9.j(19)   if (i > 3 * 3) write (13); else write (999);
 140 acc8= constant 3
 141 acc8* constant 3
 142 acc16= variable 1
 143 acc16CompareAcc8
 144 brle 148
 145 acc8= constant 13
 146 call writeAcc8
 147 br 151
 148 acc16= constant 999
 149 call writeAcc16
 150 ;test9.j(20)   if (6561 * 1 > b) write (14); else write (999);
 151 acc16= constant 6561
 152 acc16* constant 1
 153 acc8= variable 0
 154 acc16CompareAcc8
 155 brle 159
 156 acc8= constant 14
 157 call writeAcc8
 158 br 162
 159 acc16= constant 999
 160 call writeAcc16
 161 ;test9.j(21)   if (3 * 3 < i) write (15); else write (999);
 162 acc8= constant 3
 163 acc8* constant 3
 164 acc16= variable 1
 165 acc8CompareAcc16
 166 brge 170
 167 acc8= constant 15
 168 call writeAcc8
 169 br 173
 170 acc16= constant 999
 171 call writeAcc16
 172 ;test9.j(22)   if (b < i * 1) write (16); else write (999);
 173 acc16= variable 1
 174 acc16* constant 1
 175 acc8= variable 0
 176 acc8CompareAcc16
 177 brge 181
 178 acc8= constant 16
 179 call writeAcc8
 180 br 184
 181 acc16= constant 999
 182 call writeAcc16
 183 ;test9.j(23)   if (i > b * 1) write (17); else write (999);
 184 acc8= variable 0
 185 acc8* constant 1
 186 acc16= variable 1
 187 acc16CompareAcc8
 188 brle 192
 189 acc8= constant 17
 190 call writeAcc8
 191 br 195
 192 acc16= constant 999
 193 call writeAcc16
 194 ;test9.j(24)   if (b * 1 < i) write (18); else write (999);
 195 acc8= variable 0
 196 acc8* constant 1
 197 acc16= variable 1
 198 acc8CompareAcc16
 199 brge 203
 200 acc8= constant 18
 201 call writeAcc8
 202 br 206
 203 acc16= constant 999
 204 call writeAcc16
 205 ;test9.j(25)   if (i * 1 > b) write (19); else write (999);
 206 acc16= variable 1
 207 acc16* constant 1
 208 acc8= variable 0
 209 acc16CompareAcc8
 210 brle 214
 211 acc8= constant 19
 212 call writeAcc8
 213 br 217
 214 acc16= constant 999
 215 call writeAcc16
 216 ;test9.j(26)   if (b * 1 < i * 1) write (20); else write (999);
 217 acc8= variable 0
 218 acc8* constant 1
 219 <acc8
 220 acc16= variable 1
 221 acc16* constant 1
 222 acc8= unstack8
 223 acc8CompareAcc16
 224 brge 228
 225 acc8= constant 20
 226 call writeAcc8
 227 br 231
 228 acc16= constant 999
 229 call writeAcc16
 230 ;test9.j(27)   if (i * 1 > b * 1) write (21); else write (999);
 231 acc16= variable 1
 232 acc16* constant 1
 233 <acc16
 234 acc8= variable 0
 235 acc8* constant 1
 236 acc16= unstack16
 237 acc16CompareAcc8
 238 brle 242
 239 acc8= constant 21
 240 call writeAcc8
 241 br 246
 242 acc16= constant 999
 243 call writeAcc16
 244 ;test9.j(28) 
 245 ;test9.j(29)   write("Klaar");
 246 acc16= constant 250
 247 writeString
 248 ;test9.j(30) }
 249 stop
 250 stringConstant 0 = "Klaar"
