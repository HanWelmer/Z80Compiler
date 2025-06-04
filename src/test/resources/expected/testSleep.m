   0 call 8
   1 stop
   2 ;testSleep.j(0) /* Program to test generated Z80 assembler code for output and input statements*/
   3 ;testSleep.j(1) class TestSleep {
   4 class TestSleep []
   5 ;testSleep.j(2)   private static final byte VALUE = 200;
   6 ;testSleep.j(3)   private static final word BIG_VALUE = 10000;
   7 ;testSleep.j(4)   private static byte globalByte = 250;
   8 acc8= constant 250
   9 acc8=> byte variable 3
  10 ;testSleep.j(5)   private static word globalWord = 10000;
  11 acc16= constant 10000
  12 acc16=> word variable 4
  13 br 70
  14 ;testSleep.j(6) 
  15 ;testSleep.j(7)   /**
  16 ;testSleep.j(8)    * Wait 1 msec at 18,432 MHz with no wait states.
  17 ;testSleep.j(9)    * 
  18 ;testSleep.j(10)    * With n=255 the routine requires 108 + n * 71 = 18213 T-states, 
  19 ;testSleep.j(11)    * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
  20 ;testSleep.j(12)    * 
  21 ;testSleep.j(13)    * Duplicating the for loop with a total of 257 for n and m 
  22 ;testSleep.j(14)    * requires 132 + (n + m) * 71 = 18379 T-states,
  23 ;testSleep.j(15)    * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
  24 ;testSleep.j(16)    */
  25 ;testSleep.j(17)   public static void sleepOneMillisecond() {
  26 method TestSleep.sleepOneMillisecond [public, static] void ()
  27 <basePointer
  28 basePointer= stackPointer
  29 stackPointer+ constant 1
  30 ;testSleep.j(18)     for (byte b = 255; b!=0; b--) ;
  31 acc8= constant 255
  32 acc8=> (basePointer + 1)
  33 acc8= (basePointer + 1)
  34 acc8Comp constant 0
  35 breq 41
  36 br 39
  37 decr8 (basePointer + 1)
  38 br 33
  39 br 37
  40 ;testSleep.j(19)   }
  41 stackPointer= basePointer
  42 basePointer<
  43 return
  44 ;testSleep.j(20) 
  45 ;testSleep.j(21)   /**
  46 ;testSleep.j(22)    * sleep for n miliseconds.
  47 ;testSleep.j(23)    */
  48 ;testSleep.j(24)   public static void sleep(word n) {
  49 method TestSleep.sleep [public, static] void (word n {bp-4})
  50 <basePointer
  51 basePointer= stackPointer
  52 stackPointer+ constant 0
  53 ;testSleep.j(25)     while (n != 0) {
  54 acc16= (basePointer + -4)
  55 acc8= constant 0
  56 acc16CompareAcc8
  57 breq 65
  58 ;testSleep.j(26)       sleepOneMillisecond();
  59 call 26
  60 ;testSleep.j(27)       n--;
  61 decr16 (basePointer + -4)
  62 ;testSleep.j(28)     }
  63 br 54
  64 ;testSleep.j(29)   }
  65 stackPointer= basePointer
  66 basePointer<
  67 return
  68 ;testSleep.j(30) 
  69 ;testSleep.j(31)   public static void main() {
  70 method TestSleep.main [public, static] void ()
  71 <basePointer
  72 basePointer= stackPointer
  73 stackPointer+ constant 3
  74 ;testSleep.j(32)     println(0);
  75 acc8= constant 0
  76 writeLineAcc8
  77 ;testSleep.j(33)   
  78 ;testSleep.j(34)     byte localByte = 250;
  79 acc8= constant 250
  80 acc8=> (basePointer + 1)
  81 ;testSleep.j(35)     word localWord = 10000;
  82 acc16= constant 10000
  83 acc16=> (basePointer + 3)
  84 ;testSleep.j(36) 
  85 ;testSleep.j(37)     // TODO support byte variable in sleep function.
  86 ;testSleep.j(38)     //println("sleeping 0.25 second (byte constant):");
  87 ;testSleep.j(39)     //sleep(250);
  88 ;testSleep.j(40)     println("sleeping 10 second (word constant):");
  89 acc16= stringconstant 136
  90 writeLineString
  91 ;testSleep.j(41)     sleep(10000);
  92 acc16= constant 10000
  93 <acc16
  94 call 49
  95 stackPointer+ constant -2
  96 ;testSleep.j(42)     //println("sleeping 0.25 second (static final byte) :");
  97 ;testSleep.j(43)     //sleep(VALUE);
  98 ;testSleep.j(44)     println("sleeping 10 second (static final word):");
  99 acc16= stringconstant 137
 100 writeLineString
 101 ;testSleep.j(45)     sleep(BIG_VALUE);
 102 acc16= constant 10000
 103 <acc16
 104 call 49
 105 stackPointer+ constant -2
 106 ;testSleep.j(46)     //println("sleeping 0.25 second (local byte variable):");
 107 ;testSleep.j(47)     //sleep(localByte);
 108 ;testSleep.j(48)     println("sleeping 10 second (local word variable):");
 109 acc16= stringconstant 138
 110 writeLineString
 111 ;testSleep.j(49)     sleep(localWord);
 112 acc16= (basePointer + 3)
 113 <acc16
 114 call 49
 115 stackPointer+ constant -2
 116 ;testSleep.j(50)     //println("sleeping 0.25 second (static byte):");
 117 ;testSleep.j(51)     //sleep(globalByte);
 118 ;testSleep.j(52)     println("sleeping 10 second (static word):");
 119 acc16= stringconstant 139
 120 writeLineString
 121 ;testSleep.j(53)     sleep(globalWord);
 122 acc16= word variable 4
 123 <acc16
 124 call 49
 125 stackPointer+ constant -2
 126 ;testSleep.j(54)   
 127 ;testSleep.j(55)     println("Klaar");
 128 acc16= stringconstant 140
 129 writeLineString
 130 ;testSleep.j(56)   }
 131 stackPointer= basePointer
 132 basePointer<
 133 return
 134 ;testSleep.j(57) 
 135 ;testSleep.j(58) }
 136 stringConstant 0 = "sleeping 10 second (word constant):"
 137 stringConstant 1 = "sleeping 10 second (static final word):"
 138 stringConstant 2 = "sleeping 10 second (local word variable):"
 139 stringConstant 3 = "sleeping 10 second (static word):"
 140 stringConstant 4 = "Klaar"
