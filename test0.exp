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
  18 acc16= constant 34
  19 writeString
  20 acc16= constant 35
  21 writeString
  22 ;test0.j(8)   write("Nog" + " een" + " bericht.");
  23 acc16= constant 36
  24 writeString
  25 acc16= constant 37
  26 writeString
  27 acc16= constant 38
  28 writeString
  29 ;test0.j(9)   write("Klaar.");
  30 acc16= constant 39
  31 writeString
  32 ;test0.j(10) }
  33 stop
  34 stringConstant 0 = "Hallo"
  35 stringConstant 1 = "Wereld."
  36 stringConstant 2 = "Nog"
  37 stringConstant 3 = " een"
  38 stringConstant 4 = " bericht."
  39 stringConstant 5 = "Klaar."
