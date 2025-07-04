SOC     equ 02000H        ;start of code, i.e.lowest external RAM address.
TOS     equ 0FD00H        ;top of stack, i.e. bottom of MONITOR user global data.
        .ORG  SOC
start:
        LD    SP,TOS
L0:
        CALL  L223
L1:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2:
        ;;ledtst.j(0) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
L3:
        ;;ledtst.j(1) /* Transcribed from LEDTest.asm to ledtest.j */
L4:
        ;;ledtst.j(2) 
L5:
        ;;ledtst.j(3) import Thread;
L6:
L7:
        ;;Thread.j(0) 
L8:
        ;;Thread.j(1) /* Z80S183 program that tests switching on/off the LED at the PWRSWTCH  output. */
L9:
        ;;Thread.j(2) /* Transcribed from LEDTest.asm to ledtest.j */
L10:
        ;;Thread.j(3) 
L11:
        ;;Thread.j(4) class Thread {
L12:
        ;class Thread []
L13:
        ;;Thread.j(5) 
L14:
        ;;Thread.j(6)   /**
L15:
        ;;Thread.j(7)    * Wait 1 msec at 18,432 MHz with no wait states.
L16:
        ;;Thread.j(8)    * 
L17:
        ;;Thread.j(9)    * Assumes that code can be run from internal RAM with 1 wait state.
L18:
        ;;Thread.j(10)    * Assumes data can be read/written to internal RAM with 1 wait state.
L19:
        ;;Thread.j(11)    * Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
L20:
        ;;Thread.j(12)    * 
L21:
        ;;Thread.j(13)    * With b=255 the routine requires 108 + b * 71 = 18213 T-states, 
L22:
        ;;Thread.j(14)    * which is 219 T-states or 11,8 microseconds short of 1 millisecond.
L23:
        ;;Thread.j(15)    * 
L24:
        ;;Thread.j(16)    * Duplicating the for loop with a total of 257 for b and c 
L25:
        ;;Thread.j(17)    * requires 132 + (b + c) * 71 = 18379 T-states,
L26:
        ;;Thread.j(18)    * which is 53 T-states or 2,8 microseconds short of 1 millisecond.
L27:
        ;;Thread.j(19)    */
L28:
        ;;Thread.j(20)   private static void sleepOneMillisecond() {
L29:
        ;method Thread.sleepOneMillisecond [private, static] void ()
L30:
        PUSH  IX
L31:
        LD    IX,0x0000
        ADD   IX,SP
L32:
        DEC   SP
L33:
        ;;Thread.j(21)     for (byte b = 255; b!=0; b--) ;
L34:
        LD    A,255
L35:
        LD    (IX - 1),A
L36:
        LD    A,(IX - 1)
L37:
        SUB   A,0
L38:
        JP    Z,L44
L39:
        JP    L42
L40:
        DEC   (IX - 1)
L41:
        JP    L36
L42:
        JP    L40
L43:
        ;;Thread.j(22)   }
L44:
        LD    SP,IX
L45:
        POP   IX
L46:
        return
L47:
        ;;Thread.j(23) 
L48:
        ;;Thread.j(24)   /**
L49:
        ;;Thread.j(25)    * sleep for n miliseconds.
L50:
        ;;Thread.j(26)    */
L51:
        ;;Thread.j(27)   public static void sleep(word n) {
L52:
        ;method Thread.sleep [public, static] void (word n {bp+0})
L53:
        PUSH  IX
L54:
        LD    IX,0x0000
        ADD   IX,SP
L55:
L56:
        ;;Thread.j(28)     while (n != 0) {
L57:
        LD    L,(IX + 4)
        LD    H,(IX + 5)
L58:
        LD    A,0
L59:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L60:
        JP    Z,L68
L61:
        ;;Thread.j(29)       sleepOneMillisecond();
L62:
        CALL  L29
L63:
        ;;Thread.j(30)       n--;
L64:
        LD    L,(IX + 4)
        LD    H,(IX + 5)
        DEC   HL
        LD    (IX + 4),L
        LD    (IX + 5),H
L65:
        ;;Thread.j(31)     }
L66:
        JP    L57
L67:
        ;;Thread.j(32)   }
L68:
        LD    SP,IX
L69:
        POP   IX
L70:
        return
L71:
        ;;Thread.j(33) 
L72:
        ;;Thread.j(34) }
L73:
        ;;ledtst.j(4) 
