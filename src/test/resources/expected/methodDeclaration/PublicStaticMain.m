   0 call 9
   1 stop
   2 ;PublicStaticMain.j(0) /*
   3 ;PublicStaticMain.j(1)  * A small program in the miniJava language.
   4 ;PublicStaticMain.j(2)  * Test final modifier in method declaration gives an error.
   5 ;PublicStaticMain.j(3)  */
   6 ;PublicStaticMain.j(4) class PublicStaticMain {
   7 class PublicStaticMain []
   8 ;PublicStaticMain.j(5)   public static void main() {
   9 method PublicStaticMain.main [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 0
  13 ;PublicStaticMain.j(6)     println("PublicStaticMain Klaar");
  14 acc16= stringconstant 21
  15 writeLineString
  16 ;PublicStaticMain.j(7)   }
  17 stackPointer= basePointer
  18 basePointer<
  19 return
  20 ;PublicStaticMain.j(8) }
  21 stringConstant 0 = "PublicStaticMain Klaar"
