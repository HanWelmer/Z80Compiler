     ;{Program to test some compiler constructs}
     ;VAR A, B, C, D;
     ;BEGIN
     ;  WRITE(READ);
CALL read
PUSH HL
CALL write
     ;
     ;  A := READ;
CALL read
LD   (4000),HL
     ;  A := 2;
LD   HL,2
LD   (4000),HL
     ;  B := 3;
LD   HL,3
LD   (4002),HL
     ;  C := 4;
LD   HL,4
LD   (4004),HL
     ;  D := 5;
LD   HL,5
LD   (4006),HL
     ;  B := A;
LD   HL,(4000)
LD   (4002),HL
     ;  B := B;
LD   HL,(4002)
LD   (4002),HL
     ;  B := C;
LD   HL,(4004)
LD   (4002),HL
     ;  B := D;
LD   HL,(4006)
LD   (4002),HL
     ; 
     ;  WRITE(1);
LD   HL,1
PUSH HL
CALL write
     ;  WRITE(A);
LD   HL,(4000)
PUSH HL
CALL write
     ;  
     ;  B := READ + READ;
CALL read
PUSH HL
CALL read
POP  DE
ADD  HL,DE
LD   (4002),HL
     ;  B := READ + 1;
CALL read
LD   DE,1
ADD  HL,DE
LD   (4002),HL
     ;  B := READ + A;
CALL read
LD   DE,(4000)
ADD  HL,DE
LD   (4002),HL
     ;  B := 1 + READ;
LD   HL,1
PUSH HL
CALL read
POP  DE
ADD  HL,DE
LD   (4002),HL
     ;  B := 2 + 1;
LD   HL,2
LD   DE,1
ADD  HL,DE
LD   (4002),HL
     ;  B := 1 + A;
LD   HL,1
LD   DE,(4000)
ADD  HL,DE
LD   (4002),HL
     ;  B := A + READ;
LD   HL,(4000)
PUSH HL
CALL read
POP  DE
ADD  HL,DE
LD   (4002),HL
     ;  B := A + 1;
LD   HL,(4000)
LD   DE,1
ADD  HL,DE
LD   (4002),HL
     ;  C := A + B;
LD   HL,(4000)
LD   DE,(4002)
ADD  HL,DE
LD   (4004),HL
     ;
     ;  B := READ - READ;
CALL read
PUSH HL
CALL read
POP  DE
EX   DE,HL
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := READ - 1;
CALL read
LD   DE,1
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := READ - A;
CALL read
LD   DE,(4000)
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := 1 - READ;
LD   HL,1
PUSH HL
CALL read
POP  DE
EX   DE,HL
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := 1 - 1;
LD   HL,1
LD   DE,1
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := 3 - A;
LD   HL,3
LD   DE,(4000)
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := A - READ;
LD   HL,(4000)
PUSH HL
CALL read
POP  DE
EX   DE,HL
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  B := A - 2;
LD   HL,(4000)
LD   DE,2
OR   A
SBC  HL,DE
LD   (4002),HL
     ;  C := A - B;
LD   HL,(4000)
LD   DE,(4002)
OR   A
SBC  HL,DE
LD   (4004),HL
     ;
     ;  B := READ * READ;
CALL read
PUSH HL
CALL read
POP  DE
CALL mul16
LD   (4002),HL
     ;  B := READ * 5;
CALL read
LD   DE,5
CALL mul16
LD   (4002),HL
     ;  B := READ * A;
CALL read
LD   DE,(4000)
CALL mul16
LD   (4002),HL
     ;  B := 3 * READ;
LD   HL,3
PUSH HL
CALL read
POP  DE
CALL mul16
LD   (4002),HL
     ;  B := 3 * 5;
LD   HL,3
LD   DE,5
CALL mul16
LD   (4002),HL
     ;  B := 3 * A;
LD   HL,3
LD   DE,(4000)
CALL mul16
LD   (4002),HL
     ;  B := A * READ;
LD   HL,(4000)
PUSH HL
CALL read
POP  DE
CALL mul16
LD   (4002),HL
     ;  B := A * 5;
LD   HL,(4000)
LD   DE,5
CALL mul16
LD   (4002),HL
     ;  C := A * B;
LD   HL,(4000)
LD   DE,(4002)
CALL mul16
LD   (4004),HL
     ;  
     ;  C := A * (READ + READ);
LD   HL,(4000)
PUSH HL
CALL read
PUSH HL
CALL read
POP  DE
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (READ + 1);
LD   HL,(4000)
PUSH HL
CALL read
LD   DE,1
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (READ + B);
LD   HL,(4000)
PUSH HL
CALL read
LD   DE,(4002)
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (1 + READ);
LD   HL,(4000)
PUSH HL
LD   HL,1
PUSH HL
CALL read
POP  DE
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (1 + 2);
LD   HL,(4000)
PUSH HL
LD   HL,1
LD   DE,2
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (1 + B);
LD   HL,(4000)
PUSH HL
LD   HL,1
LD   DE,(4002)
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (B + READ);
LD   HL,(4000)
PUSH HL
LD   HL,(4002)
PUSH HL
CALL read
POP  DE
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  C := A * (B + 2);
LD   HL,(4000)
PUSH HL
LD   HL,(4002)
LD   DE,2
ADD  HL,DE
POP  DE
CALL mul16
LD   (4004),HL
     ;  D := A * (A + C);
LD   HL,(4000)
PUSH HL
LD   HL,(4000)
LD   DE,(4004)
ADD  HL,DE
POP  DE
CALL mul16
LD   (4006),HL
     ;
     ;  B := READ / READ;
CALL read
PUSH HL
CALL read
POP  DE
EX   DE,HL
CALL div16
LD   (4002),HL
     ;  B := READ / 5;
CALL read
LD   DE,5
CALL div16
LD   (4002),HL
     ;  B := READ / A;
CALL read
LD   DE,(4000)
CALL div16
LD   (4002),HL
     ;  B := 3 / READ;
LD   HL,3
PUSH HL
CALL read
POP  DE
EX   DE,HL
CALL div16
LD   (4002),HL
     ;  B := 3 / 5;
LD   HL,3
LD   DE,5
CALL div16
LD   (4002),HL
     ;  B := 3 / A;
LD   HL,3
LD   DE,(4000)
CALL div16
LD   (4002),HL
     ;  B := A / READ;
LD   HL,(4000)
PUSH HL
CALL read
POP  DE
EX   DE,HL
CALL div16
LD   (4002),HL
     ;  B := A / 5;
LD   HL,(4000)
LD   DE,5
CALL div16
LD   (4002),HL
     ;  C := A / B;
LD   HL,(4000)
LD   DE,(4002)
CALL div16
LD   (4004),HL
     ;{
     ;}
     ;END.
JP   0x0171