L74:
        ;;ledtst.j(5) class LEDTest {
L75:
        ;class LEDTest []
L76:
        ;;ledtst.j(6)   /*******************************
L77:
        ;;ledtst.j(7)   To compile this class and generate Z80 asm, listing and hex files:
L78:
        ;;ledtst.j(8)   - cd src\test\resources\jCode\ledtest\5_ImportThread
L79:
        ;;ledtst.j(9)   - java -jar ..\..\..\..\..\..\target\z80Compiler-1.0-SNAPSHOT.jar -z -b ledtst.j
L80:
        ;;ledtst.j(10)   Assumes that code can be run from internal RAM with 1 wait state.
L81:
        ;;ledtst.j(11)   Assumes data can be read/written to internal RAM with 1 wait state.
L82:
        ;;ledtst.j(12)   Assumes the Z80S183 is driven by an 18.432 MHz clock at the XTAL pin
L83:
        ;;ledtst.j(13)   Assumes that an active-low LED is available at the PWRSWTCH pin:
L84:
        ;;ledtst.j(14)    - connect anode of low-current (2 mA) LED to VCC
L85:
        ;;ledtst.j(15)    - connect cathode of low-current LED to 1k8 resistor
L86:
        ;;ledtst.j(16)    - connect other end of resistor to PWR_SW (pin 13 of J23).
L87:
        ;;ledtst.j(17)   
L88:
        ;;ledtst.j(18)   Connect Z80S183 evaluation board via DB9 (male-female) cable to RS232 of host computer.
L89:
        ;;ledtst.j(19)   Start hyperterminal or TeraTerm:
L90:
        ;;ledtst.j(20)    - Select serial communication using COM1
L91:
        ;;ledtst.j(21)    - Set up | Serial port
L92:
        ;;ledtst.j(22)      * COM1
L93:
        ;;ledtst.j(23)      * 57600
L94:
        ;;ledtst.j(24)      * 8N2
L95:
        ;;ledtst.j(25)      * no flow control
L96:
        ;;ledtst.j(26)    - connect 9V DC adapter to Z80S183 evaluation board.
L97:
        ;;ledtst.j(27)    - Press RESET on Z80S183 evaluation board
L98:
        ;;ledtst.j(28)      The text Zilog Z80183 Monitor Version 2.8 should appear.
L99:
        ;;ledtst.j(29)   Upload Intel hex file ledtst.hex:
L100:
        ;;ledtst.j(30)    -  type L
L101:
        ;;ledtst.j(31)    -  File | Send file
L102:
        ;;ledtst.j(32)       * Browse to file ledtst.hex and select OK
L103:
        ;;ledtst.j(33)       * The text 10(10) records in Hex file should appear
L104:
        ;;ledtst.j(34)   Check memory contents:
L105:
        ;;ledtst.j(35)    -  D 2000 32
L106:
        ;;ledtst.j(36)   Run program
L107:
        ;;ledtst.j(37)    -  G 2000
L108:
        ;;ledtst.j(38)    - The LED should blink at a rate of 1Hz.
L109:
        ;;ledtst.j(39)   *******************************/
L110:
        ;;ledtst.j(40) 
L111:
        ;;ledtst.j(41)   // Definition of on-chip Z80S183 registers
L112:
        ;;ledtst.j(42)   //                Name  Address  Description
L113:
        ;;ledtst.j(43)   //                ====  =======  =========
L114:
        ;;ledtst.j(44)   static final byte WDTCR = 0x65;  //Watchdog Timer Control Register
L115:
        ;;ledtst.j(45)   static final byte SCR   = 0x7F;  //System Configuration Register P91
L116:
        ;;ledtst.j(46)   static final byte CCR   = 0x1F;  //CPU Control Register P84
L117:
        ;;ledtst.j(47)   static final byte DCNTL = 0x32;  //DMA/Wait Control Register P121
L118:
        ;;ledtst.j(48)   static final byte WSGCR = 0x6B;  //Wait State Generator Control Register P96
L119:
        ;;ledtst.j(49)   static final byte PCR   = 0x7E;  //Power Control Register
L120:
        ;;ledtst.j(50) 
L121:
        ;;ledtst.j(51)   //Device initialisation
L122:
        ;;ledtst.j(52)   public static void init() {
L123:
        ;method LEDTest.init [public, static] void ()
L124:
        PUSH  IX
L125:
        LD    IX,0x0000
        ADD   IX,SP
L126:
L127:
        ;;ledtst.j(53)     // Enable writing to system ctrl registers
L128:
        ;;ledtst.j(54)     output(WDTCR, 0x00);
L129:
        LD    A,0
        OUT0  (065H),A
L130:
        ;;ledtst.j(55)     // LD      A,00BH
L131:
        ;;ledtst.j(56)     // OUT0    (WDTCR),A
L132:
        ;;ledtst.j(57) 
L133:
        ;;ledtst.j(58)     // System configuration Register P91
L134:
        ;;ledtst.j(59)     // b7 = 0 on-chip ROM disabled
L135:
        ;;ledtst.j(60)     // b6 = 1 on-chip RAM enabled
L136:
        ;;ledtst.j(61)     // b5 = 0 on-chip RAM at xF800H-xFFFFH
L137:
        ;;ledtst.j(62)     // b4 = 1 ROMCS enabled/disabled
L138:
        ;;ledtst.j(63)     // b3 = 1 RAMCS enabled/disabled
L139:
        ;;ledtst.j(64)     // b2 = 1 IOCS  enabled/disabled
L140:
        ;;ledtst.j(65)     // b10=00 PHI = EXTAL clock
L141:
        ;;ledtst.j(66)     output(SCR, 0x5C);
L142:
        LD    A,92
        OUT0  (07FH),A
L143:
        ;;ledtst.j(67)     // LD      A,05CH
L144:
        ;;ledtst.j(68)     // OUT0    (SCR),A
L145:
        ;;ledtst.j(69)   
L146:
        ;;ledtst.j(70)     // CPU Control Register P84
L147:
        ;;ledtst.j(71)     // b7 = 1 PHI = XTAL / 1
L148:
        ;;ledtst.j(72)     // b63=00 SLP instruction enters sleep mode
L149:
        ;;ledtst.j(73)     // b5 = 0 BREQ in standby ignored
L150:
        ;;ledtst.j(74)     // b4 = 0 PHI low noise disabled
L151:
        ;;ledtst.j(75)     // b2 = x reserved
L152:
        ;;ledtst.j(76)     // b1 = 0 IORD/IOWR low noise disabled
L153:
        ;;ledtst.j(77)     // b0 = 0 A19-0/D7-0 low noise disabled
L154:
        ;;ledtst.j(78)     output(CCR, 0x80);    
L155:
        LD    A,128
        OUT0  (01FH),A
L156:
        ;;ledtst.j(79)     // LD      A,080H
L157:
        ;;ledtst.j(80)     // OUT0    (CCR),A
L158:
        ;;ledtst.j(81) 
L159:
        ;;ledtst.j(82)     
L160:
        ;;ledtst.j(83)     // DMA/Wait Control Register P121
L161:
        ;;ledtst.j(84)     // b76=00 0 wait state CPU memory cycle
L162:
        ;;ledtst.j(85)     // b54=00 0 wait state CPU I/O cycle
L163:
        ;;ledtst.j(86)     // b3 = 0 level detect on DMA1 Request
L164:
        ;;ledtst.j(87)     // b2 = 0 level detect on DMA0 Request
L165:
        ;;ledtst.j(88)     // b1 = 0 DMA from memory to I/O 
L166:
        ;;ledtst.j(89)     // b0 = 0 DMA increasing memory address
L167:
        ;;ledtst.j(90)     output(DCNTL, 0x00);
L168:
        LD    A,0
        OUT0  (032H),A
L169:
        ;;ledtst.j(91)     // XOR      A
L170:
        ;;ledtst.j(92)     // OUT0    (DCNTL),A
L171:
        ;;ledtst.j(93) 
L172:
        ;;ledtst.j(94)     // Wait State Generator Control Register P96
L173:
        ;;ledtst.j(95)     // b76=00 0 wait states CSROM
L174:
        ;;ledtst.j(96)     // b54=00 0 wait states CSRAM
L175:
        ;;ledtst.j(97)     // b32=00 0 wait states other
L176:
        ;;ledtst.j(98)     // b10=xx reserved
L177:
        ;;ledtst.j(99)     output(WSGCR, 0x00);
L178:
        LD    A,0
        OUT0  (06BH),A
L179:
        ;;ledtst.j(100)     // OUT0    (WSGCR),A
L180:
        ;;ledtst.j(101) 
L181:
        ;;ledtst.j(102)     // Block writing to system ctrl registers
L182:
        ;;ledtst.j(103)     output(WDTCR, 0x00);
L183:
        LD    A,0
        OUT0  (065H),A
L184:
        ;;ledtst.j(104)     // XOR     A
L185:
        ;;ledtst.j(105)     // OUT0    (WDTCR),A
L186:
        ;;ledtst.j(106)   }
L187:
        LD    SP,IX
L188:
        POP   IX
L189:
        return
L190:
        ;;ledtst.j(107) 
L191:
        ;;ledtst.j(108)   public static void toggle() {
L192:
        ;method LEDTest.toggle [public, static] void ()
L193:
        PUSH  IX
L194:
        LD    IX,0x0000
        ADD   IX,SP
L195:
L196:
        ;;ledtst.j(109)     // Enable writing to PCR
L197:
        ;;ledtst.j(110)     output(WDTCR, 0x0B);
L198:
        LD    A,11
        OUT0  (065H),A
L199:
        ;;ledtst.j(111)     //LD      A,00BH
L200:
        ;;ledtst.j(112)     //OUT0    (WDTCR),A
L201:
        ;;ledtst.j(113) 
L202:
        ;;ledtst.j(114)     // Toggle LED at PWR_SW
L203:
        ;;ledtst.j(115)     output(PCR, input(PCR) ^ 0x20);
L204:
        IN0  A,(07EH)
L205:
        XOR   A,32
L206:
        OUT0  (07EH),A
L207:
        ;;ledtst.j(116)     //IN0     A,(PCR)
L208:
        ;;ledtst.j(117)     //XOR     A,020H
L209:
        ;;ledtst.j(118)     //OUT0    (PCR),A
L210:
        ;;ledtst.j(119) 
L211:
        ;;ledtst.j(120)     // Disable writing to PCR
L212:
        ;;ledtst.j(121)     output(WDTCR, 0x00);
L213:
        LD    A,0
        OUT0  (065H),A
L214:
        ;;ledtst.j(122)     //XOR     A,A
L215:
        ;;ledtst.j(123)     //OUT0    (WDTCR),A
L216:
        ;;ledtst.j(124)   }
L217:
        LD    SP,IX
L218:
        POP   IX
L219:
        return
L220:
        ;;ledtst.j(125) 
L221:
        ;;ledtst.j(126)   // Blink LED on/off in a XXxxXXxx pattern at 1 Hz.
L222:
        ;;ledtst.j(127)   public static void main() {
L223:
        ;method LEDTest.main [public, static] void ()
L224:
        PUSH  IX
L225:
        LD    IX,0x0000
        ADD   IX,SP
L226:
L227:
        ;;ledtst.j(128)     init();
L228:
        CALL  L123
L229:
        ;;ledtst.j(129)     while (1==1) {
L230:
        LD    A,1
L231:
        SUB   A,1
L232:
        JP    NZ,L243
L233:
        ;;ledtst.j(130)       toggle();
L234:
        CALL  L192
L235:
        ;;ledtst.j(131)       Thread.sleep(500); // Sleep for 500 miliseconds.
L236:
        LD    HL,500
L237:
        PUSH HL
L238:
        CALL  L52
L239:
        INC   SP
        INC   SP
L240:
        ;;ledtst.j(132)     }
L241:
        JP    L230
L242:
        ;;ledtst.j(133)   }
L243:
        LD    SP,IX
L244:
        POP   IX
L245:
        return
L246:
        ;;ledtst.j(134) }
