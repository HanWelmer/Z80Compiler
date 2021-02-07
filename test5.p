/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestComparison {
  if (5 > 12/(1+2)) write(19);   //19
  if (4 >= 12/(1+2)) write(18);  //18
  if (1 != 12/(1+2)) write(17);  //17
  if (4 == 12/(1+2)) write(16);   //16
  if (4 <= 12/(1+2)) write(15);  //15
  if (1 < 12/(1+2)) write(14);   //14
  if (1 <= 1) write(13);  //13
  if (0 <= 1) write(12);  //12
  if (0 < 1) write(11);   //11
  if (1 >= 1) write(10);  //10
  if (1 >= 0) write(9);   //9
  if (1 > 0) write(8);    //8
  if (1 != 1) { 
    write(0);
  } else { 
    write (7);            //7
  }
  if (1 != 0) { 
    write(6);             //6
  } else { 
    write (0);
  }
  if (1 != 0) write(5);   //5
  if (1 == 0) { 
    write(0);
  } else { 
    write (4);            //4
  }
  if (1 == 1) { 
    write(3);             //3
  } else { 
    write (0);
  }
  if (1000 == 1000) write(2);  //2
  if (1 == 1) write(1);   //1
  write(0);               //0
}
//comment after final }.
