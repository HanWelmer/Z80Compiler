   0 call 25
   1 stop
   2 ;TestByteParameter.j(0) public class TestByteParameter {
   3 class TestByteParameter [public]
   4 ;TestByteParameter.j(1)   
   5 ;TestByteParameter.j(2)   private static void doIt(byte b) {
   6 method TestByteParameter.doIt [private, static] void (byte b {bp-4})
   7 <basePointer
   8 basePointer= stackPointer
   9 stackPointer+ constant 1
  10 ;TestByteParameter.j(3)     println(b);
  11 acc8= byte basePointer + -4
  12 writeLineAcc8
  13 ;TestByteParameter.j(4)     byte bv = 2;
  14 acc8= constant 2
  15 acc8=> byte basePointer + 1
  16 ;TestByteParameter.j(5)     println(bv);
  17 acc8= byte basePointer + 1
  18 writeLineAcc8
  19 ;TestByteParameter.j(6)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;TestByteParameter.j(7) 
  24 ;TestByteParameter.j(8)   public static void main() {
  25 method TestByteParameter.main [public, static] void ()
  26 <basePointer
  27 basePointer= stackPointer
  28 stackPointer+ constant 0
  29 ;TestByteParameter.j(9)     println("Verwacht 0..2");
  30 acc16= stringconstant 48
  31 writeLineString
  32 ;TestByteParameter.j(10)     println(0);
  33 acc8= constant 0
  34 writeLineAcc8
  35 ;TestByteParameter.j(11)     doIt(1);
  36 acc8= constant 1
  37 <acc8
  38 call 6
  39 stackPointer+ constant -1
  40 ;TestByteParameter.j(12)     println("Klaar");
  41 acc16= stringconstant 49
  42 writeLineString
  43 ;TestByteParameter.j(13)   }
  44 stackPointer= basePointer
  45 basePointer<
  46 return
  47 ;TestByteParameter.j(14) }
  48 stringConstant 0 = "Verwacht 0..2"
  49 stringConstant 1 = "Klaar"