CNTLA0  equ 000H          ;144 ASCI0 Control Register A.
STAT0   equ 004H          ;147 ASCI0 Status register.
TDR0    equ 006H          ;148 ASCI0 Transmit Data Register.
RDR0    equ 008H          ;149 ASCI0 Receive Data Register.
ERROR   equ 3             ;CNTLA0->OVRN,FE,PE,BRK error flags.
TDRE    equ 1             ;STAT0->Tx data register empty bit.
OVERRUN equ 6             ;STAT0->OVERRUN bit.
RDRF    equ 7             ;STAT0->Rx data register full bit.
;****************
;getChar
;Check if an input character from ASCI0 is available.
;  IN:  none
;  OUT: F: ZERO flag set if no character is available.
;          ZERO flag reset if a character is available.
;       A : character from ASCI0, if available.
;  USES:AF
;****************
getChar:
        IN0   A,(STAT0)   ;read ASCI0 status
        BIT   OVERRUN,A   ;check if ASCIO OVERRUN bit is set
        JR    NZ,getChar1 ;-yes: reset error flags
        BIT   RDRF,A      ;check if ASCIO RDRF bit is set
        RET   Z           ;-no: return without a character
        IN0   A,(RDR0)    ;-yes:read ASCIO Rx data register
        RET
