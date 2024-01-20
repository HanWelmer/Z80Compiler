   0 ;NoMain.j(0) /*
   1 ;NoMain.j(1)  * A small program in the miniJava language.
   2 ;NoMain.j(2)  * Test that a class without a main method can be compiled but can't be run.
   3 ;NoMain.j(3)  */
   4 ;NoMain.j(4) class NoMain {
   5 ;NoMain.j(5)   public static void noMain() {
   6 ;NoMain.j(6)     println("NoMain");
   7 acc16= constant 12
   8 writeLineString
   9 ;NoMain.j(7)   }
  10 ;NoMain.j(8) }
  11 stop
  12 stringConstant 0 = "NoMain"
