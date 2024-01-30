   0 ;test9.j(0) /* Program to test multiplication */
   1 ;test9.j(1) class TestMultiplyComparison {
   2 class TestMultiplyComparison []
   3 ;test9.j(2)   private static byte b = 9;
   4 acc8= constant 9
   5 acc8=> variable 0
   6 ;test9.j(3)   private static word i = 6561;
   7 acc16= constant 6561
   8 acc16=> variable 1
   9 ;test9.j(4) 
  10 ;test9.j(5)   public static void main() {
  11 method main [public, static] void
  12 ;test9.j(6)     println(0);
  13 acc8= constant 0
  14 call writeLineAcc8
  15 ;test9.j(7)     println(1);
  16 acc8= constant 1
  17 call writeLineAcc8
  18 ;test9.j(8)     if (6561 > 9) println (2); else println (999);
  19 acc16= constant 6561
  20 acc8= constant 9
  21 acc16CompareAcc8
  22 brle 26
  23 acc8= constant 2
  24 call writeLineAcc8
  25 br 29
  26 acc16= constant 999
  27 call writeLineAcc16
  28 ;test9.j(9)     if (9 < 6561) println (3); else println (999);
  29 acc8= constant 9
  30 acc16= constant 6561
  31 acc8CompareAcc16
  32 brge 36
  33 acc8= constant 3
  34 call writeLineAcc8
  35 br 39
  36 acc16= constant 999
  37 call writeLineAcc16
  38 ;test9.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  39 acc8= constant 3
  40 acc8* constant 3
  41 acc16= constant 6561
  42 acc8CompareAcc16
  43 brge 47
  44 acc8= constant 4
  45 call writeLineAcc8
  46 br 50
  47 acc16= constant 999
  48 call writeLineAcc16
  49 ;test9.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  50 acc8= constant 3
  51 acc8* constant 3
  52 acc16= constant 6561
  53 acc16CompareAcc8
  54 brle 58
  55 acc8= constant 5
  56 call writeLineAcc8
  57 br 61
  58 acc16= constant 999
  59 call writeLineAcc16
  60 ;test9.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  61 acc16= constant 6561
  62 acc16* constant 1
  63 acc8= constant 9
  64 acc16CompareAcc8
  65 brle 69
  66 acc8= constant 6
  67 call writeLineAcc8
  68 br 72
  69 acc16= constant 999
  70 call writeLineAcc16
  71 ;test9.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  72 acc16= constant 6561
  73 acc16* constant 1
  74 acc8= constant 9
  75 acc8CompareAcc16
  76 brge 80
  77 acc8= constant 7
  78 call writeLineAcc8
  79 br 83
  80 acc16= constant 999
  81 call writeLineAcc16
  82 ;test9.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  83 acc16= constant 6561
  84 acc16* constant 1
  85 <acc16
  86 acc8= constant 3
  87 acc8* constant 3
  88 acc16= unstack16
  89 acc16CompareAcc8
  90 brle 94
  91 acc8= constant 8
  92 call writeLineAcc8
  93 br 97
  94 acc16= constant 999
  95 call writeLineAcc16
  96 ;test9.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
  97 acc8= constant 3
  98 acc8* constant 3
  99 <acc8
 100 acc16= constant 6561
 101 acc16* constant 1
 102 acc8= unstack8
 103 acc8CompareAcc16
 104 brge 108
 105 acc8= constant 9
 106 call writeLineAcc8
 107 br 112
 108 acc16= constant 999
 109 call writeLineAcc16
 110 ;test9.j(16)   
 111 ;test9.j(17)     if (b < i) println (10); else println (999);
 112 acc8= variable 0
 113 acc16= variable 1
 114 acc8CompareAcc16
 115 brge 119
 116 acc8= constant 10
 117 call writeLineAcc8
 118 br 122
 119 acc16= constant 999
 120 call writeLineAcc16
 121 ;test9.j(18)     if (i > b) println (11); else println (999);
 122 acc16= variable 1
 123 acc8= variable 0
 124 acc16CompareAcc8
 125 brle 129
 126 acc8= constant 11
 127 call writeLineAcc8
 128 br 132
 129 acc16= constant 999
 130 call writeLineAcc16
 131 ;test9.j(19)     if (b < 6561 * 1) println (12); else println (999);
 132 acc16= constant 6561
 133 acc16* constant 1
 134 acc8= variable 0
 135 acc8CompareAcc16
 136 brge 140
 137 acc8= constant 12
 138 call writeLineAcc8
 139 br 143
 140 acc16= constant 999
 141 call writeLineAcc16
 142 ;test9.j(20)     if (i > 3 * 3) println (13); else println (999);
 143 acc8= constant 3
 144 acc8* constant 3
 145 acc16= variable 1
 146 acc16CompareAcc8
 147 brle 151
 148 acc8= constant 13
 149 call writeLineAcc8
 150 br 154
 151 acc16= constant 999
 152 call writeLineAcc16
 153 ;test9.j(21)     if (6561 * 1 > b) println (14); else println (999);
 154 acc16= constant 6561
 155 acc16* constant 1
 156 acc8= variable 0
 157 acc16CompareAcc8
 158 brle 162
 159 acc8= constant 14
 160 call writeLineAcc8
 161 br 165
 162 acc16= constant 999
 163 call writeLineAcc16
 164 ;test9.j(22)     if (3 * 3 < i) println (15); else println (999);
 165 acc8= constant 3
 166 acc8* constant 3
 167 acc16= variable 1
 168 acc8CompareAcc16
 169 brge 173
 170 acc8= constant 15
 171 call writeLineAcc8
 172 br 176
 173 acc16= constant 999
 174 call writeLineAcc16
 175 ;test9.j(23)     if (b < i * 1) println (16); else println (999);
 176 acc16= variable 1
 177 acc16* constant 1
 178 acc8= variable 0
 179 acc8CompareAcc16
 180 brge 184
 181 acc8= constant 16
 182 call writeLineAcc8
 183 br 187
 184 acc16= constant 999
 185 call writeLineAcc16
 186 ;test9.j(24)     if (i > b * 1) println (17); else println (999);
 187 acc8= variable 0
 188 acc8* constant 1
 189 acc16= variable 1
 190 acc16CompareAcc8
 191 brle 195
 192 acc8= constant 17
 193 call writeLineAcc8
 194 br 198
 195 acc16= constant 999
 196 call writeLineAcc16
 197 ;test9.j(25)     if (b * 1 < i) println (18); else println (999);
 198 acc8= variable 0
 199 acc8* constant 1
 200 acc16= variable 1
 201 acc8CompareAcc16
 202 brge 206
 203 acc8= constant 18
 204 call writeLineAcc8
 205 br 209
 206 acc16= constant 999
 207 call writeLineAcc16
 208 ;test9.j(26)     if (i * 1 > b) println (19); else println (999);
 209 acc16= variable 1
 210 acc16* constant 1
 211 acc8= variable 0
 212 acc16CompareAcc8
 213 brle 217
 214 acc8= constant 19
 215 call writeLineAcc8
 216 br 220
 217 acc16= constant 999
 218 call writeLineAcc16
 219 ;test9.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 220 acc8= variable 0
 221 acc8* constant 1
 222 <acc8
 223 acc16= variable 1
 224 acc16* constant 1
 225 acc8= unstack8
 226 acc8CompareAcc16
 227 brge 231
 228 acc8= constant 20
 229 call writeLineAcc8
 230 br 234
 231 acc16= constant 999
 232 call writeLineAcc16
 233 ;test9.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 234 acc16= variable 1
 235 acc16* constant 1
 236 <acc16
 237 acc8= variable 0
 238 acc8* constant 1
 239 acc16= unstack16
 240 acc16CompareAcc8
 241 brle 245
 242 acc8= constant 21
 243 call writeLineAcc8
 244 br 249
 245 acc16= constant 999
 246 call writeLineAcc16
 247 ;test9.j(29)   
 248 ;test9.j(30)     println("Klaar");
 249 acc16= constant 254
 250 writeLineString
 251 ;test9.j(31)   }
 252 ;test9.j(32) }
 253 stop
 254 stringConstant 0 = "Klaar"
