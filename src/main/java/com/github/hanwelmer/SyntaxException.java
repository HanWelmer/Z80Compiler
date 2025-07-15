package com.github.hanwelmer;

/**
 * This class defines the exception for a recoverable syntax error, thrown
 * during lexical analysis or semantic analysis phases of the compiler.
 */
public class SyntaxException extends Exception {

  private static final long serialVersionUID = -4262396286684934106L;

  public SyntaxException(String message) {
    super(message);
  }

}
