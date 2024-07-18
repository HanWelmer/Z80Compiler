   0 call 9
   1 stop
   2 ;StaticMain.j(0) /*
   3 ;StaticMain.j(1)  * A small program in the miniJava language.
   4 ;StaticMain.j(2)  * Test final modifier in method declaration gives an error.
   5 ;StaticMain.j(3)  */
   6 ;StaticMain.j(4) class StaticMain {
   7 class StaticMain []
   8 ;StaticMain.j(5)   static void main() {
   9 method StaticMain.main [static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 0
  13 ;StaticMain.j(6)     println("StaticMain Klaar");
  14 acc16= stringconstant 21
  15 writeLineString
  16 ;StaticMain.j(7)   }
  17 stackPointer= basePointer
  18 basePointer<
  19 return
  20 ;StaticMain.j(8) }
  21 stringConstant 0 = "StaticMain Klaar"
