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
  10 method main [staticLexeme] voidLexeme
  11 ;test9.j(6)     println(0);
  12 acc8= constant 0
  13 call writeLineAcc8
  14 ;test9.j(7)     println(1);
  15 acc8= constant 1
  16 call writeLineAcc8
  17 ;test9.j(8)     if (6561 > 9) println (2); else println (999);
  18 acc16= constant 6561
  19 acc8= constant 9
  20 acc16CompareAcc8
  21 brle 25
  22 acc8= constant 2
  23 call writeLineAcc8
  24 br 28
  25 acc16= constant 999
  26 call writeLineAcc16
  27 ;test9.j(9)     if (9 < 6561) println (3); else println (999);
  28 acc8= constant 9
  29 acc16= constant 6561
  30 acc8CompareAcc16
  31 brge 35
  32 acc8= constant 3
  33 call writeLineAcc8
  34 br 38
  35 acc16= constant 999
  36 call writeLineAcc16
  37 ;test9.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  38 acc8= constant 3
  39 acc8* constant 3
  40 acc16= constant 6561
  41 acc8CompareAcc16
  42 brge 46
  43 acc8= constant 4
  44 call writeLineAcc8
  45 br 49
  46 acc16= constant 999
  47 call writeLineAcc16
  48 ;test9.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  49 acc8= constant 3
  50 acc8* constant 3
  51 acc16= constant 6561
  52 acc16CompareAcc8
  53 brle 57
  54 acc8= constant 5
  55 call writeLineAcc8
  56 br 60
  57 acc16= constant 999
  58 call writeLineAcc16
  59 ;test9.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  60 acc16= constant 6561
  61 acc16* constant 1
  62 acc8= constant 9
  63 acc16CompareAcc8
  64 brle 68
  65 acc8= constant 6
  66 call writeLineAcc8
  67 br 71
  68 acc16= constant 999
  69 call writeLineAcc16
  70 ;test9.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  71 acc16= constant 6561
  72 acc16* constant 1
  73 acc8= constant 9
  74 acc8CompareAcc16
  75 brge 79
  76 acc8= constant 7
  77 call writeLineAcc8
  78 br 82
  79 acc16= constant 999
  80 call writeLineAcc16
  81 ;test9.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  82 acc16= constant 6561
  83 acc16* constant 1
  84 <acc16
  85 acc8= constant 3
  86 acc8* constant 3
  87 acc16= unstack16
  88 acc16CompareAcc8
  89 brle 93
  90 acc8= constant 8
  91 call writeLineAcc8
  92 br 96
  93 acc16= constant 999
  94 call writeLineAcc16
  95 ;test9.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
  96 acc8= constant 3
  97 acc8* constant 3
  98 <acc8
  99 acc16= constant 6561
 100 acc16* constant 1
 101 acc8= unstack8
 102 acc8CompareAcc16
 103 brge 107
 104 acc8= constant 9
 105 call writeLineAcc8
 106 br 111
 107 acc16= constant 999
 108 call writeLineAcc16
 109 ;test9.j(16)   
 110 ;test9.j(17)     if (b < i) println (10); else println (999);
 111 acc8= variable 0
 112 acc16= variable 1
 113 acc8CompareAcc16
 114 brge 118
 115 acc8= constant 10
 116 call writeLineAcc8
 117 br 121
 118 acc16= constant 999
 119 call writeLineAcc16
 120 ;test9.j(18)     if (i > b) println (11); else println (999);
 121 acc16= variable 1
 122 acc8= variable 0
 123 acc16CompareAcc8
 124 brle 128
 125 acc8= constant 11
 126 call writeLineAcc8
 127 br 131
 128 acc16= constant 999
 129 call writeLineAcc16
 130 ;test9.j(19)     if (b < 6561 * 1) println (12); else println (999);
 131 acc16= constant 6561
 132 acc16* constant 1
 133 acc8= variable 0
 134 acc8CompareAcc16
 135 brge 139
 136 acc8= constant 12
 137 call writeLineAcc8
 138 br 142
 139 acc16= constant 999
 140 call writeLineAcc16
 141 ;test9.j(20)     if (i > 3 * 3) println (13); else println (999);
 142 acc8= constant 3
 143 acc8* constant 3
 144 acc16= variable 1
 145 acc16CompareAcc8
 146 brle 150
 147 acc8= constant 13
 148 call writeLineAcc8
 149 br 153
 150 acc16= constant 999
 151 call writeLineAcc16
 152 ;test9.j(21)     if (6561 * 1 > b) println (14); else println (999);
 153 acc16= constant 6561
 154 acc16* constant 1
 155 acc8= variable 0
 156 acc16CompareAcc8
 157 brle 161
 158 acc8= constant 14
 159 call writeLineAcc8
 160 br 164
 161 acc16= constant 999
 162 call writeLineAcc16
 163 ;test9.j(22)     if (3 * 3 < i) println (15); else println (999);
 164 acc8= constant 3
 165 acc8* constant 3
 166 acc16= variable 1
 167 acc8CompareAcc16
 168 brge 172
 169 acc8= constant 15
 170 call writeLineAcc8
 171 br 175
 172 acc16= constant 999
 173 call writeLineAcc16
 174 ;test9.j(23)     if (b < i * 1) println (16); else println (999);
 175 acc16= variable 1
 176 acc16* constant 1
 177 acc8= variable 0
 178 acc8CompareAcc16
 179 brge 183
 180 acc8= constant 16
 181 call writeLineAcc8
 182 br 186
 183 acc16= constant 999
 184 call writeLineAcc16
 185 ;test9.j(24)     if (i > b * 1) println (17); else println (999);
 186 acc8= variable 0
 187 acc8* constant 1
 188 acc16= variable 1
 189 acc16CompareAcc8
 190 brle 194
 191 acc8= constant 17
 192 call writeLineAcc8
 193 br 197
 194 acc16= constant 999
 195 call writeLineAcc16
 196 ;test9.j(25)     if (b * 1 < i) println (18); else println (999);
 197 acc8= variable 0
 198 acc8* constant 1
 199 acc16= variable 1
 200 acc8CompareAcc16
 201 brge 205
 202 acc8= constant 18
 203 call writeLineAcc8
 204 br 208
 205 acc16= constant 999
 206 call writeLineAcc16
 207 ;test9.j(26)     if (i * 1 > b) println (19); else println (999);
 208 acc16= variable 1
 209 acc16* constant 1
 210 acc8= variable 0
 211 acc16CompareAcc8
 212 brle 216
 213 acc8= constant 19
 214 call writeLineAcc8
 215 br 219
 216 acc16= constant 999
 217 call writeLineAcc16
 218 ;test9.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 219 acc8= variable 0
 220 acc8* constant 1
 221 <acc8
 222 acc16= variable 1
 223 acc16* constant 1
 224 acc8= unstack8
 225 acc8CompareAcc16
 226 brge 230
 227 acc8= constant 20
 228 call writeLineAcc8
 229 br 233
 230 acc16= constant 999
 231 call writeLineAcc16
 232 ;test9.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 233 acc16= variable 1
 234 acc16* constant 1
 235 <acc16
 236 acc8= variable 0
 237 acc8* constant 1
 238 acc16= unstack16
 239 acc16CompareAcc8
 240 brle 244
 241 acc8= constant 21
 242 call writeLineAcc8
 243 br 248
 244 acc16= constant 999
 245 call writeLineAcc16
 246 ;test9.j(29)   
 247 ;test9.j(30)     println("Klaar");
 248 acc16= constant 253
 249 writeLineString
 250 ;test9.j(31)   }
 251 ;test9.j(32) }
 252 stop
 253 stringConstant 0 = "Klaar"
