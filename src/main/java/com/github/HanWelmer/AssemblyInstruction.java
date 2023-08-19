/*
Copyright © 2023 Han Welmer.

This file is part of Z80Compiler.

Z80Compiler is free software: you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free Software 
Foundation, either version 3 of the License, or (at your option) any later 
version.

Z80Compiler is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with 
Z80Compiler. If not, see <https://www.gnu.org/licenses/>.
*/

package com.github.HanWelmer;

import java.util.ArrayList;

/*
* This class implements a single line of assembly code
*/
public class AssemblyInstruction {

  private String code; /* assembler code */
  private int address; /* start address of the assembled instruction. */
  private ArrayList<Byte> bytes; /*
                                  * assembler instruction coded as an array of
                                  * bytes.
                                  */

  /* constructor */
  public AssemblyInstruction(int address, String code, int... bytes) {
    this.address = address;
    this.code = code;
    if (bytes != null && bytes.length > 0) {
      this.bytes = new ArrayList<Byte>(bytes.length);
    }
    for (int newByte : bytes) {
      this.bytes.add((byte) newByte);
    }
  }

  public String getCode() {
    return code;
  }

  public int getAddress() {
    return address;
  }

  public ArrayList<Byte> getBytes() {
    return bytes;
  }

}