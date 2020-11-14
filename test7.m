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
 16 acc16ToAcc8
 17 acc8=> variable 0
 18 ;test7.p(11)   write(b);          // 3
 19 acc8= variable 0
 20 call writeAcc8
 21 ;test7.p(12) 
 22 ;test7.p(13)   /**********************************/
 23 ;test7.p(14)   /* Dual term read: byte constants */
 24 ;test7.p(15)   /**********************************/
 25 ;test7.p(16)   write(read + 0);   // 4 + 0 = 4
 26 call read
 27 acc16+ constant 0
 28 call writeAcc16
 29 ;test7.p(17)   write(0 + read);   // 0 + 5 = 5
 30 acc8= constant 0
 31 call read
 32 acc16+ acc8
 33 call writeAcc16
 34 ;test7.p(18)   write(read - 0);   // 6 - 0 = 6
 35 call read
 36 acc16- constant 0
 37 call writeAcc16
 38 ;test7.p(19)   write(14 - read);  // 14 - 7 = 7
 39 acc8= constant 14
 40 call read
 41 -acc16 acc8
 42 call writeAcc16
 43 ;test7.p(20)   write(read * 1);   // 8 * 1 = 8
 44 call read
 45 acc16* constant 1
 46 call writeAcc16
 47 ;test7.p(21)   write(1 * read);   // 1 * 9 = 9
 48 acc8= constant 1
 49 call read
 50 acc16* acc8
 51 call writeAcc16
 52 ;test7.p(22)   write(read / 1);   // 10 / 1 = 10
 53 call read
 54 acc16/ constant 1
 55 call writeAcc16
 56 ;test7.p(23)   write(121 / read); // 121 / 11 = 11
 57 acc8= constant 121
 58 call read
 59 /acc16 acc8
 60 call writeAcc16
 61 ;test7.p(24)   
 62 ;test7.p(25)   write(1047);      // 1047
 63 acc16= constant 1047
 64 call writeAcc16
 65 ;test7.p(26)   /*************************/
 66 ;test7.p(27)   /* Single term read: int */
 67 ;test7.p(28)   /*************************/
 68 ;test7.p(29)   write(read);      // 1048
 69 call read
 70 call writeAcc16
 71 ;test7.p(30)   int i = read;
 72 call read
 73 acc16=> variable 1
 74 ;test7.p(31)   write(i);         // 1049
 75 acc16= variable 1
 76 call writeAcc16
 77 ;test7.p(32) 
 78 ;test7.p(33)   /*********************************/
 79 ;test7.p(34)   /* Dual term read: int constants */
 80 ;test7.p(35)   /*********************************/
 81 ;test7.p(36)   write(read + 1000);   // 1050 + 1000 = 2050
 82 call read
 83 acc16+ constant 1000
 84 call writeAcc16
 85 ;test7.p(37)   write(1000 + read);   // 1000 + 1051 = 2051
 86 acc16= constant 1000
 87 acc16=> stack
 88 call read
 89 acc16+ unstack
 90 call writeAcc16
 91 ;test7.p(38)   write(read - 1000);   // 1052 - 1000 =   52
 92 call read
 93 acc16- constant 1000
 94 call writeAcc16
 95 ;test7.p(39)   write(2106 - read);   // 2106 - 1053 = 1053
 96 acc16= constant 2106
 97 acc16=> stack
 98 call read
 99 -acc16 unstack
