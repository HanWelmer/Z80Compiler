/*
 * A small program in the miniJava language.
 * Test comparisons
 */
class TestComparison {
  if (1 == 1) write(12);
  if (1 == 1) { 
    write(11);
  } else { 
    write (0);
  }
  if (1 == 0) { 
    write(0);
  } else { 
    write (10);
  }
  if (1 != 0) write(9);
  if (1 != 0) { 
    write(8);
  } else { 
    write (0);
  }
  if (1 != 1) { 
    write(0);
  } else { 
    write (7);
  }
  if (1 > 0) write(6);
  if (1 >= 0) write(5);
  if (1 >= 1) write(4);
  if (0 < 1) write(3);
  if (0 <= 1) write(2);
  if (1 <= 1) write(1);
  write(0);
}
//comment after final }.