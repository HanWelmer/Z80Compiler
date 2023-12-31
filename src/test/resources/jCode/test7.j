/*
 * A small program in the miniJava language.
 * Test 8-bit and 16-bit expressions.
 */
class Test8And16BitExpressions {
  byte b;
  word i;
  public static void main() {
    println(0);
  
    /**************************/
    /* Single term read: byte */
    /**************************/
    println(1);          // 1
  
    println("\nType 2, 3, 4 etc");
    println(read);       // 2
    b = read;
    println(b);       // 3
  
    /**********************************/
    /* Dual term read: byte constants */
    /**********************************/
    println(read + 0);   // 4 + 0 = 4
    println(0 + read);   // 0 + 5 = 5
    println(read - 0);   // 6 - 0 = 6
    println(14 - read);  // 14 - 7 = 7
    println(read * 1);   // 8 * 1 = 8
    println(1 * read);   // 1 * 9 = 9
    println(read / 1);   // 10 / 1 = 10
    println(121 / read); // 121 / 11 = 11
    
    println("\nType 1048 etc");
    /**************************/
    /* Single term read: word */
    /**************************/
    println(read);      // 1048
    i = read;
    println(i);         // 1049
  
    /**********************************/
    /* Dual term read: word constants */
    /**********************************/
    println("\nType 1050 expect 2050");
    println(read + 1000);   // 1050 + 1000 = 2050
    println("\nType 1051 expect 2051");
    println(1000 + read);   // 1000 + 1051 = 2051
    println("\nType 1052 expect 52");
    println(read - 1000);   // 1052 - 1000 =   52
    println("\nType 1053 expect 1053");
    println(2106 - read);   // 2106 - 1053 = 1053
    println("\nType 1054 expect 5254");
    println(read * 1000);   // 1054 * 1000 = 5254
    println("\nType 1055 expect 6424");
    println(1000 * read);   // 1000 * 1055 = 1.055.000 = 6424
    println("\nType 1056 expect 1");
    println(read / 1000);   // 1056 / 1000 = 1
    println("\nType 1057 expect 2");
    println(2114 / read);   // 2114 / 1057 = 2
    
    /****************************************/
    /* Dual term read: word + byte variable */
    /****************************************/
    println("\nType 1058 etc");
    b = 0;
    println(read + b);   // 1058 + 0 = 1058
    println(b + read);   // 0 + 1059 = 1059
    println(read - b);   // 1060 - 0 = 1060
    println("\nType 1061 expect -1061");
    println(b - read);   // 0 - 1061 = -1061
    b = 1;
    println("\nType 1062 etc");
    println(read * b);   // 1062 * 1 = 1062
    println(b * read);   // 1 * 1063 = 1063
    println(read / b);   // 1064 / 1 = 1064
    b = 12;
    println("\nType 3 expect 4");
    println(3);
    println(b / read);   // 12 / 3 = 4
    
    /****************************************/
    /* Dual term read: word + word variable */
    /****************************************/
    i = 0;
    println("\nType 1066 etc");
    println(read + i);   // 1066 + 0 = 1066
    println(i + read);   // 0 + 1067 = 1067
    println(read - i);   // 1068 - 0 = 1068
    println("\nType 1069 expect -1069");
    println(i - read);   // 0 - 1069 = -1069
    i = 1;
    println("\nType 1070 etc");
    println(read * i);   // 1070 * 1 = 1070
    println(i * read);   // 1 * 1071 = 1071
    println(read / i);   // 1072 / 1 = 1072
    i = 3219;
    println("\nType 3 expect 1073");
    println(i / read);   // 3219 / 3 = 1073  
    println("Klaar");
  }
}
