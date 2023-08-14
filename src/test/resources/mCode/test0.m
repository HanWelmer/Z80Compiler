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
  18 acc16= constant 53
  19 writeString
  20 acc16= constant 54
  21 writeLineString
  22 ;test0.j(8)   println("Nog" + " een" + " bericht.");
  23 acc16= constant 55
  24 writeString
  25 acc16= constant 56
  26 writeString
  27 acc16= constant 57
  28 writeLineString
  29 ;test0.j(9)   println("3 + 2 = " + 5);
  30 acc16= constant 58
  31 writeString
  32 acc8= constant 5
  33 call writeLineAcc8
  34 ;test0.j(10)   println("3 + 3 = " + (2 * 3));
  35 acc16= constant 59
  36 writeString
  37 acc8= constant 2
  38 acc8* constant 3
  39 call writeLineAcc8
  40 ;test0.j(11)   println("3 + 4 = " + (2 + 5) + ".");
  41 acc16= constant 60
  42 writeString
  43 acc8= constant 2
  44 acc8+ constant 5
  45 call writeAcc8
  46 acc16= constant 61
  47 writeLineString
  48 ;test0.j(12)   println("Klaar.");
  49 acc16= constant 62
  50 writeLineString
  51 ;test0.j(13) }
  52 stop
  53 stringConstant 0 = "Hallo"
  54 stringConstant 1 = " wereld."
  55 stringConstant 2 = "Nog"
  56 stringConstant 3 = " een"
  57 stringConstant 4 = " bericht."
  58 stringConstant 5 = "3 + 2 = "
  59 stringConstant 6 = "3 + 3 = "
  60 stringConstant 7 = "3 + 4 = "
  61 stringConstant 8 = "."
  62 stringConstant 9 = "Klaar."
