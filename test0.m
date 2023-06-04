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
  18 acc16= constant 44
  19 writeString
  20 acc16= constant 45
  21 writeLineString
  22 ;test0.j(8)   //println("Hallo" * " wereld.");
  23 ;test0.j(9)   println("Nog" + " een" + " bericht.");
  24 acc16= constant 46
  25 writeString
  26 acc16= constant 47
  27 writeString
  28 acc16= constant 48
  29 writeLineString
  30 ;test0.j(10)   println(2*3);
  31 acc8= constant 2
  32 acc8* constant 3
  33 call writeLineAcc8
  34 ;test0.j(11)   println(500 * 504 - 54354);
  35 acc16= constant 500
  36 acc16* constant 504
  37 acc16- constant 54354
  38 call writeLineAcc16
  39 ;test0.j(12)   println("Klaar.");
  40 acc16= constant 49
  41 writeLineString
  42 ;test0.j(13) }
  43 stop
  44 stringConstant 0 = "Hallo"
  45 stringConstant 1 = " wereld."
  46 stringConstant 2 = "Nog"
  47 stringConstant 3 = " een"
  48 stringConstant 4 = " bericht."
  49 stringConstant 5 = "Klaar."
