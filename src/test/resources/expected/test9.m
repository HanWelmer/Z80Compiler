   0 ;test9.j(0) /* Program to test multiplication */
   1 ;test9.j(1) class TestMultiplyComparison {
   2 ;test9.j(2)   private static byte b = 9;
   3 acc8= constant 9
   4 acc8=> variable 0
   5 ;test9.j(3)   private static word i = 6561;
   6 acc16= constant 6561
   7 acc16=> variable 1
   8 ;test9.j(4) 
   9 ;test9.j(5)   public static void main() {
  10 ;test9.j(6)     println(0);
  11 acc8= constant 0
  12 call writeLineAcc8
  13 ;test9.j(7)     println(1);
  14 acc8= constant 1
  15 call writeLineAcc8
  16 ;test9.j(8)     if (6561 > 9) println (2); else println (999);
  17 acc16= constant 6561
  18 acc8= constant 9
  19 acc16CompareAcc8
  20 brle 24
  21 acc8= constant 2
  22 call writeLineAcc8
  23 br 27
  24 acc16= constant 999
  25 call writeLineAcc16
  26 ;test9.j(9)     if (9 < 6561) println (3); else println (999);
  27 acc8= constant 9
  28 acc16= constant 6561
  29 acc8CompareAcc16
  30 brge 34
  31 acc8= constant 3
  32 call writeLineAcc8
  33 br 37
  34 acc16= constant 999
  35 call writeLineAcc16
  36 ;test9.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  37 acc8= constant 3
  38 acc8* constant 3
  39 acc16= constant 6561
  40 acc8CompareAcc16
  41 brge 45
  42 acc8= constant 4
  43 call writeLineAcc8
  44 br 48
  45 acc16= constant 999
  46 call writeLineAcc16
  47 ;test9.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  48 acc8= constant 3
  49 acc8* constant 3
  50 acc16= constant 6561
  51 acc16CompareAcc8
  52 brle 56
  53 acc8= constant 5
  54 call writeLineAcc8
  55 br 59
  56 acc16= constant 999
  57 call writeLineAcc16
  58 ;test9.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  59 acc16= constant 6561
  60 acc16* constant 1
  61 acc8= constant 9
  62 acc16CompareAcc8
  63 brle 67
  64 acc8= constant 6
  65 call writeLineAcc8
  66 br 70
  67 acc16= constant 999
  68 call writeLineAcc16
  69 ;test9.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  70 acc16= constant 6561
  71 acc16* constant 1
  72 acc8= constant 9
  73 acc8CompareAcc16
  74 brge 78
  75 acc8= constant 7
  76 call writeLineAcc8
  77 br 81
  78 acc16= constant 999
  79 call writeLineAcc16
  80 ;test9.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  81 acc16= constant 6561
  82 acc16* constant 1
  83 <acc16
  84 acc8= constant 3
  85 acc8* constant 3
  86 acc16= unstack16
  87 acc16CompareAcc8
  88 brle 92
  89 acc8= constant 8
  90 call writeLineAcc8
  91 br 95
  92 acc16= constant 999
  93 call writeLineAcc16
  94 ;test9.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
  95 acc8= constant 3
  96 acc8* constant 3
  97 <acc8
  98 acc16= constant 6561
  99 acc16* constant 1
 100 acc8= unstack8
 101 acc8CompareAcc16
 102 brge 106
 103 acc8= constant 9
 104 call writeLineAcc8
 105 br 110
 106 acc16= constant 999
 107 call writeLineAcc16
 108 ;test9.j(16)   
 109 ;test9.j(17)     if (b < i) println (10); else println (999);
 110 acc8= variable 0
 111 acc16= variable 1
 112 acc8CompareAcc16
 113 brge 117
 114 acc8= constant 10
 115 call writeLineAcc8
 116 br 120
 117 acc16= constant 999
 118 call writeLineAcc16
 119 ;test9.j(18)     if (i > b) println (11); else println (999);
 120 acc16= variable 1
 121 acc8= variable 0
 122 acc16CompareAcc8
 123 brle 127
 124 acc8= constant 11
 125 call writeLineAcc8
 126 br 130
 127 acc16= constant 999
 128 call writeLineAcc16
 129 ;test9.j(19)     if (b < 6561 * 1) println (12); else println (999);
 130 acc16= constant 6561
 131 acc16* constant 1
 132 acc8= variable 0
 133 acc8CompareAcc16
 134 brge 138
 135 acc8= constant 12
 136 call writeLineAcc8
 137 br 141
 138 acc16= constant 999
 139 call writeLineAcc16
 140 ;test9.j(20)     if (i > 3 * 3) println (13); else println (999);
 141 acc8= constant 3
 142 acc8* constant 3
 143 acc16= variable 1
 144 acc16CompareAcc8
 145 brle 149
 146 acc8= constant 13
 147 call writeLineAcc8
 148 br 152
 149 acc16= constant 999
 150 call writeLineAcc16
 151 ;test9.j(21)     if (6561 * 1 > b) println (14); else println (999);
 152 acc16= constant 6561
 153 acc16* constant 1
 154 acc8= variable 0
 155 acc16CompareAcc8
 156 brle 160
 157 acc8= constant 14
 158 call writeLineAcc8
 159 br 163
 160 acc16= constant 999
 161 call writeLineAcc16
 162 ;test9.j(22)     if (3 * 3 < i) println (15); else println (999);
 163 acc8= constant 3
 164 acc8* constant 3
 165 acc16= variable 1
 166 acc8CompareAcc16
 167 brge 171
 168 acc8= constant 15
 169 call writeLineAcc8
 170 br 174
 171 acc16= constant 999
 172 call writeLineAcc16
 173 ;test9.j(23)     if (b < i * 1) println (16); else println (999);
 174 acc16= variable 1
 175 acc16* constant 1
 176 acc8= variable 0
 177 acc8CompareAcc16
 178 brge 182
 179 acc8= constant 16
 180 call writeLineAcc8
 181 br 185
 182 acc16= constant 999
 183 call writeLineAcc16
 184 ;test9.j(24)     if (i > b * 1) println (17); else println (999);
 185 acc8= variable 0
 186 acc8* constant 1
 187 acc16= variable 1
 188 acc16CompareAcc8
 189 brle 193
 190 acc8= constant 17
 191 call writeLineAcc8
 192 br 196
 193 acc16= constant 999
 194 call writeLineAcc16
 195 ;test9.j(25)     if (b * 1 < i) println (18); else println (999);
 196 acc8= variable 0
 197 acc8* constant 1
 198 acc16= variable 1
 199 acc8CompareAcc16
 200 brge 204
 201 acc8= constant 18
 202 call writeLineAcc8
 203 br 207
 204 acc16= constant 999
 205 call writeLineAcc16
 206 ;test9.j(26)     if (i * 1 > b) println (19); else println (999);
 207 acc16= variable 1
 208 acc16* constant 1
 209 acc8= variable 0
 210 acc16CompareAcc8
 211 brle 215
 212 acc8= constant 19
 213 call writeLineAcc8
 214 br 218
 215 acc16= constant 999
 216 call writeLineAcc16
 217 ;test9.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 218 acc8= variable 0
 219 acc8* constant 1
 220 <acc8
 221 acc16= variable 1
 222 acc16* constant 1
 223 acc8= unstack8
 224 acc8CompareAcc16
 225 brge 229
 226 acc8= constant 20
 227 call writeLineAcc8
 228 br 232
 229 acc16= constant 999
 230 call writeLineAcc16
 231 ;test9.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 232 acc16= variable 1
 233 acc16* constant 1
 234 <acc16
 235 acc8= variable 0
 236 acc8* constant 1
 237 acc16= unstack16
 238 acc16CompareAcc8
 239 brle 243
 240 acc8= constant 21
 241 call writeLineAcc8
 242 br 247
 243 acc16= constant 999
 244 call writeLineAcc16
 245 ;test9.j(29)   
 246 ;test9.j(30)     println("Klaar");
 247 acc16= constant 252
 248 writeLineString
 249 ;test9.j(31)   }
 250 ;test9.j(32) }
 251 stop
 252 stringConstant 0 = "Klaar"
