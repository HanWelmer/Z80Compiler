   0 ;test7.p(0) /*
   1 ;test7.p(1)  * A small program in the miniJava language.
   2 ;test7.p(2)  * Test 8-bit and 16-bit expressions.
   3 ;test7.p(3)  */
   4 ;test7.p(4) class Test8And16BitExpressions {
   5 ;test7.p(5)   /**************************/
   6 ;test7.p(6)   /* Single term read: byte */
   7 ;test7.p(7)   /**************************/
   8 ;test7.p(8)   write(1);          // 1
   9 acc8= constant 1
  10 call writeAcc8
  11 ;test7.p(9)   write(read);       // 2
  12 call read
  13 call writeAcc16
  14 ;test7.p(10)   byte b = read;
  15 call read
  16 acc16=> variable 0
  17 ;test7.p(11)   write(b);          // 3
  18 acc8= variable 0
  19 call writeAcc8
  20 ;test7.p(12) 
  21 ;test7.p(13)   /**********************************/
  22 ;test7.p(14)   /* Dual term read: byte constants */
  23 ;test7.p(15)   /**********************************/
  24 ;test7.p(16)   write(read + 0);   // 4 + 0 = 4
  25 call read
  26 acc16+ constant 0
  27 call writeAcc16
  28 ;test7.p(17)   write(0 + read);   // 0 + 5 = 5
  29 acc8= constant 0
  30 call read
  31 acc16+ acc8
  32 call writeAcc16
  33 ;test7.p(18)   write(read - 0);   // 6 - 0 = 6
  34 call read
  35 acc16- constant 0
  36 call writeAcc16
  37 ;test7.p(19)   write(14 - read);  // 14 - 7 = 7
  38 acc8= constant 14
  39 call read
  40 -acc16 acc8
  41 call writeAcc16
  42 ;test7.p(20)   write(read * 1);   // 8 * 1 = 8
  43 call read
  44 acc16* constant 1
  45 call writeAcc16
  46 ;test7.p(21)   write(1 * read);   // 1 * 9 = 9
  47 acc8= constant 1
  48 call read
  49 acc16* acc8
  50 call writeAcc16
  51 ;test7.p(22)   write(read / 1);   // 10 / 1 = 10
  52 call read
  53 acc16/ constant 1
  54 call writeAcc16
  55 ;test7.p(23)   write(121 / read); // 121 / 11 = 11
  56 acc8= constant 121
  57 call read
  58 /acc16 acc8
  59 call writeAcc16
  60 ;test7.p(24)   
  61 ;test7.p(25)   write(1047);      // 1047
  62 acc16= constant 1047
  63 call writeAcc16
  64 ;test7.p(26)   /*************************/
  65 ;test7.p(27)   /* Single term read: int */
  66 ;test7.p(28)   /*************************/
  67 ;test7.p(29)   write(read);      // 1048
  68 call read
  69 call writeAcc16
  70 ;test7.p(30)   int i = read;
  71 call read
  72 acc16=> variable 1
  73 ;test7.p(31)   write(i);         // 1049
  74 acc16= variable 1
  75 call writeAcc16
  76 ;test7.p(32) 
  77 ;test7.p(33)   /*********************************/
  78 ;test7.p(34)   /* Dual term read: int constants */
  79 ;test7.p(35)   /*********************************/
  80 ;test7.p(36)   write(read + 1000);   // 1050 + 1000 = 2050
  81 call read
  82 acc16+ constant 1000
  83 call writeAcc16
  84 ;test7.p(37)   write(1000 + read);   // 1000 + 1051 = 2051
  85 acc16= constant 1000
  86 <acc16
  87 call read
  88 acc16+ unstack16
  89 call writeAcc16
  90 ;test7.p(38)   write(read - 1000);   // 1052 - 1000 =   52
  91 call read
  92 acc16- constant 1000
  93 call writeAcc16
  94 ;test7.p(39)   write(2106 - read);   // 2106 - 1053 = 1053
  95 acc16= constant 2106
  96 <acc16
  97 call read
  98 -acc16 unstack16
  99 call writeAcc16
 100 ;test7.p(40)   write(read * 1000);   // 1054 * 1000 = 5254
 101 call read
 102 acc16* constant 1000
 103 call writeAcc16
 104 ;test7.p(41)   write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
 105 acc16= constant 1000
 106 <acc16
 107 call read
 108 acc16* unstack16
 109 call writeAcc16
 110 ;test7.p(42)   write(read / 1000);   // 1056 / 1000 = 1
 111 call read
 112 acc16/ constant 1000
 113 call writeAcc16
 114 ;test7.p(43)   write(2114 / read);   // 2114 / 1057 = 2
 115 acc16= constant 2114
 116 <acc16
 117 call read
 118 /acc16 unstack16
 119 call writeAcc16
 120 ;test7.p(44)   
 121 ;test7.p(45)   /***************************************/
 122 ;test7.p(46)   /* Dual term read: int + byte variable */
 123 ;test7.p(47)   /***************************************/
 124 ;test7.p(48)   b = 0;
 125 acc8= constant 0
 126 acc8=> variable 0
 127 ;test7.p(49)   write(read + b);   // 1058 + 0 = 1058
 128 call read
 129 acc16+ variable 0
 130 call writeAcc16
 131 ;test7.p(50)   write(b + read);   // 0 + 1059 = 1059
 132 acc8= variable 0
 133 call read
 134 acc16+ acc8
 135 call writeAcc16
 136 ;test7.p(51)   write(read - b);   // 1060 - 0 = 1060
 137 call read
 138 acc16- variable 0
 139 call writeAcc16
 140 ;test7.p(52)   write(b - read);   // 0 - 1061 = -1061
 141 acc8= variable 0
 142 call read
 143 -acc16 acc8
 144 call writeAcc16
 145 ;test7.p(53)   b = 1;
 146 acc8= constant 1
 147 acc8=> variable 0
 148 ;test7.p(54)   write(read * b);   // 1062 * 1 = 1062
 149 call read
 150 acc16* variable 0
 151 call writeAcc16
 152 ;test7.p(55)   write(b * read);   // 1 * 1063 = 1063
 153 acc8= variable 0
 154 call read
 155 acc16* acc8
 156 call writeAcc16
 157 ;test7.p(56)   write(read / b);   // 1064 / 1 = 1064
 158 call read
 159 acc16/ variable 0
 160 call writeAcc16
 161 ;test7.p(57)   b = 12;
 162 acc8= constant 12
 163 acc8=> variable 0
 164 ;test7.p(58)   write(3);
 165 acc8= constant 3
 166 call writeAcc8
 167 ;test7.p(59)   write(b / read);   // 12 / 3 = 4
 168 acc8= variable 0
 169 call read
 170 /acc16 acc8
 171 call writeAcc16
 172 ;test7.p(60)   
 173 ;test7.p(61)   /***************************************/
 174 ;test7.p(62)   /* Dual term read: int + int variable */
 175 ;test7.p(63)   /***************************************/
 176 ;test7.p(64)   i = 0;
 177 acc8= constant 0
 178 acc8=> variable 1
 179 ;test7.p(65)   write(1066);
 180 acc16= constant 1066
 181 call writeAcc16
 182 ;test7.p(66)   write(read + i);   // 1066 + 0 = 1066
 183 call read
 184 acc16+ variable 1
 185 call writeAcc16
 186 ;test7.p(67)   write(i + read);   // 0 + 1067 = 1067
 187 acc16= variable 1
 188 <acc16
 189 call read
 190 acc16+ unstack16
 191 call writeAcc16
 192 ;test7.p(68)   write(read - i);   // 1068 - 0 = 1068
 193 call read
 194 acc16- variable 1
 195 call writeAcc16
 196 ;test7.p(69)   write(i - read);   // 0 - 1069 = -1069
 197 acc16= variable 1
 198 <acc16
 199 call read
 200 -acc16 unstack16
 201 call writeAcc16
 202 ;test7.p(70)   i = 1;
 203 acc8= constant 1
 204 acc8=> variable 1
 205 ;test7.p(71)   write(read * i);   // 1070 * 1 = 1070
 206 call read
 207 acc16* variable 1
 208 call writeAcc16
 209 ;test7.p(72)   write(i * read);   // 1 * 1071 = 1071
 210 acc16= variable 1
 211 <acc16
 212 call read
 213 acc16* unstack16
 214 call writeAcc16
 215 ;test7.p(73)   write(read / i);   // 1072 / 1 = 1072
 216 call read
 217 acc16/ variable 1
 218 call writeAcc16
 219 ;test7.p(74)   i = 3219;
 220 acc16= constant 3219
 221 acc16=> variable 1
 222 ;test7.p(75)   write(3);
 223 acc8= constant 3
 224 call writeAcc8
 225 ;test7.p(76)   write(i / read);   // 3219 / 3 = 1073  
 226 acc16= variable 1
 227 <acc16
 228 call read
 229 /acc16 unstack16
 230 call writeAcc16
 231 ;test7.p(77) }
 232 stop
