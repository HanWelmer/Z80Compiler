  0 ;test.p(0) /*
  1 ;test.p(1)  * A small program in the miniJava language.
  2 ;test.p(2)  * Test comparisons
  3 ;test.p(3)  */
  4 ;test.p(4) class TestIf {
  5 ;test.p(5)   int zero = 0;
  6 acc8= constant 0
  7 acc8ToAcc16
  8 acc16=> variable 0          var0=0
  9 ;test.p(6)   int one = 1;
 10 acc8= constant 1
 11 acc8ToAcc16
 12 acc16=> variable 2          var0=0  var2=1
 13 ;test.p(7)   int four = 4;
 14 acc8= constant 4
 15 acc8ToAcc16
 16 acc16=> variable 4          var0=0  var2=1  var4=4
 17 ;test.p(8)   int twelve = 12;
 18 acc8= constant 12
 19 acc8ToAcc16
 20 acc16=> variable 6          var0=0  var2=1  var4=4  var6=12
 21 ;test.p(9)   write(3);
 22 acc8= constant 3
 23 call writeAcc8
 24 ;test.p(10)   if (4 == (zero + twelve/(1+2))) write(2);
 25 acc8= constant 4        var0=0  var2=1  var4=4  var6=12 acc8=4
 26 acc16= variable 0       var0=0  var2=1  var4=4  var6=12 acc8=4  acc16=0
 27 <acc16= variable 6      var0=0  var2=1  var4=4  var6=12 acc8=4  acc16=12 stack=[int0]
 28 <acc8= constant 1       var0=0  var2=1  var4=4  var6=12 acc8=1  acc16=12 stack=[int0, byte4]
 29 acc8+ constant 2        var0=0  var2=1  var4=4  var6=12 acc8=3  acc16=12 stack=[int0, byte4]
 30 acc16/ acc8             var0=0  var2=1  var4=4  var6=12 acc8=3  acc16=4  stack=[int0, byte4]
 31 acc16+ unstack16        var0=0  var2=1  var4=4  var6=12 acc8=3  acc16=4  stack=[int0, byte4] -> fout. unstack16 terwijl TOS een byte is.
 32 revAcc16Comp unstack8
 33 brne 37
 34 acc8= constant 2
 35 call writeAcc8
 36 ;test.p(11)   if (four == (0 + 12/(one+2))) write(1);
 37 acc16= variable 4
 38 acc8= constant 0
 39 <acc8= constant 12
 40 <acc16= variable 2
 41 acc16+ constant 2
 42 /acc16 acc8
 43 acc16+ acc8
 44 revAcc16Comp unstack16
 45 brne 49
 46 acc8= constant 1
 47 call writeAcc8
 48 ;test.p(12)   write(0);
 49 acc8= constant 0
 50 call writeAcc8
 51 ;test.p(13) }
 52 stop