100 call writeAcc16
101 ;test7.p(40)   write(read * 1000);   // 1054 * 1000 = 5254
102 call read
103 acc16* constant 1000
104 call writeAcc16
105 ;test7.p(41)   write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
106 acc16= constant 1000
107 acc16=> stack
108 call read
109 acc16* unstack
110 call writeAcc16
111 ;test7.p(42)   write(read / 1000);   // 1056 / 1000 = 1
112 call read
113 acc16/ constant 1000
114 call writeAcc16
115 ;test7.p(43)   write(2114 / read);   // 2114 / 1057 = 2
116 acc16= constant 2114
117 acc16=> stack
118 call read
119 /acc16 unstack
120 call writeAcc16
121 ;test7.p(44)   
122 ;test7.p(45)   /***************************************/
123 ;test7.p(46)   /* Dual term read: int + byte variable */
124 ;test7.p(47)   /***************************************/
125 ;test7.p(48)   b = 0;
126 acc8= constant 0
127 acc8=> variable 0
128 ;test7.p(49)   write(read + b);   // 1058 + 0 = 1058
129 call read
130 acc16+ variable 0
131 call writeAcc16
132 ;test7.p(50)   write(b + read);   // 1059 + 5 = 1059
133 acc8= variable 0
134 call read
135 acc16+ acc8
136 call writeAcc16
137 ;test7.p(51)   write(read - b);   // 1060 - 0 = 1060
138 call read
139 acc16- variable 0
140 call writeAcc16
141 ;test7.p(52)   write(b - read);   // 0 - 1061 = -1061
142 acc8= variable 0
143 call read
144 -acc16 acc8
145 call writeAcc16
146 ;test7.p(53)   b = 1;
147 acc8= constant 1
148 acc8=> variable 0
149 ;test7.p(54)   write(read * b);   // 1062 * 1 = 1062
150 call read
151 acc16* variable 0
152 call writeAcc16
153 ;test7.p(55)   write(b * read);   // 1 * 1063 = 1063
154 acc8= variable 0
155 call read
156 acc16* acc8
157 call writeAcc16
158 ;test7.p(56)   write(read / b);   // 1064 / 1 = 1064
159 call read
160 acc16/ variable 0
161 call writeAcc16
162 ;test7.p(57)   b = 12;
163 acc8= constant 12
164 acc8=> variable 0
165 ;test7.p(58)   write(3);
166 acc8= constant 3
167 call writeAcc8
168 ;test7.p(59)   write(b / read);   // 12 / 3 = 4
169 acc8= variable 0
170 call read
171 /acc16 acc8
172 call writeAcc16
173 ;test7.p(60)   
174 ;test7.p(61)   /***************************************/
175 ;test7.p(62)   /* Dual term read: int + int variable */
176 ;test7.p(63)   /***************************************/
177 ;test7.p(64)   i = 0;
178 acc8= constant 0
179 acc8ToAcc16
180 acc16=> variable 1
181 ;test7.p(65)   write(1066);
182 acc16= constant 1066
183 call writeAcc16
184 ;test7.p(66)   write(read + i);   // 1066 + 0 = 1066
185 call read
186 acc16+ variable 1
187 call writeAcc16
188 ;test7.p(67)   write(i + read);   // 1067 + 5 = 1067
189 acc16= variable 1
190 acc16=> stack
191 call read
192 acc16+ unstack
193 call writeAcc16
194 ;test7.p(68)   write(read - i);   // 1068 - 0 = 1068
195 call read
196 acc16- variable 1
197 call writeAcc16
198 ;test7.p(69)   write(i - read);   // 0 - 1069 = -1069
199 acc16= variable 1
200 acc16=> stack
201 call read
202 -acc16 unstack
203 call writeAcc16
204 ;test7.p(70)   i = 1;
205 acc8= constant 1
206 acc8ToAcc16
207 acc16=> variable 1
208 ;test7.p(71)   write(read * i);   // 1070 * 1 = 1070
209 call read
210 acc16* variable 1
211 call writeAcc16
212 ;test7.p(72)   write(i * read);   // 1 * 1071 = 1071
213 acc16= variable 1
214 acc16=> stack
215 call read
216 acc16* unstack
217 call writeAcc16
218 ;test7.p(73)   write(read / i);   // 1072 / 1 = 1072
219 call read
220 acc16/ variable 1
221 call writeAcc16
222 ;test7.p(74)   i = 3219;
223 acc16= constant 3219
224 acc16=> variable 1
225 ;test7.p(75)   write(3);
226 acc8= constant 3
227 call writeAcc8
228 ;test7.p(76)   write(i / read);   // 3219 / 3 = 1073  
229 acc16= variable 1
230 acc16=> stack
231 call read
232 /acc16 unstack
233 call writeAcc16
234 ;test7.p(77) }
235 stop
