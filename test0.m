   0 ;test0.j(0) /* Program to test generated Z80 assembler code */
   1 ;test0.j(1) class TestPrint {
   2 ;test0.j(2)   word i = 1;
   3 acc8= constant 1
   4 acc8=> variable 0
   5 ;test0.j(3)   byte b = 2;
   6 acc8= constant 2
   7 acc8=> variable 2
   8 ;test0.j(4)   println(0);
   9 acc8= constant 0
  10 call writeLineAcc8
  11 ;test0.j(5)   println(i);
  12 acc16= variable 0
  13 call writeLineAcc16
  14 ;test0.j(6)   println(b);
  15 acc8= variable 2
  16 call writeLineAcc8
  17 ;test0.j(7)   println("Hallo" + " wereld.");
  18 acc16= constant 35
  19 writeString
  20 acc16= constant 36
  21 writeLineString
  22 ;test0.j(8)   //println("Hallo" - " wereld.");
  23 ;test0.j(9)   println("Nog" + " een" + " bericht.");
  24 acc16= constant 37
  25 writeString
  26 acc16= constant 38
  27 writeString
  28 acc16= constant 39
  29 writeLineString
  30 ;test0.j(10)   println("Klaar.");
  31 acc16= constant 40
  32 writeLineString
  33 ;test0.j(11) }
  34 stop
  35 stringConstant 0 = "Hallo"
  36 stringConstant 1 = " wereld."
  37 stringConstant 2 = "Nog"
  38 stringConstant 3 = " een"
  39 stringConstant 4 = " bericht."
  40 stringConstant 5 = "Klaar."
