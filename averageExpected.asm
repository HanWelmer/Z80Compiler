LD   HL,0
LD   (4000),HL
LD   HL,0
LD   (4002),HL
CALL read
LD   (4004),HL
LD   HL,(4004)
LD   DE,0
PUSH  HL            <- overbodig
SCF
CCF
SBC   HL,DE
POP   HL            <- overbodig
JP   Z,0            <- invullen
LD   HL,(4000)
LD   DE,(4004)
ADD   HL,DE
LD   (4000),HL
LD   HL,(4002)
LD   DE,1
ADD   HL,DE
LD   (4002),HL
CALL read
LD   (4004),HL
JP   6            <- invullen (7)
LD   HL,(4002)
PUSH HL
CALL write
LD   HL,(4000)
PUSH HL
CALL write
LD   HL,(4002)
LD   DE,0
PUSH  HL            <- overbodig
SCF
CCF
SBC   HL,DE
POP   HL            <- overbodig
JP   Z,0            <- invullen
LD   HL,(4000)
LD   DE,(4002)
LD   A,D            <- call div16
OR   E
JR   Z,ERROR
LD   B,H
LD   C,L
LD   HL,0
LD   A,B
LD   B,16D
TRIALSB:
RL   C
RLA
ADC  HL,HL
SBC  HL,DE
NULL:
CCF
JR   NC,NGV
PTV:
DJNZ TRIALSB
JP   DONE
RESTOR:
RL   C
RLA
ADC  HL,HL
AND  A
ADC  HL,DE
JR   C,PTV
JR   Z,NULL
NGV:
DJNZ RESTOR
DONE:
RL   C
RLA
LD   B,A
LD   A,H
OR   A
JP   P,PREM
ADD  HL,DE
PREM:
RET
PUSH HL
CALL write
HALT
