   0 ;NoMain.j(0) /*
   1 ;NoMain.j(1)  * A small program in the miniJava language.
   2 ;NoMain.j(2)  * Test that a class without a main method can be compiled but can't be run.
   3 ;NoMain.j(3)  */
   4 ;NoMain.j(4) class NoMain {
   5 class NoMain []
   6 ;NoMain.j(5)   public static void noMain() {
   7 method noMain [public, static] void
   8 ;NoMain.j(6)     println("NoMain");
   9 acc16= constant 14
  10 writeLineString
  11 ;NoMain.j(7)   }
  12 ;NoMain.j(8) }
  13 stop
  14 stringConstant 0 = "NoMain"