getChar1:
        IN0   A,(CNTLA0)  ;read ASCI0 control register
        RES   ERROR,A     ;reset OVRN,FE,PE,BRK flags
        OUT0  (CNTLA0),A  ;write back to ASCI0 CTRL
        XOR   A,A
        RET               ;return without a character
;****************
;putMsg
;Print via ASCI0 a zero terminated string, starting at the return address on the stack.
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putMsg:
        EX    (SP),HL     ;save HL and load return address into HL.
        CALL  writeStr
        EX    (SP),HL     ;put return address onto stack and restore HL.
        RET
;****************
;writeLineStr
;Print via ASCI0 a zero terminated string, pointed to by HL, followed by a carriage return.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
writeLineStr:
        CALL  writeStr
        CALL  putCRLF
        RET
;****************
;writeStr
;Print via ASCI0 a zero terminated string, pointed to by HL.
;  IN:  HL:address of zero terminated string to be printed.
;  OUT: none.
;  USES:HL (point to byte after zero terminated string)
;****************
writeStr:
        PUSH  AF          ;save registers
putStr1:
        LD    A,(HL)      ;get next character
        INC   HL
        OR    A,A         ;is it zer0?
        JR    Z,putStr2   ;yes ->return
        CALL  putChar     ;no->put it to ASCI0
        JR    putStr1
putStr2:
        POP   AF
        RET
;****************
;putSpace
;Send a space character to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putSpace:
        LD    A,' '       ;load space and continue with putChar.
;****************
;putChar
;Send one character to ASCI0.
;  IN:  A = character
;  OUT: none.
;  USES:none.
;****************
putChar:
        PUSH  AF          ;send the character via ASCI0
putChar1:
        IN0   A,(STAT0)   ;read ASCI0 status register
        BIT   TDRE,A      ;wait until TDRE <> 0
        JR    Z,putChar1
        POP   AF          ;restore AF registers
        OUT0  (TDR0),A    ;write character to ASCI0
        RET
