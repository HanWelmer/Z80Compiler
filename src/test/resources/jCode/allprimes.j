// Print prime numbers less than 100.
class AllPrimes {
  private static byte T; // test result; 1 if prime, 0 if not.
  private static byte P; // prime to be tested.
  private static byte D; // divisor.
  private static byte M; // max prime to be tested.
  
  public static void main() {
    M = 100;

    println(1);
    println(2);
    P = 3;
    while (P < M) {
      D = 2;
      T = 1;
      while (D + D <= P) {
        if (P / D * D == P) {
          T = 0;
        }
        D = D + 1;
      }
      if (T == 1) {
          println(P);
      }
      P = P + 1;
    }
  }
}
