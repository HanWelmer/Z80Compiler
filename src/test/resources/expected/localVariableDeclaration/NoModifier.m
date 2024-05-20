   0 call 81
   1 stop
   2 ;NoModifier.j(0) /*
   3 ;NoModifier.j(1)  * A small program in the miniJava language.
   4 ;NoModifier.j(2)  * Test final modifier in a local variable declaration.
   5 ;NoModifier.j(3)  */
   6 ;NoModifier.j(4) class NoModifier {
   7 class NoModifier []
   8 ;NoModifier.j(5)   public static void doByte() {
   9 method doByte [public, static] void ()
  10 <basePointer
  11 basePointer= stackPointer
  12 stackPointer+ constant 1
  13 ;NoModifier.j(6)     byte b = 1;
  14 acc8= constant 1
  15 acc8=> (basePointer + -1)
  16 ;NoModifier.j(7)     println(b);
  17 acc8= (basePointer + -1)
  18 writeLineAcc8
  19 ;NoModifier.j(8)   }
  20 stackPointer= basePointer
  21 basePointer<
  22 return
  23 ;NoModifier.j(9)   public static void doByteWord() {
  24 method doByteWord [public, static] void ()
  25 <basePointer
  26 basePointer= stackPointer
  27 stackPointer+ constant 3
  28 ;NoModifier.j(10)     byte b = 2;
  29 acc8= constant 2
  30 acc8=> (basePointer + -1)
  31 ;NoModifier.j(11)     word w = 3333;
  32 acc16= constant 3333
  33 acc16=> (basePointer + -3)
  34 ;NoModifier.j(12)     println(b);
  35 acc8= (basePointer + -1)
  36 writeLineAcc8
  37 ;NoModifier.j(13)     println(w);
  38 acc16= (basePointer + -3)
  39 writeLineAcc16
  40 ;NoModifier.j(14)   }
  41 stackPointer= basePointer
  42 basePointer<
  43 return
  44 ;NoModifier.j(15)   public static void doWordByte() {
  45 method doWordByte [public, static] void ()
  46 <basePointer
  47 basePointer= stackPointer
  48 stackPointer+ constant 3
  49 ;NoModifier.j(16)     word w = 5555;
  50 acc16= constant 5555
  51 acc16=> (basePointer + -2)
  52 ;NoModifier.j(17)     byte b = 4;
  53 acc8= constant 4
  54 acc8=> (basePointer + -3)
  55 ;NoModifier.j(18)     println(b);
  56 acc8= (basePointer + -3)
  57 writeLineAcc8
  58 ;NoModifier.j(19)     println(w);
  59 acc16= (basePointer + -2)
  60 writeLineAcc16
  61 ;NoModifier.j(20)   }
  62 stackPointer= basePointer
  63 basePointer<
  64 return
  65 ;NoModifier.j(21)   public static void doString() {
  66 method doString [public, static] void ()
  67 <basePointer
  68 basePointer= stackPointer
  69 stackPointer+ constant 2
  70 ;NoModifier.j(22)     String str = "Hallo Wereld";
  71 acc16= stringconstant 107
  72 acc16=> (basePointer + -2)
  73 ;NoModifier.j(23)     println(str);
  74 acc16= (basePointer + -2)
  75 writeLineString
  76 ;NoModifier.j(24)   }
  77 stackPointer= basePointer
  78 basePointer<
  79 return
  80 ;NoModifier.j(25)   public static void main() {
  81 method main [public, static] void ()
  82 <basePointer
  83 basePointer= stackPointer
  84 stackPointer+ constant 1
  85 ;NoModifier.j(26)     byte b = 0;
  86 acc8= constant 0
  87 acc8=> (basePointer + -1)
  88 ;NoModifier.j(27)     println(b);
  89 acc8= (basePointer + -1)
  90 writeLineAcc8
  91 ;NoModifier.j(28)     doString();
  92 call 66
  93 ;NoModifier.j(29)     doByte();
  94 call 9
  95 ;NoModifier.j(30)     doByteWord();
  96 call 24
  97 ;NoModifier.j(31)     doWordByte();
  98 call 45
  99 ;NoModifier.j(32)     println("klaar");
 100 acc16= stringconstant 108
 101 writeLineString
 102 ;NoModifier.j(33)   }
 103 stackPointer= basePointer
 104 basePointer<
 105 return
 106 ;NoModifier.j(34) }
 107 stringConstant 0 = "Hallo Wereld"
 108 stringConstant 1 = "klaar"
