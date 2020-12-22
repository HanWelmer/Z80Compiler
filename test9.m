  0 ;test9.p(0) /* Program to test multiplication */
  1 ;test9.p(1) class TestMuliply {
  2 ;test9.p(2)   byte b = 9;
  3 acc8= constant 9
  4 acc8=> variable 0
  5 ;test9.p(3)   int i = 6561;
  6 acc16= constant 6561
  7 acc16=> variable 1
  8 ;test9.p(4)   if (i * 1 > b * 1) write (21); else write (0);
  9 acc16= variable 1
 10 acc16* constant 1
 11 <acc16= acc16
 12 acc8= variable 0
 13 acc8* constant 1
 14 accom16 acc8
 15 brle 19
 16 acc8= constant 21
 17 call writeAcc8
 18 br 22
 19 acc8= constant 0
 20 call writeAcc8
 21 ;test9.p(5)   if (b * 1 < i * 1) write (20); else write (0);
 22 acc8= variable 0
 23 acc8* constant 1
 24 <acc8= acc8
 25 acc16= variable 1
 26 acc16* constant 1
 27 acc16CompareAcc8
 28 brge 32
 29 acc8= constant 20
 30 call writeAcc8
 31 br 35
 32 acc8= constant 0
 33 call writeAcc8
 34 ;test9.p(6)   if (i * 1 > b) write (19); else write (0);
 35 acc16= variable 1
 36 acc16* constant 1
 37 <acc16= acc16
 38 accom16 variable 0
 39 brle 43
 40 acc8= constant 19
 41 call writeAcc8
 42 br 46
 43 acc8= constant 0
 44 call writeAcc8
 45 ;test9.p(7)   if (b * 1 < i) write (18); else write (0);
 46 acc8= variable 0
 47 acc8* constant 1
 48 <acc8= acc8
 49 acc8ToAcc16
 50 accom16 variable 1
 51 brge 55
 52 acc8= constant 18
 53 call writeAcc8
 54 br 58
 55 acc8= constant 0
 56 call writeAcc8
 57 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
 58 acc16= variable 1
 59 acc8= variable 0
 60 acc8* constant 1
 61 accom16 acc8
 62 brle 66
 63 acc8= constant 17
 64 call writeAcc8
 65 br 69
 66 acc8= constant 0
 67 call writeAcc8
 68 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
 69 acc8= variable 0
 70 acc16= variable 1
 71 acc16* constant 1
 72 acc16CompareAcc8
 73 brge 77
 74 acc8= constant 16
 75 call writeAcc8
 76 br 80
 77 acc8= constant 0
 78 call writeAcc8
 79 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
 80 acc8= constant 3
 81 acc8* constant 3
 82 <acc8= acc8
 83 acc8ToAcc16
 84 accom16 variable 1
 85 brge 89
 86 acc8= constant 15
 87 call writeAcc8
 88 br 92
 89 acc8= constant 0
 90 call writeAcc8
 91 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
 92 acc16= constant 6561
 93 acc16* constant 1
 94 <acc16= acc16
 95 accom16 variable 0
 96 brle 100
 97 acc8= constant 14
 98 call writeAcc8
 99 br 103
100 acc8= constant 0
101 call writeAcc8
102 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
103 acc16= variable 1
104 acc8= constant 3
105 acc8* constant 3
106 accom16 acc8
107 brle 111
108 acc8= constant 13
109 call writeAcc8
110 br 114
111 acc8= constant 0
112 call writeAcc8
113 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
114 acc8= variable 0
115 acc16= constant 6561
116 acc16* constant 1
117 acc16CompareAcc8
118 brge 122
119 acc8= constant 12
120 call writeAcc8
121 br 125
122 acc8= constant 0
123 call writeAcc8
124 ;test9.p(14)   if (i > b) write (11); else write (0);
125 acc16= variable 1
126 accom16 variable 0
127 brle 131
128 acc8= constant 11
129 call writeAcc8
130 br 134
131 acc8= constant 0
132 call writeAcc8
133 ;test9.p(15)   if (b < i) write (10); else write (0);
134 acc8= variable 0
135 acc8ToAcc16
136 accom16 variable 1
137 brge 141
138 acc8= constant 10
139 call writeAcc8
140 br 145
141 acc8= constant 0
142 call writeAcc8
143 ;test9.p(16) 
144 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
145 acc8= constant 3
146 acc8* constant 3
147 <acc8= acc8
148 acc16= constant 6561
149 acc16* constant 1
150 acc16CompareAcc8
151 brge 155
152 acc8= constant 9
153 call writeAcc8
154 br 158
155 acc8= constant 0
156 call writeAcc8
157 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
158 acc16= constant 6561
159 acc16* constant 1
160 <acc16= acc16
161 acc8= constant 3
162 acc8* constant 3
163 accom16 acc8
164 brle 168
165 acc8= constant 8
166 call writeAcc8
167 br 171
168 acc8= constant 0
169 call writeAcc8
170 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
171 acc8= constant 9
172 acc16= constant 6561
173 acc16* constant 1
174 acc16CompareAcc8
175 brge 179
176 acc8= constant 7
177 call writeAcc8
178 br 182
179 acc8= constant 0
180 call writeAcc8
181 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
182 acc16= constant 6561
183 acc16* constant 1
184 <acc16= acc16
185 accom16 constant 9
186 brle 190
187 acc8= constant 6
188 call writeAcc8
189 br 193
190 acc8= constant 0
191 call writeAcc8
192 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
193 acc16= constant 6561
194 acc8= constant 3
195 acc8* constant 3
196 accom16 acc8
197 brle 201
198 acc8= constant 5
199 call writeAcc8
200 br 204
201 acc8= constant 0
202 call writeAcc8
203 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
204 acc8= constant 3
205 acc8* constant 3
206 <acc8= acc8
207 acc8ToAcc16
208 accom16 constant 6561
209 brge 213
210 acc8= constant 4
211 call writeAcc8
212 br 216
213 acc8= constant 0
214 call writeAcc8
215 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
216 acc8= constant 9
217 acc8ToAcc16
218 accom16 constant 6561
219 brge 223
220 acc8= constant 3
221 call writeAcc8
222 br 226
223 acc8= constant 0
224 call writeAcc8
225 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
226 acc16= constant 6561
227 accom16 constant 9
228 brle 232
229 acc8= constant 2
230 call writeAcc8
231 br 235
232 acc8= constant 0
233 call writeAcc8
234 ;test9.p(25)   write(1);
235 acc8= constant 1
236 call writeAcc8
237 ;test9.p(26)   write(0);
238 acc8= constant 0
239 call writeAcc8
240 ;test9.p(27) }
241 stop
