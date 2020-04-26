  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test 8-bit and 16-bit expressions.
  3 :// */
  4 ://class Test8And16BitExpressions {
  5 ://  /**************************/
  6 ://  /* Single term read: byte */
  7 ://  /**************************/
  8 ://  write(1);          // 1
  9 ://  write(read);       // 2
 10 :acc8= constant 1
 11 :call writeAcc8
 12 :call read
 13 ://  byte b = read;
 14 :call writeAcc16
 15 :call read
 16 :acc16ToAcc8
 17 :acc8=> variable 0
 18 ://  write(b);          // 3
 19 ://
 20 ://  /**********************************/
 21 ://  /* Dual term read: byte constants */
 22 ://  /**********************************/
 23 ://  write(read + 0);   // 4 + 0 = 4
 24 :acc8= variable 0
 25 :call writeAcc8
 26 :call read
 27 :acc16+ constant 0
 28 ://  write(0 + read);   // 0 + 5 = 5
 29 :call writeAcc16
 30 :acc8= constant 0
 31 :call read
 32 :acc16+ acc8
 33 ://  write(read - 0);   // 6 - 0 = 6
 34 :call writeAcc16
 35 :call read
 36 :acc16- constant 0
 37 ://  write(14 - read);  // 14 - 7 = 7
 38 :call writeAcc16
 39 :acc8= constant 14
 40 :call read
 41 :-acc16 acc8
 42 ://  write(read * 1);   // 8 * 1 = 8
 43 :call writeAcc16
 44 :call read
 45 :acc16* constant 1
 46 ://  write(1 * read);   // 1 * 9 = 9
 47 :call writeAcc16
 48 :acc8= constant 1
 49 :call read
 50 :acc16* acc8
 51 ://  write(read / 1);   // 10 / 1 = 10
 52 :call writeAcc16
 53 :call read
 54 :acc16/ constant 1
 55 ://  write(121 / read); // 121 / 11 = 11
 56 :call writeAcc16
 57 :acc8= constant 121
 58 :call read
 59 :/acc16 acc8
 60 ://  
 61 ://  write(1047);      // 1047
 62 :call writeAcc16
 63 ://  /*************************/
 64 ://  /* Single term read: int */
 65 ://  /*************************/
 66 ://  write(read);      // 1048
 67 :acc16= constant 1047
 68 :call writeAcc16
 69 :call read
 70 ://  int i = read;
 71 :call writeAcc16
 72 :call read
 73 :acc16=> variable 1
 74 ://  write(i);         // 1049
 75 ://
 76 ://  /*********************************/
 77 ://  /* Dual term read: int constants */
 78 ://  /*********************************/
 79 ://  write(read + 1000);   // 1050 + 1000 = 2050
 80 :acc16= variable 1
 81 :call writeAcc16
 82 :call read
 83 :acc16+ constant 1000
 84 ://  write(1000 + read);   // 1000 + 1051 = 2051
 85 :call writeAcc16
 86 :acc16= constant 1000
 87 :acc16=> stack
 88 :call read
 89 :acc16+ unstack
 90 ://  write(read - 1000);   // 1052 - 1000 =   52
 91 :call writeAcc16
 92 :call read
 93 :acc16- constant 1000
 94 ://  write(2106 - read);   // 2106 - 1053 = 1053
 95 :call writeAcc16
 96 :acc16= constant 2106
 97 :acc16=> stack
 98 :call read
 99 :-acc16 unstack
