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

package com.github.hanwelmer;

/**
 * This class defines the type of operands used by the instructions of the M
 * machine as generated by the P language. Used in the code generation phase of
 * the compiler.
 * 
 * The memory address of a GLOBAL_VARariable is an absolute address. The memory
 * address of a LOCAL_VARariable is the base pointer plus index (negative value
 * for local variables, positive value for formal parameters).
 */

public enum OperandType {
  UNKNOWN, STACK8, STACK16, STACK_POINTER, CONSTANT, GLOBAL_VAR, LOCAL_VAR, LABEL, ACC;
};
