   0 call 7
   1 stop
   2 ;TestEmptyClass.j(0) /* Program to test generated Z80 assembler code */
   3 ;TestEmptyClass.j(1) class TestEmptyClass {
   4 class TestEmptyClass []
   5 ;TestEmptyClass.j(2) 
   6 ;TestEmptyClass.j(3)   public static void main() {
   7 method TestEmptyClass.main [public, static] void ()
   8 <basePointer
   9 basePointer= stackPointer
  10 stackPointer+ constant 0
  11 ;TestEmptyClass.j(4)     ;
  12 ;TestEmptyClass.j(5)   }
  13 stackPointer= basePointer
  14 basePointer<
  15 return
  16 ;TestEmptyClass.j(6) }
