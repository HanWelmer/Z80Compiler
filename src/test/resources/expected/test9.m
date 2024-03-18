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
  13 method main [public, static] void ()
  14 <basePointer
  15 basePointer= stackPointer
  16 stackPointer+ constant 0
  17 ;test9.j(6)     println(0);
  18 acc8= constant 0
  19 writeLineAcc8
  20 ;test9.j(7)     println(1);
  21 acc8= constant 1
  22 writeLineAcc8
  23 ;test9.j(8)     if (6561 > 9) println (2); else println (999);
  24 acc16= constant 6561
  25 acc8= constant 9
  26 acc16CompareAcc8
  27 brle 31
  28 acc8= constant 2
  29 writeLineAcc8
  30 br 34
  31 acc16= constant 999
  32 writeLineAcc16
  33 ;test9.j(9)     if (9 < 6561) println (3); else println (999);
  34 acc8= constant 9
  35 acc16= constant 6561
  36 acc8CompareAcc16
  37 brge 41
  38 acc8= constant 3
  39 writeLineAcc8
  40 br 44
  41 acc16= constant 999
  42 writeLineAcc16
  43 ;test9.j(10)     if (3 * 3 < 6561) println (4); else println (999);
  44 acc8= constant 3
  45 acc8* constant 3
  46 acc16= constant 6561
  47 acc8CompareAcc16
  48 brge 54
  49 acc8= constant 4
  50 writeLineAcc8
  51 br 57
  52 acc16= constant 999
  53 writeLineAcc16
  54 ;test9.j(11)     if (6561 > 3 * 3) println (5); else println (999);
  55 acc8= constant 3
  56 acc8* constant 3
  57 acc16= constant 6561
  58 acc16CompareAcc8
  59 brle 65
  60 acc8= constant 5
  61 writeLineAcc8
  62 br 68
  63 acc16= constant 999
  64 writeLineAcc16
  65 ;test9.j(12)     if (6561 * 1 > 9) println (6); else println (999);
  66 acc16= constant 6561
  67 acc16* constant 1
  68 acc8= constant 9
  69 acc16CompareAcc8
  70 brle 78
  71 acc8= constant 6
  72 writeLineAcc8
  73 br 81
  74 acc16= constant 999
  75 writeLineAcc16
  76 ;test9.j(13)     if (9 < 6561 * 1) println (7); else println (999);
  77 acc16= constant 6561
  78 acc16* constant 1
  79 acc8= constant 9
  80 acc8CompareAcc16
  81 brge 89
  82 acc8= constant 7
  83 writeLineAcc8
  84 br 92
  85 acc16= constant 999
  86 writeLineAcc16
  87 ;test9.j(14)     if (6561 * 1 > 3 * 3) println (8); else println (999);
  88 acc16= constant 6561
  89 acc16* constant 1
  90 <acc16
  91 acc8= constant 3
  92 acc8* constant 3
  93 acc16<
  94 acc16CompareAcc8
  95 brle 103
  96 acc8= constant 8
  97 writeLineAcc8
  98 br 106
  99 acc16= constant 999
 100 writeLineAcc16
 101 ;test9.j(15)     if (3 * 3 < 6561 * 1) println (9); else println (999);
 102 acc8= constant 3
 103 acc8* constant 3
 104 <acc8
 105 acc16= constant 6561
 106 acc16* constant 1
 107 acc8<
 108 acc8CompareAcc16
 109 brge 117
 110 acc8= constant 9
 111 writeLineAcc8
 112 br 121
 113 acc16= constant 999
 114 writeLineAcc16
 115 ;test9.j(16)   
 116 ;test9.j(17)     if (b < i) println (10); else println (999);
 117 acc8= variable 0
 118 acc16= variable 1
 119 acc8CompareAcc16
 120 brge 128
 121 acc8= constant 10
 122 writeLineAcc8
 123 br 131
 124 acc16= constant 999
 125 writeLineAcc16
 126 ;test9.j(18)     if (i > b) println (11); else println (999);
 127 acc16= variable 1
 128 acc8= variable 0
 129 acc16CompareAcc8
 130 brle 138
 131 acc8= constant 11
 132 writeLineAcc8
 133 br 141
 134 acc16= constant 999
 135 writeLineAcc16
 136 ;test9.j(19)     if (b < 6561 * 1) println (12); else println (999);
 137 acc16= constant 6561
 138 acc16* constant 1
 139 acc8= variable 0
 140 acc8CompareAcc16
 141 brge 149
 142 acc8= constant 12
 143 writeLineAcc8
 144 br 152
 145 acc16= constant 999
 146 writeLineAcc16
 147 ;test9.j(20)     if (i > 3 * 3) println (13); else println (999);
 148 acc8= constant 3
 149 acc8* constant 3
 150 acc16= variable 1
 151 acc16CompareAcc8
 152 brle 160
 153 acc8= constant 13
 154 writeLineAcc8
 155 br 163
 156 acc16= constant 999
 157 writeLineAcc16
 158 ;test9.j(21)     if (6561 * 1 > b) println (14); else println (999);
 159 acc16= constant 6561
 160 acc16* constant 1
 161 acc8= variable 0
 162 acc16CompareAcc8
 163 brle 173
 164 acc8= constant 14
 165 writeLineAcc8
 166 br 176
 167 acc16= constant 999
 168 writeLineAcc16
 169 ;test9.j(22)     if (3 * 3 < i) println (15); else println (999);
 170 acc8= constant 3
 171 acc8* constant 3
 172 acc16= variable 1
 173 acc8CompareAcc16
 174 brge 186
 175 acc8= constant 15
 176 writeLineAcc8
 177 br 189
 178 acc16= constant 999
 179 writeLineAcc16
 180 ;test9.j(23)     if (b < i * 1) println (16); else println (999);
 181 acc16= variable 1
 182 acc16* constant 1
 183 acc8= variable 0
 184 acc8CompareAcc16
 185 brge 197
 186 acc8= constant 16
 187 writeLineAcc8
 188 br 200
 189 acc16= constant 999
 190 writeLineAcc16
 191 ;test9.j(24)     if (i > b * 1) println (17); else println (999);
 192 acc8= variable 0
 193 acc8* constant 1
 194 acc16= variable 1
 195 acc16CompareAcc8
 196 brle 208
 197 acc8= constant 17
 198 writeLineAcc8
 199 br 211
 200 acc16= constant 999
 201 writeLineAcc16
 202 ;test9.j(25)     if (b * 1 < i) println (18); else println (999);
 203 acc8= variable 0
 204 acc8* constant 1
 205 acc16= variable 1
 206 acc8CompareAcc16
 207 brge 221
 208 acc8= constant 18
 209 writeLineAcc8
 210 br 224
 211 acc16= constant 999
 212 writeLineAcc16
 213 ;test9.j(26)     if (i * 1 > b) println (19); else println (999);
 214 acc16= variable 1
 215 acc16* constant 1
 216 acc8= variable 0
 217 acc16CompareAcc8
 218 brle 234
 219 acc8= constant 19
 220 writeLineAcc8
 221 br 237
 222 acc16= constant 999
 223 writeLineAcc16
 224 ;test9.j(27)     if (b * 1 < i * 1) println (20); else println (999);
 225 acc8= variable 0
 226 acc8* constant 1
 227 <acc8
 228 acc16= variable 1
 229 acc16* constant 1
 230 acc8<
 231 acc8CompareAcc16
 232 brge 248
 233 acc8= constant 20
 234 writeLineAcc8
 235 br 251
 236 acc16= constant 999
 237 writeLineAcc16
 238 ;test9.j(28)     if (i * 1 > b * 1) println (21); else println (999);
 239 acc16= variable 1
 240 acc16* constant 1
 241 <acc16
 242 acc8= variable 0
 243 acc8* constant 1
 244 acc16<
 245 acc16CompareAcc8
 246 brle 262
 247 acc8= constant 21
 248 writeLineAcc8
 249 br 266
 250 acc16= constant 999
 251 writeLineAcc16
 252 ;test9.j(29)   
 253 ;test9.j(30)     println("Klaar");
 254 acc16= stringconstant 261
 255 writeLineString
 256 stackPointer= basePointer
 257 basePointer<
 258 return
 259 ;test9.j(31)   }
 260 ;test9.j(32) }
 261 stringConstant 0 = "Klaar"
