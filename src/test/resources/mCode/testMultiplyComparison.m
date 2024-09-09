   0 call 6
   1 stop
   2 ;testMultiplyComparison.j(0) /* Program to test multiplication */
   3 ;testMultiplyComparison.j(1) class TestMultiplyComparison {
   4 class TestMultiplyComparison []
   5 ;testMultiplyComparison.j(2)   private static byte b = 9;
   6 acc8= constant 9
   7 acc8=> variable 0
   8 ;testMultiplyComparison.j(3)   private static word i = 6561;
   9 acc16= constant 6561
  10 acc16=> variable 1
  11 br 14
  12 ;testMultiplyComparison.j(4) 
  13 ;testMultiplyComparison.j(5)   public static void main() {
  14 method TestMultiplyComparison.main [public, static] void ()
  15 <basePointer
  16 basePointer= stackPointer
  17 stackPointer+ constant 0
  18 ;testMultiplyComparison.j(6)     println(0);
  19 acc8= constant 0
  20 writeLineAcc8
  21 ;testMultiplyComparison.j(7)     println(1);
  22 acc8= constant 1
  23 writeLineAcc8
  24 ;testMultiplyComparison.j(8)     if (6561 > 9) println (2); else println (999);
  25 acc16= constant 6561
  26 acc8= constant 9
  27 acc16CompareAcc8
  28 brle 32
  29 acc8= constant 2
  30 writeLineAcc8
  31 br 35
  32 acc16= constant 999
  33 writeLineAcc16
  34 ;testMultiplyComparison.j(9)     if (9 < 6561) println (3); else println (999);
  35 acc8= constant 9
  36 acc16= constant 6561
  37 acc8CompareAcc16
  38 brge 42
  39 acc8= constant 3
  40 writeLineAcc8
  41 br 45
  42 acc16= constant 999
  43 writeLineAcc16
  44 ;testMultiplyComparison.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  45 acc8= constant 3
  46 acc8* constant 3
  47 acc16= constant 6561
  48 acc8CompareAcc16
  49 brge 55
  50 acc8= constant 4
  51 writeLineAcc8
  52 br 58
  53 acc16= constant 999
  54 writeLineAcc16
  55 ;testMultiplyComparison.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  56 acc8= constant 3
  57 acc8* constant 3
  58 acc16= constant 6561
  59 acc16CompareAcc8
  60 brle 66
  61 acc8= constant 5
  62 writeLineAcc8
  63 br 69
  64 acc16= constant 999
  65 writeLineAcc16
  66 ;testMultiplyComparison.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  67 acc16= constant 6561
  68 acc16* constant 1
  69 acc8= constant 9
  70 acc16CompareAcc8
  71 brle 79
  72 acc8= constant 6
  73 writeLineAcc8
  74 br 82
  75 acc16= constant 999
  76 writeLineAcc16
  77 ;testMultiplyComparison.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  78 acc16= constant 6561
  79 acc16* constant 1
  80 acc8= constant 9
  81 acc8CompareAcc16
  82 brge 90
  83 acc8= constant 7
  84 writeLineAcc8
  85 br 93
  86 acc16= constant 999
  87 writeLineAcc16
  88 ;testMultiplyComparison.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  89 acc16= constant 6561
  90 acc16* constant 1
  91 <acc16
  92 acc8= constant 3
  93 acc8* constant 3
  94 acc16<
  95 acc16CompareAcc8
  96 brle 104
  97 acc8= constant 8
  98 writeLineAcc8
  99 br 107
 100 acc16= constant 999
 101 writeLineAcc16
 102 ;testMultiplyComparison.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
 103 acc8= constant 3
 104 acc8* constant 3
 105 <acc8
 106 acc16= constant 6561
 107 acc16* constant 1
 108 acc8<
 109 acc8CompareAcc16
 110 brge 118
 111 acc8= constant 9
 112 writeLineAcc8
 113 br 122
 114 acc16= constant 999
 115 writeLineAcc16
 116 ;testMultiplyComparison.j(16)   
 117 ;testMultiplyComparison.j(17)     if (b < i) println (10); else println (999);
 118 acc8= variable 0
 119 acc16= variable 1
 120 acc8CompareAcc16
 121 brge 129
 122 acc8= constant 10
 123 writeLineAcc8
 124 br 132
 125 acc16= constant 999
 126 writeLineAcc16
 127 ;testMultiplyComparison.j(18)     if (i > b) println (11); else println (999);
 128 acc16= variable 1
 129 acc8= variable 0
 130 acc16CompareAcc8
 131 brle 139
 132 acc8= constant 11
 133 writeLineAcc8
 134 br 142
 135 acc16= constant 999
 136 writeLineAcc16
 137 ;testMultiplyComparison.j(19)     if (b < 6561 * 1) println (12); else println (999);
 138 acc16= constant 6561
 139 acc16* constant 1
 140 acc8= variable 0
 141 acc8CompareAcc16
 142 brge 150
 143 acc8= constant 12
 144 writeLineAcc8
 145 br 153
 146 acc16= constant 999
 147 writeLineAcc16
 148 ;testMultiplyComparison.j(20)     if (i > 3 * 3) println (13); else println (999);
 149 acc8= constant 3
 150 acc8* constant 3
 151 acc16= variable 1
 152 acc16CompareAcc8
 153 brle 161
 154 acc8= constant 13
 155 writeLineAcc8
 156 br 164
 157 acc16= constant 999
 158 writeLineAcc16
 159 ;testMultiplyComparison.j(21)     if (6561 * 1 > b) println (14); else println (999);
 160 acc16= constant 6561
 161 acc16* constant 1
 162 acc8= variable 0
 163 acc16CompareAcc8
 164 brle 174
 165 acc8= constant 14
 166 writeLineAcc8
 167 br 177
 168 acc16= constant 999
 169 writeLineAcc16
 170 ;testMultiplyComparison.j(22)     if (3 * 3 < i) println (15); else println (999);
 171 acc8= constant 3
 172 acc8* constant 3
 173 acc16= variable 1
 174 acc8CompareAcc16
 175 brge 187
 176 acc8= constant 15
 177 writeLineAcc8
 178 br 190
 179 acc16= constant 999
 180 writeLineAcc16
 181 ;testMultiplyComparison.j(23)     if (b < i * 1) println (16); else println (999);
 182 acc16= variable 1
 183 acc16* constant 1
 184 acc8= variable 0
 185 acc8CompareAcc16
 186 brge 198
 187 acc8= constant 16
 188 writeLineAcc8
 189 br 201
 190 acc16= constant 999
 191 writeLineAcc16
 192 ;testMultiplyComparison.j(24)     if (i > b * 1) println (17); else println (999);
 193 acc8= variable 0
 194 acc8* constant 1
 195 acc16= variable 1
 196 acc16CompareAcc8
 197 brle 209
 198 acc8= constant 17
 199 writeLineAcc8
 200 br 212
 201 acc16= constant 999
 202 writeLineAcc16
 203 ;testMultiplyComparison.j(25)     if (b * 1 < i) println (18); else println (999);
 204 acc8= variable 0
 205 acc8* constant 1
 206 acc16= variable 1
 207 acc8CompareAcc16
 208 brge 222
 209 acc8= constant 18
 210 writeLineAcc8
 211 br 225
 212 acc16= constant 999
 213 writeLineAcc16
 214 ;testMultiplyComparison.j(26)     if (i * 1 > b) println (19); else println (999);
 215 acc16= variable 1
 216 acc16* constant 1
 217 acc8= variable 0
 218 acc16CompareAcc8
 219 brle 235
 220 acc8= constant 19
 221 writeLineAcc8
 222 br 238
 223 acc16= constant 999
 224 writeLineAcc16
 225 ;testMultiplyComparison.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 226 acc8= variable 0
 227 acc8* constant 1
 228 <acc8
 229 acc16= variable 1
 230 acc16* constant 1
 231 acc8<
 232 acc8CompareAcc16
 233 brge 249
 234 acc8= constant 20
 235 writeLineAcc8
 236 br 252
 237 acc16= constant 999
 238 writeLineAcc16
 239 ;testMultiplyComparison.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 240 acc16= variable 1
 241 acc16* constant 1
 242 <acc16
 243 acc8= variable 0
 244 acc8* constant 1
 245 acc16<
 246 acc16CompareAcc8
 247 brle 263
 248 acc8= constant 21
 249 writeLineAcc8
 250 br 267
 251 acc16= constant 999
 252 writeLineAcc16
 253 ;testMultiplyComparison.j(29)   
 254 ;testMultiplyComparison.j(30)     println("Klaar");
 255 acc16= stringconstant 262
 256 writeLineString
 257 ;testMultiplyComparison.j(31)   }
 258 stackPointer= basePointer
 259 basePointer<
 260 return
 261 ;testMultiplyComparison.j(32) }
 262 stringConstant 0 = "Klaar"