;****************
;putCRLF
;Send CR and LF to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:none.
;****************
putCRLF:
        PUSH  AF
        LD    A,'\r'       ;print carriage return
        CALL  putChar
        LD    A,'\n'       ;print line feed
        CALL  putChar
        POP   AF
        RET
;****************
;putErase
;Erase the latest character at ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putErase:
        LD    A,'\b'       ;print backspace
        CALL  putChar
        CALL  putSpace    ;print space (erase character)
        LD    A,'\b'      ;print backspace
        JR    putChar
;****************
;putBell
;Send a Bell character to ASCI0
;  IN:  none.
;  OUT: none.
;  USES:AF
;****************
putBell:
        LD    A,07        ;ring the bell at ASCI0
        JR    putChar
;****************
;putHexHL
;Print HL register pair as 4 hex digits
;  IN:  HL = word to be printed.
;  OUT: none.
;  USES:none.
;****************
putHexHL:
        PUSH  AF          ;save used registers
        LD    A,H         ;print H as 2 hex digits
        CALL  putHexA
        LD    A,L         ;print L as 2 hex digits
        CALL  putHexA
        POP   AF          ;restore used registers
        RET
;****************
;putHexA
;Print A register as 2 hex digits
;  IN:  A = byte to be printed
;  OUT: none.
;  USES:none.
;****************
putHexA:
        PUSH  AF          ;save input
        RRA               ;shift upper nibble to the right
        RRA
        RRA
        RRA
        CALL  putHexA1    ;print upper nibble
        POP   AF          ;restore input & print lower nibble
putHexA1:
        PUSH  AF          ;save input
        AND   A,00FH      ;mask lower nibble
        ADD   A,'0'       ;convert to hex digit
        CP    A,'9'+1
        JR    C,putHexA2
        ADD   A,07
putHexA2:
        CALL  putChar
        POP   AF          ;restore input
        RET               ;and return
;****************
;mul16
;16 by 16 bit unsigned multiplication with 16 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: HL = HL * DE low part
;  USES:DE
;  Size   25 bytes
;  Time  160 cycles
;****************
mul16:
        ;HL = HL * DE
        ;        H  L
        ;        D  E
        ;    --------*
        ;          EL
        ;       EH  0
        ;       DL  0
        ; -----------+
        ;        R  S
        ;S = ELlow
        ;R = ELhigh+EHlow+DLlow
        PUSH  BC          ;11  11 save BC
        LD    B,H         ; 4  15 copy HL to BC
        LD    C,L         ; 4  19
        LD    H,E         ; 4  23 HL contains EL
        MLT   HL          ;17  40
        PUSH  HL          ;11  51
        LD    H,E         ; 4  55 HL contains EH aka EB
        LD    L,B         ; 4  59
        MLT   HL          ;17  76
        LD    B,L         ; 4  80 save EHlow in B
        LD    H,D         ; 4  84 HL contains DL aka DC
        LD    L,C         ; 4  88
        MLT   HL          ;17 105
        LD    D,L         ; 4 109 DLlow into DE
        LD    E,0         ; 6 115
        POP   HL          ; 9 124 add EL+DElow
        ADD   HL,DE       ; 7 131
        LD    D,B         ; 4 135 add EL+DElow+EHlow
        ADD   HL,DE       ; 7 142
        POP   BC          ; 9 151 restore BC
        RET               ; 9 160
;****************
;mul16_10
;multiply a 16 bit unsigned number by 10 with a 16 bit result.
;  IN:  HL = operand
;  OUT: HL = HL * 10; low part
;  USES:Flags
;  Size   9 bytes
;  Time   65 cycles
;****************
mul16_10:
        PUSH  DE          ;11 11
        LD    D,H         ; 4 15
        LD    E,L         ; 4 19
        ADD   HL,HL       ; 7 26 times 2
        ADD   HL,HL       ; 7 33 times 4
        ADD   HL,DE       ; 7 40 times 5
        ADD   HL,HL       ; 7 47 times 10
        POP   DE          ; 9 56
        RET               ; 9 65
;****************
;mul16_8
;16 by 8 bit unsigned multiplication with 16 bit result.
;  IN:  HL = operand 1
;        A = operand 2
;  OUT: HL = HL * A low part
;  USES:AF
;  Size   .. bytes
;  Time  ... cycles
;****************
mul16_8:
        ;HL = HL * A
        ;        H  L
        ;           A
        ;    --------*
        ;          AL
        ;       AH  0
        ; -----------+
        ;        R  S
        ;S = ALlow
        ;R = ALhigh+AHlow
        PUSH  BC          ;11  11 save BC
        LD    B,H         ; 4  15
        LD    C,A         ; 4  19
        LD    H,A         ; 4  23
        MLT   HL          ;17  40 HL = AL
        MLT   BC          ;17  57 BC = AH
        LD    A,H         ; 4  61 A = S = ALhigh+AHlow
        ADD   A,C         ; 4  65
        LD    H,A         ; 4  69
        POP   BC          ; 9  78 | 289 restore BC
        RET               ; 9  87 | 307
