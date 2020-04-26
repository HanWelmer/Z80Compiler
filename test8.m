  0 :///*
  1 :// * A small program in the miniJava language.
  2 :// * Test 8-bit and 16-bit expressions.
  3 :// */
  4 ://class Test8And16BitExpressions {
  5 ://  /*************************/
  6 ://  /* reverse subtract byte */
  7 ://  /*************************/
  8 ://  write(10 - 3*3);         // 1
  9 :acc8= constant 10
 10 :<acc8= constant 3
 11 :acc8* constant 3
 12 :-acc8 unstack
 13 ://  byte b = 11;
 14 :call writeAcc8
 15 :acc8= constant 11
 16 :acc8=> variable 0
 17 ://  write(b - 3*3);          // 2
 18 :acc8= variable 0
 19 :<acc8= constant 3
 20 :acc8* constant 3
 21 :-acc8 unstack
 22 ://  byte c = 3;
 23 :call writeAcc8
 24 :acc8= constant 3
 25 :acc8=> variable 1
 26 ://  byte d = 3;
 27 :acc8= constant 3
 28 :acc8=> variable 2
 29 ://  write(12 - c*d);         // 3
 30 :acc8= constant 12
 31 :<acc8= variable 1
 32 :acc8* variable 2
 33 :-acc8 unstack
 34 ://  b = 13;
 35 :call writeAcc8
 36 :acc8= constant 13
 37 :acc8=> variable 0
 38 ://  write(b - c*d);          // 4
 39 :acc8= variable 0
 40 :<acc8= variable 1
 41 :acc8* variable 2
 42 :-acc8 unstack
 43 ://
 44 ://  /*************************/
 45 ://  /* reverse subtract int  */
 46 ://  /*************************/
 47 ://  write(1005 - 1000*1);    // 5
 48 :call writeAcc8
 49 :acc16= constant 1005
 50 :<acc16= constant 1000
 51 :acc16* constant 1
 52 :-acc16 unstack
 53 ://  int i = 1006;
 54 :call writeAcc16
 55 :acc16= constant 1006
 56 :acc16=> variable 3
 57 ://  write(i - 1000*1);       // 6
 58 :acc16= variable 3
 59 :<acc16= constant 1000
 60 :acc16* constant 1
 61 :-acc16 unstack
 62 ://  int j = 1000;
 63 :call writeAcc16
 64 :acc16= constant 1000
 65 :acc16=> variable 5
 66 ://  int k = 1;
 67 :acc8= constant 1
 68 :acc8ToAcc16
 69 :acc16=> variable 7
 70 ://  write(1007 - j*k);       // 7
 71 :acc16= constant 1007
 72 :<acc16= variable 5
 73 :acc16* variable 7
 74 :-acc16 unstack
 75 ://  i = 1008;
 76 :call writeAcc16
 77 :acc16= constant 1008
 78 :acc16=> variable 3
 79 ://  write(i - j*k);          // 8
 80 :acc16= variable 3
 81 :<acc16= variable 5
 82 :acc16* variable 7
 83 :-acc16 unstack
 84 ://
 85 ://  /***********************/
 86 ://  /* reverse divide byte */
 87 ://  /***********************/
 88 ://  write(36 / (4*1));     // 9
 89 :call writeAcc16
 90 :acc8= constant 36
 91 :<acc8= constant 4
 92 :acc8* constant 1
 93 :/acc8 unstack
 94 ://  b = 40;
 95 :call writeAcc8
 96 :acc8= constant 40
 97 :acc8=> variable 0
 98 ://  write(b / (4*1));      // 10
 99 :acc8= variable 0