100 ://  write(read * 1000);   // 1054 * 1000 = 5254
101 :call writeAcc16
102 :call read
103 :acc16* constant 1000
104 ://  write(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
105 :call writeAcc16
106 :acc16= constant 1000
107 :acc16=> stack
108 :call read
109 :acc16* unstack
110 ://  write(read / 1000);   // 1056 / 1000 = 1
111 :call writeAcc16
112 :call read
113 :acc16/ constant 1000
114 ://  write(2114 / read);   // 2114 / 1057 = 2
115 :call writeAcc16
116 :acc16= constant 2114
117 :acc16=> stack
118 :call read
119 :/acc16 unstack
120 ://  
121 ://  /***************************************/
122 ://  /* Dual term read: int + byte variable */
123 ://  /***************************************/
124 ://  b = 0;
125 :call writeAcc16
126 :acc8= constant 0
127 :acc8=> variable 0
128 ://  write(read + b);   // 1058 + 0 = 1058
129 :call read
130 :acc16+ variable 0
131 ://  write(b + read);   // 1059 + 5 = 1059
132 :call writeAcc16
133 :acc8= variable 0
134 :call read
135 :acc16+ acc8
136 ://  write(read - b);   // 1060 - 0 = 1060
137 :call writeAcc16
138 :call read
139 :acc16- variable 0
140 ://  write(b - read);   // 0 - 1061 = -1061
141 :call writeAcc16
142 :acc8= variable 0
143 :call read
144 :-acc16 acc8
145 ://  b = 1;
146 :call writeAcc16
147 :acc8= constant 1
148 :acc8=> variable 0
149 ://  write(read * b);   // 1062 * 1 = 1062
150 :call read
151 :acc16* variable 0
152 ://  write(b * read);   // 1 * 1063 = 1063
153 :call writeAcc16
154 :acc8= variable 0
155 :call read
156 :acc16* acc8
157 ://  write(read / b);   // 1064 / 1 = 1064
158 :call writeAcc16
159 :call read
160 :acc16/ variable 0
161 ://  b = 12;
162 :call writeAcc16
163 :acc8= constant 12
164 :acc8=> variable 0
165 ://  write(3);
166 ://  write(b / read);   // 12 / 3 = 4
167 :acc8= constant 3
168 :call writeAcc8
169 :acc8= variable 0
170 :call read
171 :/acc16 acc8
172 ://  
173 ://  /***************************************/
174 ://  /* Dual term read: int + int variable */
175 ://  /***************************************/
176 ://  i = 0;
177 :call writeAcc16
178 :acc8= constant 0
179 :acc8ToAcc16
180 :acc16=> variable 1
181 ://  write(1066);
182 ://  write(read + i);   // 1066 + 0 = 1066
183 :acc16= constant 1066
184 :call writeAcc16
185 :call read
186 :acc16+ variable 1
187 ://  write(i + read);   // 1067 + 5 = 1067
188 :call writeAcc16
189 :acc16= variable 1
190 :acc16=> stack
191 :call read
192 :acc16+ unstack
193 ://  write(read - i);   // 1068 - 0 = 1068
194 :call writeAcc16
195 :call read
196 :acc16- variable 1
197 ://  write(i - read);   // 0 - 1069 = -1069
198 :call writeAcc16
199 :acc16= variable 1
200 :acc16=> stack
201 :call read
202 :-acc16 unstack
203 ://  i = 1;
204 :call writeAcc16
205 :acc8= constant 1
206 :acc8ToAcc16
207 :acc16=> variable 1
208 ://  write(read * i);   // 1070 * 1 = 1070
209 :call read
210 :acc16* variable 1
211 ://  write(i * read);   // 1 * 1071 = 1071
212 :call writeAcc16
213 :acc16= variable 1
214 :acc16=> stack
215 :call read
216 :acc16* unstack
217 ://  write(read / i);   // 1072 / 1 = 1072
218 :call writeAcc16
219 :call read
220 :acc16/ variable 1
221 ://  i = 3219;
222 :call writeAcc16
223 :acc16= constant 3219
224 :acc16=> variable 1
225 ://  write(3);
226 ://  write(i / read);   // 3219 / 3 = 1073
227 :acc8= constant 3
228 :call writeAcc8
229 :acc16= variable 1
230 :acc16=> stack
231 :call read
232 :/acc16 unstack
233 ://  
234 ://}
235 :call writeAcc16
236 :stop
