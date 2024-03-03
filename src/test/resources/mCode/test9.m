   0 call 13
   1 stop
   2 ;test9.j(0) /* Program to test multiplication */
   3 ;test9.j(1) class TestMultiplyComparison {
   4 class TestMultiplyComparison []
   5 ;test9.j(2)   private static byte b = 9;
   6 acc8= constant 9
   7 acc8=> variable 0
   8 ;test9.j(3)   private static word i = 6561;
   9 acc16= constant 6561
  10 acc16=> variable 1
  11 ;test9.j(4) 
  12 ;test9.j(5)   public static void main() {
  13 method main [public, static] void
  14 ;test9.j(6)     println(0);
  15 acc8= constant 0
  16 call writeLineAcc8
  17 ;test9.j(7)     println(1);
  18 acc8= constant 1
  19 call writeLineAcc8
  20 ;test9.j(8)     if (6561 > 9) println (2); else println (999);
  21 acc16= constant 6561
  22 acc8= constant 9
  23 acc16CompareAcc8
  24 brle 28
  25 acc8= constant 2
  26 call writeLineAcc8
  27 br 31
  28 acc16= constant 999
  29 call writeLineAcc16
  30 ;test9.j(9)     if (9 < 6561) println (3); else println (999);
  31 acc8= constant 9
  32 acc16= constant 6561
  33 acc8CompareAcc16
  34 brge 38
  35 acc8= constant 3
  36 call writeLineAcc8
  37 br 41
  38 acc16= constant 999
  39 call writeLineAcc16
  40 ;test9.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  41 acc8= constant 3
  42 acc8* constant 3
  43 acc16= constant 6561
  44 acc8CompareAcc16
  45 brge 51
  46 acc8= constant 4
  47 call writeLineAcc8
  48 br 54
  49 acc16= constant 999
  50 call writeLineAcc16
  51 ;test9.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  52 acc8= constant 3
  53 acc8* constant 3
  54 acc16= constant 6561
  55 acc16CompareAcc8
  56 brle 62
  57 acc8= constant 5
  58 call writeLineAcc8
  59 br 65
  60 acc16= constant 999
  61 call writeLineAcc16
  62 ;test9.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  63 acc16= constant 6561
  64 acc16* constant 1
  65 acc8= constant 9
  66 acc16CompareAcc8
  67 brle 75
  68 acc8= constant 6
  69 call writeLineAcc8
  70 br 78
  71 acc16= constant 999
  72 call writeLineAcc16
  73 ;test9.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  74 acc16= constant 6561
  75 acc16* constant 1
  76 acc8= constant 9
  77 acc8CompareAcc16
  78 brge 86
  79 acc8= constant 7
  80 call writeLineAcc8
  81 br 89
  82 acc16= constant 999
  83 call writeLineAcc16
  84 ;test9.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  85 acc16= constant 6561
  86 acc16* constant 1
  87 <acc16
  88 acc8= constant 3
  89 acc8* constant 3
  90 acc16= unstack16
  91 acc16CompareAcc8
  92 brle 100
  93 acc8= constant 8
  94 call writeLineAcc8
  95 br 103
  96 acc16= constant 999
  97 call writeLineAcc16
  98 ;test9.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
  99 acc8= constant 3
 100 acc8* constant 3
 101 <acc8
 102 acc16= constant 6561
 103 acc16* constant 1
 104 acc8= unstack8
 105 acc8CompareAcc16
 106 brge 114
 107 acc8= constant 9
 108 call writeLineAcc8
 109 br 118
 110 acc16= constant 999
 111 call writeLineAcc16
 112 ;test9.j(16)   
 113 ;test9.j(17)     if (b < i) println (10); else println (999);
 114 acc8= variable 0
 115 acc16= variable 1
 116 acc8CompareAcc16
 117 brge 125
 118 acc8= constant 10
 119 call writeLineAcc8
 120 br 128
 121 acc16= constant 999
 122 call writeLineAcc16
 123 ;test9.j(18)     if (i > b) println (11); else println (999);
 124 acc16= variable 1
 125 acc8= variable 0
 126 acc16CompareAcc8
 127 brle 135
 128 acc8= constant 11
 129 call writeLineAcc8
 130 br 138
 131 acc16= constant 999
 132 call writeLineAcc16
 133 ;test9.j(19)     if (b < 6561 * 1) println (12); else println (999);
 134 acc16= constant 6561
 135 acc16* constant 1
 136 acc8= variable 0
 137 acc8CompareAcc16
 138 brge 146
 139 acc8= constant 12
 140 call writeLineAcc8
 141 br 149
 142 acc16= constant 999
 143 call writeLineAcc16
 144 ;test9.j(20)     if (i > 3 * 3) println (13); else println (999);
 145 acc8= constant 3
 146 acc8* constant 3
 147 acc16= variable 1
 148 acc16CompareAcc8
 149 brle 157
 150 acc8= constant 13
 151 call writeLineAcc8
 152 br 160
 153 acc16= constant 999
 154 call writeLineAcc16
 155 ;test9.j(21)     if (6561 * 1 > b) println (14); else println (999);
 156 acc16= constant 6561
 157 acc16* constant 1
 158 acc8= variable 0
 159 acc16CompareAcc8
 160 brle 170
 161 acc8= constant 14
 162 call writeLineAcc8
 163 br 173
 164 acc16= constant 999
 165 call writeLineAcc16
 166 ;test9.j(22)     if (3 * 3 < i) println (15); else println (999);
 167 acc8= constant 3
 168 acc8* constant 3
 169 acc16= variable 1
 170 acc8CompareAcc16
 171 brge 183
 172 acc8= constant 15
 173 call writeLineAcc8
 174 br 186
 175 acc16= constant 999
 176 call writeLineAcc16
 177 ;test9.j(23)     if (b < i * 1) println (16); else println (999);
 178 acc16= variable 1
 179 acc16* constant 1
 180 acc8= variable 0
 181 acc8CompareAcc16
 182 brge 194
 183 acc8= constant 16
 184 call writeLineAcc8
 185 br 197
 186 acc16= constant 999
 187 call writeLineAcc16
 188 ;test9.j(24)     if (i > b * 1) println (17); else println (999);
 189 acc8= variable 0
 190 acc8* constant 1
 191 acc16= variable 1
 192 acc16CompareAcc8
 193 brle 205
 194 acc8= constant 17
 195 call writeLineAcc8
 196 br 208
 197 acc16= constant 999
 198 call writeLineAcc16
 199 ;test9.j(25)     if (b * 1 < i) println (18); else println (999);
 200 acc8= variable 0
 201 acc8* constant 1
 202 acc16= variable 1
 203 acc8CompareAcc16
 204 brge 218
 205 acc8= constant 18
 206 call writeLineAcc8
 207 br 221
 208 acc16= constant 999
 209 call writeLineAcc16
 210 ;test9.j(26)     if (i * 1 > b) println (19); else println (999);
 211 acc16= variable 1
 212 acc16* constant 1
 213 acc8= variable 0
 214 acc16CompareAcc8
 215 brle 231
 216 acc8= constant 19
 217 call writeLineAcc8
 218 br 234
 219 acc16= constant 999
 220 call writeLineAcc16
 221 ;test9.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 222 acc8= variable 0
 223 acc8* constant 1
 224 <acc8
 225 acc16= variable 1
 226 acc16* constant 1
 227 acc8= unstack8
 228 acc8CompareAcc16
 229 brge 245
 230 acc8= constant 20
 231 call writeLineAcc8
 232 br 248
 233 acc16= constant 999
 234 call writeLineAcc16
 235 ;test9.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 236 acc16= variable 1
 237 acc16* constant 1
 238 <acc16
 239 acc8= variable 0
 240 acc8* constant 1
 241 acc16= unstack16
 242 acc16CompareAcc8
 243 brle 259
 244 acc8= constant 21
 245 call writeLineAcc8
 246 br 263
 247 acc16= constant 999
 248 call writeLineAcc16
 249 ;test9.j(29)   
 250 ;test9.j(30)     println("Klaar");
 251 acc16= stringconstant 256
 252 writeLineString
 253 return
 254 ;test9.j(31)   }
 255 ;test9.j(32) }
 256 stringConstant 0 = "Klaar"
