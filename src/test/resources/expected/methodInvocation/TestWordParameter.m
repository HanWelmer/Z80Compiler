   0 call 25
   1 stop
   2 ;TestWordParameter.j(0) public class TestWordParameter {
   3 class TestWordParameter [public]
   4 ;TestWordParameter.j(1)   
   5 ;TestWordParameter.j(2)   private static void doIt(word w) {
   6 method TestWordParameter.doIt [private, static] void (word w {bp-4})
   7 <basePointer
   8 basePointer= stackPointer
   9 stackPointer+ constant 2
  10 ;TestWordParameter.j(3)     println(w);
  11 acc16= word basePointer + -4
  12 writeLineAcc16
  13 ;TestWordParameter.j(4)     word wv = 1002;
  14 acc16= constant 1002
  15 acc16=> word basePointer + 2
  16 ;TestWordParameter.j(5)     println(wv);
  17 acc16= word basePointer + 2
  18 writeLineAcc16
  19 ;TestWordParameter.j(6)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;TestWordParameter.j(7) 
  24 ;TestWordParameter.j(8)   public static void main() {
  25 method TestWordParameter.main [public, static] void ()
  26 <basePointer
  27 basePointer= stackPointer
  28 stackPointer+ constant 0
  29 ;TestWordParameter.j(9)     println("Verwacht 1000..1002");
  30 acc16= stringconstant 48
  31 writeLineString
  32 ;TestWordParameter.j(10)     println(1000);
  33 acc16= constant 1000
  34 writeLineAcc16
  35 ;TestWordParameter.j(11)     doIt(1001);
  36 acc16= constant 1001
  37 <acc16
  38 call 6
  39 stackPointer+ constant -2
  40 ;TestWordParameter.j(12)     println("Klaar");
  41 acc16= stringconstant 49
  42 writeLineString
  43 ;TestWordParameter.j(13)   }
  44 stackPointer= basePointer
  45 basePointer<
  46 return
  47 ;TestWordParameter.j(14) }
  48 stringConstant 0 = "Verwacht 1000..1002"
  49 stringConstant 1 = "Klaar"