;****************
;mul1632
;16 by 16 bit unsigned multiplication with 32 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: HL = HL * DE low part
;       DE = HL * DE high part
;  USES:-
;  Size 49 bytes
;  Time between 303 en 307 cycles
;****************
mul1632:
        ;HL = HL * DE
        ;        H  L
        ;        D  E
        ;    --------*
        ;          EL
        ;       EH  0
        ;       DL  0
        ;    DH  0  0
        ; -----------+
        ;  P  Q  R  S
        ;S = ELlow
        ;R = ELhigh+EHlow+DLlow
        ;Q = DHlow+EHhigh+DLhigh
        ;P = DHhigh
        PUSH  AF          ;11  11 save AF
        PUSH  BC          ;11  22 save BC
        LD    B,H         ; 4  26
        LD    C,L         ; 4  30
        LD    H,D         ; 4  34 HL contains DH aka DB
        LD    L,B         ; 4  38
        MLT   HL          ;17  55
        PUSH  HL          ;11  66
        LD    H,D         ; 4  70 HL contains DL aka DC
        LD    L,C         ; 4  74
        MLT   HL          ;17  91
        PUSH  HL          ;11 102
        LD    H,E         ; 4 106 HL contains EH aka EB
        LD    L,B         ; 4 110
        MLT   HL          ;17 127
        PUSH  HL          ;11 138
        LD    H,E         ; 4 142 HL contains EL aka EC
        LD    L,C         ; 4 146
        MLT   HL          ;17 163
        POP   DE          ; 9 172 calculate RS=EL+EH0
        LD    B,0         ; 6 178
        LD    C,D         ; 4 182 ..C=EHhigh
        LD    D,E         ; 4 186 ..D=EHlow
        LD    E,0         ; 6 192
        ADD   HL,DE       ; 7 199
        JR    NC,mul16321 ; 8 207 | 6 205 add carry to PQ
        INC   BC          ;         4 209
mul16321:
        POP   DE          ; 9 209 | 211 calculate RS=EL+EH0+DL0
        LD    A,D         ; 4 220 | 222 ..A=DLhigh
        LD    D,E         ; 4 224 | 226 ..D=DLlow
        ADD   HL,DE       ; 7 231 | 233
        JR    NC,mul16322 ; 8 239 | 6 239 add carry to PQ
        INC   BC          ;         4 243
mul16322:
                          ;HL=RS=EL+EH0+DL0
                          ;C=EHhigh
                          ;A=DLhigh
                          ;E=0
        EX    DE,HL       ; 3 242 | 246
        LD    H,L         ; 4 246 | 250 ..E was 0, so H=L=0
        LD    L,A         ; 4 250 | 254 ..HL=DLhigh
        ADD   HL,BC       ; 7 257 | 261 PQ=EHhigh+DLhigh+DH
        POP   BC          ; 9 266 | 270
        ADD   HL,BC       ; 7 273 | 277
        EX    DE,HL       ; 3 276 | 280
                          ;D=P=DHhigh
                          ;E=Q=DHlow+EHhigh+DLhigh
                          ;H=R=ELhigh+EHlow+DLlow
                          ;L=S=ELlow
        POP   BC          ; 9 285 | 289 restore BC
        POP   AF          ; 9 294 | 298 restore AF
        RET               ; 9 303 | 307
;****************
;mul16S
;16 by 16 bit slow unsigned multiplication with 32 bit result.
;  IN:  HL = operand 1
;       DE = operand 2
;  OUT: DE = HL * DE high part
;       HL = HL * DE low part
;  USES:none.
;  Size 26 bytes
;  Time between 726 en 998 cycles
;****************
mul16S:
        PUSH  AF          ;11  11 save AF
        PUSH  BC          ;11  22 save BC
        LD    B,H         ; 4  26
        LD    C,L         ; 4  30
        LD    HL,0        ; 9  39
        LD    A,16        ; 6  45
mul16S1:
        ADD   HL,HL       ;16*7=112 157
        RL    E           ;16*7=112 269
        RL    D           ;16*7=112 381
        JR    NC,mul16S2  ;16*8=128 509 16*6= 96 477
        ADD   HL,BC       ;             16*7=112 589
        JR    NC,mul16S2  ;             16*8=128 717 16*6=96 685
        INC   DE          ;             16*4= 64 781 16*4=64 749 This instruction (with the jump) is like an "ADC DE,0"
mul16S2:
        DEC   A           ;16*4=64    573 | 845 | 813
        JR    NZ,mul16S1  ;15*8+6=126 699 | 971 | 939
        POP   BC          ; 9         708 | 980 | 948 restore BC
        POP   AF          ; 9         717 | 989 | 957 restore AF
        RET               ; 9         726 | 998 | 966
