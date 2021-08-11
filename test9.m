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
 11 acc8= variable 0
 12 acc8* constant 1
 13 acc16CompareAcc8
 14 brle 18
 15 acc8= constant 21
 16 call writeAcc8
 17 br 21
 18 acc8= constant 0
 19 call writeAcc8
 20 ;test9.p(5)   if (b * 1 < i * 1) write (20); else write (0);
 21 acc8= variable 0
 22 acc8* constant 1
 23 acc16= variable 1
 24 acc16* constant 1
 25 acc8CompareAcc16
 26 brge 30
 27 acc8= constant 20
 28 call writeAcc8
 29 br 33
 30 acc8= constant 0
 31 call writeAcc8
 32 ;test9.p(6)   if (i * 1 > b) write (19); else write (0);
 33 acc16= variable 1
 34 acc16* constant 1
 35 acc8= variable 0
 36 acc16CompareAcc8
 37 brle 41
 38 acc8= constant 19
 39 call writeAcc8
 40 br 44
 41 acc8= constant 0
 42 call writeAcc8
 43 ;test9.p(7)   if (b * 1 < i) write (18); else write (0);
 44 acc8= variable 0
 45 acc8* constant 1
 46 acc16= variable 1
 47 acc8CompareAcc16
 48 brge 52
 49 acc8= constant 18
 50 call writeAcc8
 51 br 55
 52 acc8= constant 0
 53 call writeAcc8
 54 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
 55 acc16= variable 1
 56 acc8= variable 0
 57 acc8* constant 1
 58 acc16CompareAcc8
 59 brle 63
 60 acc8= constant 17
 61 call writeAcc8
 62 br 66
 63 acc8= constant 0
 64 call writeAcc8
 65 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
 66 acc8= variable 0
 67 acc16= variable 1
 68 acc16* constant 1
 69 acc8CompareAcc16
 70 brge 74
 71 acc8= constant 16
 72 call writeAcc8
 73 br 77
 74 acc8= constant 0
 75 call writeAcc8
 76 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
 77 acc8= constant 3
 78 acc8* constant 3
 79 acc16= variable 1
 80 acc8CompareAcc16
 81 brge 85
 82 acc8= constant 15
 83 call writeAcc8
 84 br 88
 85 acc8= constant 0
 86 call writeAcc8
 87 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
 88 acc16= constant 6561
 89 acc16* constant 1
 90 acc8= variable 0
 91 acc16CompareAcc8
 92 brle 96
 93 acc8= constant 14
 94 call writeAcc8
 95 br 99
 96 acc8= constant 0
 97 call writeAcc8
 98 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
 99 acc16= variable 1
100 acc8= constant 3
101 acc8* constant 3
102 acc16CompareAcc8
103 brle 107
104 acc8= constant 13
105 call writeAcc8
106 br 110
107 acc8= constant 0
108 call writeAcc8
109 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
110 acc8= variable 0
111 acc16= constant 6561
112 acc16* constant 1
113 acc8CompareAcc16
114 brge 118
115 acc8= constant 12
116 call writeAcc8
117 br 121
118 acc8= constant 0
119 call writeAcc8
120 ;test9.p(14)   if (i > b) write (11); else write (0);
121 acc16= variable 1
122 acc8= variable 0
123 acc16CompareAcc8
124 brle 128
125 acc8= constant 11
126 call writeAcc8
127 br 131
128 acc8= constant 0
129 call writeAcc8
130 ;test9.p(15)   if (b < i) write (10); else write (0);
131 acc8= variable 0
132 acc16= variable 1
133 acc8CompareAcc16
134 brge 138
135 acc8= constant 10
136 call writeAcc8
137 br 142
138 acc8= constant 0
139 call writeAcc8
140 ;test9.p(16) 
141 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
142 acc8= constant 3
143 acc8* constant 3
144 acc16= constant 6561
145 acc16* constant 1
146 acc8CompareAcc16
147 brge 151
148 acc8= constant 9
149 call writeAcc8
150 br 154
151 acc8= constant 0
152 call writeAcc8
153 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
154 acc16= constant 6561
155 acc16* constant 1
156 acc8= constant 3
157 acc8* constant 3
158 acc16CompareAcc8
159 brle 163
160 acc8= constant 8
161 call writeAcc8
162 br 166
163 acc8= constant 0
164 call writeAcc8
165 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
166 acc8= constant 9
167 acc16= constant 6561
168 acc16* constant 1
169 acc8CompareAcc16
170 brge 174
171 acc8= constant 7
172 call writeAcc8
173 br 177
174 acc8= constant 0
175 call writeAcc8
176 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
177 acc16= constant 6561
178 acc16* constant 1
179 acc8= constant 9
180 acc16CompareAcc8
181 brle 185
182 acc8= constant 6
183 call writeAcc8
184 br 188
185 acc8= constant 0
186 call writeAcc8
187 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
188 acc16= constant 6561
189 acc8= constant 3
190 acc8* constant 3
191 acc16CompareAcc8
192 brle 196
193 acc8= constant 5
194 call writeAcc8
195 br 199
196 acc8= constant 0
197 call writeAcc8
198 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
199 acc8= constant 3
200 acc8* constant 3
201 acc16= constant 6561
202 acc8CompareAcc16
203 brge 207
204 acc8= constant 4
205 call writeAcc8
206 br 210
207 acc8= constant 0
208 call writeAcc8
209 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
210 acc8= constant 9
211 acc16= constant 6561
212 acc8CompareAcc16
213 brge 217
214 acc8= constant 3
215 call writeAcc8
216 br 220
217 acc8= constant 0
218 call writeAcc8
219 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
220 acc16= constant 6561
221 acc8= constant 9
222 acc16CompareAcc8
223 brle 227
224 acc8= constant 2
225 call writeAcc8
226 br 230
227 acc8= constant 0
228 call writeAcc8
229 ;test9.p(25)   write(1);
230 acc8= constant 1
231 call writeAcc8
232 ;test9.p(26)   write(0);
233 acc8= constant 0
234 call writeAcc8
235 ;test9.p(27) }
236 stop
