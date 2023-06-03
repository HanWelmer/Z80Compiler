   0 ;test0.j(0) /* Program to test generated Z80 assembler code */
   1 ;test0.j(1) class TestPrint {
   2 ;test0.j(2)   word i = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test0.j(3)   byte b = 2;
   6 acc8= constant 2
   7 acc8=> variable 2
   8 ;test0.j(4)   write(0);
   9 acc8= constant 0
  10 call writeAcc8
  11 ;test0.j(5)   write(i);
  12 acc16= variable 0
  13 call writeAcc16
  14 ;test0.j(6)   write(b);
  15 acc8= variable 2
  16 call writeAcc8
  17 ;test0.j(7)   write("Hallo" + "Wereld.");
  18 acc16= constant 36
  19 writeString
  20 acc16= constant 37
  21 writeString
  22 ;test0.j(8)   write("Nog" + " een" + " bericht.");
  23 acc16= constant 38
  24 writeString
  25 acc16= constant 39
  26 writeString
  27 acc16= constant 39
  28 writeString
  29 acc16= constant 40
  30 writeString
  31 ;test0.j(9)   write("Klaar.");
  32 acc16= constant 41
  33 writeString
  34 ;test0.j(10) }
  35 stop
  36 stringConstant 0 = "Hallo"
  37 stringConstant 1 = "Wereld."
  38 stringConstant 2 = "Nog"
  39 stringConstant 3 = " een"
  40 stringConstant 4 = " bericht."
  41 stringConstant 5 = "Klaar."