;****************
;div16
;16 by 16 bit unsigned division.
;  IN:  HL = dividend
;       DE = divisor
;  OUT: HL = quotient
;       DE = remainder
;  USES:-
;  Size   32 bytes
;  Time   between 1073 en 1121 cycles
;pseudo code:
;T = AC = dividend
;D = DE = divisor
;Q = AC = quotient = 0
;R = HL = remainder = 0
;invariante betrekking:
; D/T\Q     
;   R       
; T = QD + R
; T <= 2^N  
;
; D/T'.RT\Q'      
;   R'             
; RT <= 2^N        
; 0<=k<=N          
; RT = T % 2^k     
; T' = (T-RT) / 2^k
; Q' = T' / D      
; R' = T' % D      
;
;for (i=16; i>0; i--) {
;  T = T * 2 (remember MSB in carry)
;  R = R * 2 + carry
;  Q = Q * 2
;  if (R >= D) {
;    R = R - D;
;    Q++;
;  }
;}
;return Q (in HL) and R (in DE)
;****************
div16:
        PUSH  AF          ;11  11 save registers used
        PUSH  BC          ;11  22
        LD    C,L         ; 4  26 T(AC) = teller from input (HL)
        LD    A,H         ; 4  30 D(DE) = deler from input  (DE)
        LD    HL,0        ; 9  39 R(HL) = restant; Q(AC) = quotient
        LD    B,16        ; 6  45 for (i=16; i>0; i--)
div16_1:
        SLA   C           ;16* 7=112 157   T = T * 2 (remember MSB in carry)
        RL    A           ;16* 7=112 269   Q = Q * 2
        ADC   HL,HL       ;16*10=160 429   R = R * 2 + carry
        OR    A,A         ;16* 4= 64 493   if (R >= D) {
        SBC   HL,DE       ;16*10=160 653
        JR    C,div16_2   ;16* 8=128 781 16*6= 96 749   R = R - D
        INC   C           ;              16*4= 64 813   Q++
        JR    div16_3     ;              16*8=128 941
div16_2:
        ADD   HL,DE       ;16* 7=112 893  (compensate comparison)
div16_3:
        DJNZ  div16_1     ;15*9+7=142 1035 | 1083 }
        EX    DE,HL       ; 3 1038 | 1086 swap remainder (HL) into DE
        LD    H,A         ; 4 1042 | 1090 move quotient (AC) into HL
        LD    L,C         ; 4 1046 | 1094
        POP   BC          ; 9 1055 | 1103
        POP   AF          ; 9 1064 | 1112
        RET               ; 9 1073 | 1121
;****************
;div16_8
;16 by 8 bit unsigned division.
;  IN:  HL = dividend
;       A  = divisor
;  OUT: HL = quotient
;       A  = remainder
;  USES:F(lags)
;  Size 18 bytes
;  Time between 601 en 697 cycles
;****************
div16_8:
        PUSH  BC          ;11 11 save registers used
        LD    B,16        ; 6 17 the length of the dividend (16 bits)
        LD    C,A         ; 4 21 move divisor to C
        XOR   A,A         ; 4 25 clear upper 8 bits of AHL
div16_82:
        ADD   HL,HL       ;16*7=112 137 advance dividend (HL) into selected bits (A)
        RL    A           ;16*7=112 249
        CP    A,C         ;16*4= 64 313 check if divisor (E) <= selected digits (A)
        JR    C,div16_83  ;16*8=128 441 16*6=96 409 if not, advance without subtraction
        SUB   A,C         ;             16*4=64 473 subtract the divisor
        INC   L           ;             16*4=64 537 and set the next digit of the quotient
div16_83:
        DJNZ  div16_82    ;15*9+7=142 583 679
        POP   BC          ;9 592 688
        RET               ;9 601 697
;****************
;div8
;8 by 8 bit unsigned division.
;  IN:  A = dividend
;       C = divisor
;  OUT: A = quotient
;       C = remainder
;  USES:F(lags)
;  Size 26 bytes
;  Time between 411 and 459 cycles
;****************
;pseudo code:
;T = dividend
;D = divisor
;Q = quotient = 0
;R = remainder = 0
;invariante betrekking:
; T = QD + R
; T <= 2^8  
;
; D/T'.RT\Q'      
;   R'             
; RT <= 2^8        
; 0<=k<=8          
; RT = T % 2^k     
; T' = (T-RT) / 2^k
; Q' = T' / D      
; R' = T' % D      
;
;for (i=8; i>0; i--) {
;  T = T * 2 (remember MSB in carry)
;  R = R * 2 + carry
;  Q = Q * 2
;  if (R >= D) {
;    R = R - D;
;    Q++;
;  }
;}
;return Q (in A) and R (in C)
;****************
;E = T = dividend
;C = D = divisor
;D = Q = quotient
;A = R = remainder
;****************
;  IN:  A = dividend
;       C  = divisor
div8:
        PUSH  DE          ;11 11 save registers used
        PUSH  BC          ;11 22 save registers used
        LD    B,8         ; 6 28 the length of the dividend (8 bits)
        LD    D,0         ; 6 34 D = Q = quotient = 0
        LD    E,A         ; 4 38 E = T = dividend
        XOR   A,A         ; 4 42 A = R = remainder = 0
