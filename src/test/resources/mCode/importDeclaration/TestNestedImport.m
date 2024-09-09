   0 call 13
   1 stop
   2 ;TestNestedImport.j(0) /*
   3 ;TestNestedImport.j(1)  * A small program in the miniJava language.
   4 ;TestNestedImport.j(2)  * Test something
   5 ;TestNestedImport.j(3)  */
   6 ;TestNestedImport.j(4) import ImportLevel1Class1;
   7 import ImportLevel1Class1
   8 ;ImportLevel1Class1.j(0) import ImportLevel2Class1;
   9 import ImportLevel2Class1
  10 ;ImportLevel2Class1.j(0) class ImportLevel2Class1 {
  11 class ImportLevel2Class1 []
  12 ;ImportLevel2Class1.j(1)   private static String str = "Level 2 class 1";
  13 acc16= stringconstant 168
  14 acc16=> variable 0
  15 br 35
  16 ;ImportLevel2Class1.j(2)   
  17 ;ImportLevel2Class1.j(3)   public static void doIt() {
  18 method ImportLevel2Class1.doIt [public, static] void ()
  19 <basePointer
  20 basePointer= stackPointer
  21 stackPointer+ constant 0
  22 ;ImportLevel2Class1.j(4)     println(str);
  23 acc16= variable 0
  24 writeLineString
  25 ;ImportLevel2Class1.j(5)   }
  26 stackPointer= basePointer
  27 basePointer<
  28 return
  29 ;ImportLevel2Class1.j(6) }
  30 ;ImportLevel1Class1.j(1) import ImportLevel2Class2;
  31 import ImportLevel2Class2
  32 ;ImportLevel2Class2.j(0) class ImportLevel2Class2 {
  33 class ImportLevel2Class2 []
  34 ;ImportLevel2Class2.j(1)   private static String str = "Level 2 class 2";
  35 acc16= stringconstant 169
  36 acc16=> variable 2
  37 br 56
  38 ;ImportLevel2Class2.j(2)   
  39 ;ImportLevel2Class2.j(3)   public static void doIt() {
  40 method ImportLevel2Class2.doIt [public, static] void ()
  41 <basePointer
  42 basePointer= stackPointer
  43 stackPointer+ constant 0
  44 ;ImportLevel2Class2.j(4)     println(str);
  45 acc16= variable 2
  46 writeLineString
  47 ;ImportLevel2Class2.j(5)   }
  48 stackPointer= basePointer
  49 basePointer<
  50 return
  51 ;ImportLevel2Class2.j(6) }
  52 ;ImportLevel1Class1.j(2) 
  53 ;ImportLevel1Class1.j(3) class ImportLevel1Class1 {
  54 class ImportLevel1Class1 []
  55 ;ImportLevel1Class1.j(4)   private static String str = "Level 1 class 1";
  56 acc16= stringconstant 170
  57 acc16=> variable 4
  58 br 84
  59 ;ImportLevel1Class1.j(5)   
  60 ;ImportLevel1Class1.j(6)   public static void doIt() {
  61 method ImportLevel1Class1.doIt [public, static] void ()
  62 <basePointer
  63 basePointer= stackPointer
  64 stackPointer+ constant 0
  65 ;ImportLevel1Class1.j(7)     println(str);
  66 acc16= variable 4
  67 writeLineString
  68 ;ImportLevel1Class1.j(8)     ImportLevel2Class1.doIt();
  69 call 18
  70 ;ImportLevel1Class1.j(9)     ImportLevel2Class2.doIt();
  71 call 40
  72 ;ImportLevel1Class1.j(10)   }
  73 stackPointer= basePointer
  74 basePointer<
  75 return
  76 ;ImportLevel1Class1.j(11) }
  77 ;TestNestedImport.j(5) import ImportLevel1Class2;
  78 import ImportLevel1Class2
  79 ;ImportLevel1Class2.j(0) import ImportLevel2Class3;
  80 import ImportLevel2Class3
  81 ;ImportLevel2Class3.j(0) class ImportLevel2Class3 {
  82 class ImportLevel2Class3 []
  83 ;ImportLevel2Class3.j(1)   private static String str = "Level 2 class 3";
  84 acc16= stringconstant 171
  85 acc16=> variable 6
  86 br 106
  87 ;ImportLevel2Class3.j(2)   
  88 ;ImportLevel2Class3.j(3)   public static void doIt() {
  89 method ImportLevel2Class3.doIt [public, static] void ()
  90 <basePointer
  91 basePointer= stackPointer
  92 stackPointer+ constant 0
  93 ;ImportLevel2Class3.j(4)     println(str);
  94 acc16= variable 6
  95 writeLineString
  96 ;ImportLevel2Class3.j(5)   }
  97 stackPointer= basePointer
  98 basePointer<
  99 return
 100 ;ImportLevel2Class3.j(6) }
 101 ;ImportLevel1Class2.j(1) import ImportLevel2Class4;
 102 import ImportLevel2Class4
 103 ;ImportLevel2Class4.j(0) class ImportLevel2Class4 {
 104 class ImportLevel2Class4 []
 105 ;ImportLevel2Class4.j(1)   private static String str = "Level 2 class 4";
 106 acc16= stringconstant 172
 107 acc16=> variable 8
 108 br 127
 109 ;ImportLevel2Class4.j(2)   
 110 ;ImportLevel2Class4.j(3)   public static void doIt() {
 111 method ImportLevel2Class4.doIt [public, static] void ()
 112 <basePointer
 113 basePointer= stackPointer
 114 stackPointer+ constant 0
 115 ;ImportLevel2Class4.j(4)     println(str);
 116 acc16= variable 8
 117 writeLineString
 118 ;ImportLevel2Class4.j(5)   }
 119 stackPointer= basePointer
 120 basePointer<
 121 return
 122 ;ImportLevel2Class4.j(6) }
 123 ;ImportLevel1Class2.j(2) 
 124 ;ImportLevel1Class2.j(3) class ImportLevel1Class2 {
 125 class ImportLevel1Class2 []
 126 ;ImportLevel1Class2.j(4)   private static String str = "Level 1 class 2";
 127 acc16= stringconstant 173
 128 acc16=> variable 10
 129 br 152
 130 ;ImportLevel1Class2.j(5) 
 131 ;ImportLevel1Class2.j(6)   public static void doIt() {
 132 method ImportLevel1Class2.doIt [public, static] void ()
 133 <basePointer
 134 basePointer= stackPointer
 135 stackPointer+ constant 0
 136 ;ImportLevel1Class2.j(7)     println(str);
 137 acc16= variable 10
 138 writeLineString
 139 ;ImportLevel1Class2.j(8)     ImportLevel2Class3.doIt();
 140 call 89
 141 ;ImportLevel1Class2.j(9)     ImportLevel2Class4.doIt();
 142 call 111
 143 ;ImportLevel1Class2.j(10)   }
 144 stackPointer= basePointer
 145 basePointer<
 146 return
 147 ;ImportLevel1Class2.j(11) }
 148 ;TestNestedImport.j(6) 
 149 ;TestNestedImport.j(7) class TestNestedImport {
 150 class TestNestedImport []
 151 ;TestNestedImport.j(8)   public static void main() {
 152 method TestNestedImport.main [public, static] void ()
 153 <basePointer
 154 basePointer= stackPointer
 155 stackPointer+ constant 0
 156 ;TestNestedImport.j(9)     ImportLevel1Class1.doIt();
 157 call 61
 158 ;TestNestedImport.j(10)     ImportLevel1Class2.doIt();
 159 call 132
 160 ;TestNestedImport.j(11)     println("TestNestedImport Klaar");
 161 acc16= stringconstant 174
 162 writeLineString
 163 ;TestNestedImport.j(12)   }
 164 stackPointer= basePointer
 165 basePointer<
 166 return
 167 ;TestNestedImport.j(13) }
 168 stringConstant 0 = "Level 2 class 1"
 169 stringConstant 1 = "Level 2 class 2"
 170 stringConstant 2 = "Level 1 class 1"
 171 stringConstant 3 = "Level 2 class 3"
 172 stringConstant 4 = "Level 2 class 4"
 173 stringConstant 5 = "Level 1 class 2"
 174 stringConstant 6 = "TestNestedImport Klaar"