100 :<acc8= constant 4
101 :acc8* constant 1
102 :/acc8 unstack
103 ://  c = 4;
104 :call writeAcc8
105 :acc8= constant 4
106 :acc8=> variable 1
107 ://  d = 1;
108 :acc8= constant 1
109 :acc8=> variable 2
110 ://  write(44 / (c*d));     // 11
111 :acc8= constant 44
112 :<acc8= variable 1
113 :acc8* variable 2
114 :/acc8 unstack
115 ://  b = 48;
116 :call writeAcc8
117 :acc8= constant 48
118 :acc8=> variable 0
119 ://  write(b / (c*d));      // 12
120 :acc8= variable 0
121 :<acc8= variable 1
122 :acc8* variable 2
123 :/acc8 unstack
124 ://
125 ://  /***********************/
126 ://  /* reverse divide int  */
127 ://  /***********************/
128 ://  write(3900 / (300*1)); // 13
129 :call writeAcc8
130 :acc16= constant 3900
131 :<acc16= constant 300
132 :acc16* constant 1
133 :/acc16 unstack
134 ://  i = 4200;
135 :call writeAcc16
136 :acc16= constant 4200
137 :acc16=> variable 3
138 ://  write(i / (300*1));    // 14
139 :acc16= variable 3
140 :<acc16= constant 300
141 :acc16* constant 1
142 :/acc16 unstack
143 ://  j = 300;
144 :call writeAcc16
145 :acc16= constant 300
146 :acc16=> variable 5
147 ://  k = 1;
148 :acc8= constant 1
149 :acc8ToAcc16
150 :acc16=> variable 7
151 ://  write(4500 / (j*k));   // 15
152 :acc16= constant 4500
153 :<acc16= variable 5
154 :acc16* variable 7
155 :/acc16 unstack
156 ://  i = 4800;
157 :call writeAcc16
158 :acc16= constant 4800
159 :acc16=> variable 3
160 ://  write(i / (j*k));      // 16
161 :acc16= variable 3
162 :<acc16= variable 5
163 :acc16* variable 7
164 :/acc16 unstack
165 ://
166 ://  /**************************/
167 ://  /* reverse subtract mixed */
168 ://  /**************************/
169 ://  i = 21;
170 :call writeAcc16
171 :acc8= constant 21
172 :acc8ToAcc16
173 :acc16=> variable 3
174 ://  c = 4;
175 :acc8= constant 4
176 :acc8=> variable 1
177 ://  d = 1;
178 :acc8= constant 1
179 :acc8=> variable 2
180 ://  write(i - c*d);           // 17
181 :acc16= variable 3
182 :acc8= variable 1
183 :acc8* variable 2
184 :acc16- acc8
185 ://  b = 22;
186 :call writeAcc16
187 :acc8= constant 22
188 :acc8=> variable 0
189 ://  j = 4;
190 :acc8= constant 4
191 :acc8ToAcc16
192 :acc16=> variable 5
193 ://  k = 1;
194 :acc8= constant 1
195 :acc8ToAcc16
196 :acc16=> variable 7
197 ://  write(b - j*k);           // 18
198 :acc8= variable 0
199 :acc16= variable 5
200 :acc16* variable 7
201 :-acc16 acc8
202 ://
203 ://  /**************************/
204 ://  /* reverse divide mixed   */
205 ://  /**************************/
206 ://
207 ://  /**************************/
208 ://  /* forward divide mixed   */
209 ://  /**************************/
210 ://  i = 19;
211 :call writeAcc16
212 :acc8= constant 19
213 :acc8ToAcc16
214 :acc16=> variable 3
215 ://  write(i / (1+0));         // 19
216 :acc16= variable 3
217 :acc8= constant 1
218 :acc8+ constant 0
219 :acc16/ acc8
220 ://  
221 ://  write(i + 1);             // 20
222 :call writeAcc16
223 :acc16= variable 3
224 :acc16+ constant 1
225 ://  write(2 + i);             // 21
226 :call writeAcc16
227 :acc8= constant 2
228 :acc8ToAcc16
229 :acc16+ variable 3
230 ://}
231 :call writeAcc16
232 :stop
