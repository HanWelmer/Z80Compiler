JP main
mul16:
push bc
ld b,h
ld c,l
ld hl,0
ld a,16
mul16_1:
add hl,hl
rl e
rl d
jr nc,mul16_2
add hl,bc
jr nc, mul16_2
inc de
mul16_2:
dec a
jr nz, mul16_1
pop bc
ret
div16:
LD   A,D
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
main:
LD   HL,0
LD   (4000),HL
LD   HL,0
LD   (4002),HL
CALL read
LD   (4004),HL
L67:
LD   HL,(4004)
LD   DE,0
PUSH  HL
SCF
CCF
SBC   HL,DE
POP   HL
JP Z,L87
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
JP L67
L87:
LD   HL,(4002)
PUSH HL
CALL write
LD   HL,(4000)
PUSH HL
CALL write
LD   HL,(4002)
LD   DE,0
PUSH  HL
SCF
CCF
SBC   HL,DE
POP   HL
JP Z,L107
LD   HL,(4000)
LD   DE,(4002)
CALL div16
PUSH HL
CALL write
L107:
HALT
