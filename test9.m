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
 13 accom16 acc8
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
 25 acc16CompareAcc8
 26 brge 30
 27 acc8= constant 20
 28 call writeAcc8
 29 br 33
 30 acc8= constant 0
 31 call writeAcc8
 32 ;test9.p(6)   if (i * 1 > b) write (19); else write (0);
 33 acc16= variable 1
 34 acc16* constant 1
 35 accom16 variable 0
 36 brle 40
 37 acc8= constant 19
 38 call writeAcc8
 39 br 43
 40 acc8= constant 0
 41 call writeAcc8
 42 ;test9.p(7)   if (b * 1 < i) write (18); else write (0);
 43 acc8= variable 0
 44 acc8* constant 1
 45 acc8ToAcc16
 46 accom16 variable 1
 47 brge 51
 48 acc8= constant 18
 49 call writeAcc8
 50 br 54
 51 acc8= constant 0
 52 call writeAcc8
 53 ;test9.p(8)   if (i > b * 1) write (17); else write (0);
 54 acc16= variable 1
 55 acc8= variable 0
 56 acc8* constant 1
 57 accom16 acc8
 58 brle 62
 59 acc8= constant 17
 60 call writeAcc8
 61 br 65
 62 acc8= constant 0
 63 call writeAcc8
 64 ;test9.p(9)   if (b < i * 1) write (16); else write (0);
 65 acc8= variable 0
 66 acc16= variable 1
 67 acc16* constant 1
 68 acc16CompareAcc8
 69 brge 73
 70 acc8= constant 16
 71 call writeAcc8
 72 br 76
 73 acc8= constant 0
 74 call writeAcc8
 75 ;test9.p(10)   if (3 * 3 < i) write (15); else write (0);
 76 acc8= constant 3
 77 acc8* constant 3
 78 acc8ToAcc16
 79 accom16 variable 1
 80 brge 84
 81 acc8= constant 15
 82 call writeAcc8
 83 br 87
 84 acc8= constant 0
 85 call writeAcc8
 86 ;test9.p(11)   if (6561 * 1 > b) write (14); else write (0);
 87 acc16= constant 6561
 88 acc16* constant 1
 89 accom16 variable 0
 90 brle 94
 91 acc8= constant 14
 92 call writeAcc8
 93 br 97
 94 acc8= constant 0
 95 call writeAcc8
 96 ;test9.p(12)   if (i > 3 * 3) write (13); else write (0);
 97 acc16= variable 1
 98 acc8= constant 3
 99 acc8* constant 3
100 accom16 acc8
101 brle 105
102 acc8= constant 13
103 call writeAcc8
104 br 108
105 acc8= constant 0
106 call writeAcc8
107 ;test9.p(13)   if (b < 6561 * 1) write (12); else write (0);
108 acc8= variable 0
109 acc16= constant 6561
110 acc16* constant 1
111 acc16CompareAcc8
112 brge 116
113 acc8= constant 12
114 call writeAcc8
115 br 119
116 acc8= constant 0
117 call writeAcc8
118 ;test9.p(14)   if (i > b) write (11); else write (0);
119 acc16= variable 1
120 accom16 variable 0
121 brle 125
122 acc8= constant 11
123 call writeAcc8
124 br 128
125 acc8= constant 0
126 call writeAcc8
127 ;test9.p(15)   if (b < i) write (10); else write (0);
128 acc8= variable 0
129 acc8ToAcc16
130 accom16 variable 1
131 brge 135
132 acc8= constant 10
133 call writeAcc8
134 br 139
135 acc8= constant 0
136 call writeAcc8
137 ;test9.p(16) 
138 ;test9.p(17)   if (3 * 3 < 6561 * 1) write (9); else write (0);
139 acc8= constant 3
140 acc8* constant 3
141 acc16= constant 6561
142 acc16* constant 1
143 acc16CompareAcc8
144 brge 148
145 acc8= constant 9
146 call writeAcc8
147 br 151
148 acc8= constant 0
149 call writeAcc8
150 ;test9.p(18)   if (6561 * 1 > 3 * 3) write (8); else write (0);
151 acc16= constant 6561
152 acc16* constant 1
153 acc8= constant 3
154 acc8* constant 3
155 accom16 acc8
156 brle 160
157 acc8= constant 8
158 call writeAcc8
159 br 163
160 acc8= constant 0
161 call writeAcc8
162 ;test9.p(19)   if (9 < 6561 * 1) write (7); else write (0);
163 acc8= constant 9
164 acc16= constant 6561
165 acc16* constant 1
166 acc16CompareAcc8
167 brge 171
168 acc8= constant 7
169 call writeAcc8
170 br 174
171 acc8= constant 0
172 call writeAcc8
173 ;test9.p(20)   if (6561 * 1 > 9) write (6); else write (0);
174 acc16= constant 6561
175 acc16* constant 1
176 accom16 constant 9
177 brle 181
178 acc8= constant 6
179 call writeAcc8
180 br 184
181 acc8= constant 0
182 call writeAcc8
183 ;test9.p(21)   if (6561 > 3 * 3) write (5); else write (0);
184 acc16= constant 6561
185 acc8= constant 3
186 acc8* constant 3
187 accom16 acc8
188 brle 192
189 acc8= constant 5
190 call writeAcc8
191 br 195
192 acc8= constant 0
193 call writeAcc8
194 ;test9.p(22)   if (3 * 3 < 6561) write (4); else write (0);
195 acc8= constant 3
196 acc8* constant 3
197 acc8ToAcc16
198 accom16 constant 6561
199 brge 203
200 acc8= constant 4
201 call writeAcc8
202 br 206
203 acc8= constant 0
204 call writeAcc8
205 ;test9.p(23)   if (9 < 6561) write (3); else write (0);
206 acc8= constant 9
207 acc8ToAcc16
208 accom16 constant 6561
209 brge 213
210 acc8= constant 3
211 call writeAcc8
212 br 216
213 acc8= constant 0
214 call writeAcc8
215 ;test9.p(24)   if (6561 > 9) write (2); else write (0);
216 acc16= constant 6561
217 accom16 constant 9
218 brle 222
219 acc8= constant 2
220 call writeAcc8
221 br 225
222 acc8= constant 0
223 call writeAcc8
224 ;test9.p(25)   write(1);
225 acc8= constant 1
226 call writeAcc8
227 ;test9.p(26)   write(0);
228 acc8= constant 0
229 call writeAcc8
230 ;test9.p(27) }
231 stop