div8_1:
        SLA   E           ;8*7=56  98            T[E] = T[E] * 2 (remember MSB in carry)
        RL    A           ;8*7=56 154            R[A] = R[A] * 2 + carry
        SLA   D           ;8*7=56 210            Q[D] = Q[D] * 2
        CP    A,C         ;8*4=32 242            if (R[A] - D[C] >= 0) {
        JR    C,div8_2    ;8*8=64 306 8*6=48 290
        SUB   A,C         ;           8*4=32 322   R[A] = R[A] - D[C];
        INC   D           ;           8*4=32 354   Q[D]++;
div8_2:           ;                      }
        DJNZ  div8_1      ;7*9+7=70 376 424      }
        POP   BC          ;9        385 433
        LD    C,A         ;4        389 437      return Remainder[A] in C
        LD    A,D         ;4        393 441      return Quotient[D] in A
        POP   DE          ;9        402 450
        RET               ;9        411 459
;****************
;div8_16
;8 by 16 bit unsigned division.
;  IN:  A = dividend
;       HL = divisor
;  OUT: A = quotient
;       C = remainder
;  USES:F(lags)
;  Size 13 bytes (plus dependency on div8)
;  Time 31 or between 436 and 484 cycles
;****************
;invariante betrekking:
; T = dividend
; D = divisor
; Q = quotient
; R = remainder
; T = QD + R
;pseudo code:
; if D >= 256 {
;   R = T
;   Q = 0
; } else {
;   R = T/D (using div8)
;   Q = T%D (using div8)
; }
;****************


div8_16:
        LD    C,A         ;  4  4         save dividend(A) in C
        LD    A,H         ;  4  8         if D >= 256 {
        OR    A,A         ;  4 12
        JR    Z,div8_161  ;  6 18  8  20
        XOR   A,A         ;  4 22           R = T;
        RET               ;  9 31           Q = 0;
div8_161:                     ;               } else {
        LD    A,C         ;        4  24    restore dividend into A
        LD    C,L         ;        4  28    load divisor (HL) into C
        CALL  div8        ; 16+411/16+459               R = T/D; Q = T%D;
        RET               ; 9  436/484    }
;****************
;read
;read a 16 bit unsigned number from the input
;  IN:  none
;  OUT: HL = 16 bit unsigned number
;  USES:-
;****************
read:
        PUSH  AF
        LD    HL,0        ;result = 0;
read1:
        CALL  getChar     ;check if a character is available.
        JR    Z,read1     ;-no: wait for it.
        CP    A,'\r'      ;return if char == Carriage Return
        JR    Z,read2
        CALL  mul16_10    ;result *= 10;
        SUB   A,'0'       ;digit = char - '0';
        ADD   A,L         ;result += digit;
        LD    L,A
        JR    NC,read1     ;get next character
        INC   H
        JR    read1        ;get next character
read2:
        POP   AF
        RET
;****************
;writeLineHL
;write a 16 bit unsigned number to the output, followed by a carriage return
;  IN:  HL = 16 bit unsigned number
;  OUT: none
;  USES:HL
;****************
writeLineHL:
        CALL  writeHL
        CALL  putCRLF
        RET
;****************
;writeHL
;write a 16 bit unsigned number to the output
;  IN:  HL = 16 bit unsigned number
;  OUT: none
;  USES:HL
;****************
writeHL:
        PUSH  BC          ;save registers used
        PUSH  AF
        LD    B,0         ;number of digits on stack
        LD    A,H         ;is HL=0?
        OR    A,L
        JR    NZ,writeHL1
        INC   B           ;write a single digit 0
        JR    writeHL3
writeHL1:
        LD    A,10        ;divide HL by 10
        CALL  div16_8
        PUSH  AF          ;put remainder on stack
        INC   B
        LD    A,H         ;is quotient 0?
        OR    A,L
        JR    NZ,writeHL1
writeHL2:
        POP   AF          ;write digit
writeHL3:
        ADD   A,'0'
        CALL  putChar
        DJNZ  writeHL2
        POP   AF          ;restore registers used
        POP   BC
        RET
;****************
;writeLineA
;write an 8-bit unsigned number to the output, followed by a carriage return
;  IN:  A = 8-bit unsigned number
;  OUT: none
;  USES:none
;****************
writeLineA:
        CALL  writeA
        CALL  putCRLF
        RET
;****************
;writeA
;write an 8-bit unsigned number to the output
;  IN:  A = 8-bit unsigned number
;  OUT: none
;  USES:none
;****************
writeA:
        PUSH  HL          ;save registers used
        LD    H,0
        LD    L,A
        CALL  writeHL
        POP   HL
        RET
