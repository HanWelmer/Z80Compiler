   0 call 69
   1 stop
   2 ;testSleep.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   3 ;testSleep.j(1) class TestSleep {
   4 class TestSleep []
   5 ;testSleep.j(2)   private static final byte VALUE = 200;
   6 ;testSleep.j(3)   private static final word BIG_VALUE = 10000;
   7 ;testSleep.j(4)   private static byte globalByte = 250;
   8 acc8= constant 250
   9 acc8=> variable 3
  10 ;testSleep.j(5)   private static word globalWord = 10000;
  11 acc16= constant 10000
  12 acc16=> variable 4
  13 ;testSleep.j(6) 
  14 ;testSleep.j(7)   /**
  15 ;testSleep.j(8)    * Wait 1 msec at 18,432 MHz with no wait states.
  16 ;testSleep.j(9)    * 
  17 ;testSleep.j(10)    * With n=255 the routine requires 108 + n * 71 = 18213 T-states, 
  18 ;testSleep.j(11)    * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
  19 ;testSleep.j(12)    * 
  20 ;testSleep.j(13)    * Duplicating the for loop with a total of 257 for n and m 
  21 ;testSleep.j(14)    * requires 132 + (n + m) * 71 = 18379 T-states,
  22 ;testSleep.j(15)    * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
  23 ;testSleep.j(16)    */
  24 ;testSleep.j(17)   public static void sleepOneMillisecond() {
  25 method TestSleep.sleepOneMillisecond [public, static] void ()
  26 <basePointer
  27 basePointer= stackPointer
  28 stackPointer+ constant 1
  29 ;testSleep.j(18)     for (byte b = 255; b!=0; b--) ;
  30 acc8= constant 255
  31 acc8=> (basePointer + -1)
  32 acc8= (basePointer + -1)
  33 acc8Comp constant 0
  34 breq 40
  35 br 38
  36 decr8 (basePointer + -1)
  37 br 32
  38 br 36
  39 ;testSleep.j(19)   }
  40 stackPointer= basePointer
  41 basePointer<
  42 return
  43 ;testSleep.j(20) 
  44 ;testSleep.j(21)   /**
  45 ;testSleep.j(22)    * sleep for n miliseconds.
  46 ;testSleep.j(23)    */
  47 ;testSleep.j(24)   public static void sleep(word n) {
  48 method TestSleep.sleep [public, static] void (word n {bp+4})
  49 <basePointer
  50 basePointer= stackPointer
  51 stackPointer+ constant 0
  52 ;testSleep.j(25)     while (n != 0) {
  53 acc16= (basePointer + 4)
  54 acc8= constant 0
  55 acc16CompareAcc8
  56 breq 64
  57 ;testSleep.j(26)       sleepOneMillisecond();
  58 call 25
  59 ;testSleep.j(27)       n--;
  60 decr16 (basePointer + 4)
  61 ;testSleep.j(28)     }
  62 br 53
  63 ;testSleep.j(29)   }
  64 stackPointer= basePointer
  65 basePointer<
  66 return
  67 ;testSleep.j(30) 
  68 ;testSleep.j(31)   public static void main() {
  69 method TestSleep.main [public, static] void ()
  70 <basePointer
  71 basePointer= stackPointer
  72 stackPointer+ constant 3
  73 ;testSleep.j(32)     println(0);
  74 acc8= constant 0
  75 writeLineAcc8
  76 ;testSleep.j(33)   
  77 ;testSleep.j(34)     byte localByte = 250;
  78 acc8= constant 250
  79 acc8=> (basePointer + -1)
  80 ;testSleep.j(35)     word localWord = 10000;
  81 acc16= constant 10000
  82 acc16=> (basePointer + -3)
  83 ;testSleep.j(36) 
  84 ;testSleep.j(37)     //println("sleeping 0.25 second:");
  85 ;testSleep.j(38)     //sleep(250);
  86 ;testSleep.j(39)     println("sleeping 10 second:");
  87 acc16= stringconstant 134
  88 writeLineString
  89 ;testSleep.j(40)     sleep(10000);
  90 acc16= constant 10000
  91 <acc16
  92 call 48
  93 stackPointer+ constant -2
  94 ;testSleep.j(41)     //println("sleeping 0.25 second:");
  95 ;testSleep.j(42)     //sleep(VALUE);
  96 ;testSleep.j(43)     println("sleeping 10 second:");
  97 acc16= stringconstant 134
  98 writeLineString
  99 ;testSleep.j(44)     sleep(BIG_VALUE);
 100 acc16= constant 10000
 101 <acc16
 102 call 48
 103 stackPointer+ constant -2
 104 ;testSleep.j(45)     //println("sleeping 0.25 second:");
 105 ;testSleep.j(46)     //sleep(localByte);
 106 ;testSleep.j(47)     println("sleeping 10 second:");
 107 acc16= stringconstant 134
 108 writeLineString
 109 ;testSleep.j(48)     sleep(localWord);
 110 acc16= (basePointer + -3)
 111 <acc16
 112 call 48
 113 stackPointer+ constant -2
 114 ;testSleep.j(49)     //println("sleeping 0.25 second:");
 115 ;testSleep.j(50)     //sleep(globalByte);
 116 ;testSleep.j(51)     println("sleeping 10 second:");
 117 acc16= stringconstant 134
 118 writeLineString
 119 ;testSleep.j(52)     sleep(globalWord);
 120 acc16= variable 4
 121 <acc16
 122 call 48
 123 stackPointer+ constant -2
 124 ;testSleep.j(53)   
 125 ;testSleep.j(54)     println("Klaar");
 126 acc16= stringconstant 135
 127 writeLineString
 128 ;testSleep.j(55)   }
 129 stackPointer= basePointer
 130 basePointer<
 131 return
 132 ;testSleep.j(56) 
 133 ;testSleep.j(57) }
 134 stringConstant 0 = "sleeping 10 second:"
 135 stringConstant 1 = "Klaar"
