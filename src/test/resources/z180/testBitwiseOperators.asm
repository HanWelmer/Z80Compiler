SOC     equ 02000H        ;start of code, i.e.lowest external RAM address.
TOS     equ 0FD00H        ;top of stack, i.e. bottom of MONITOR user global data.
        .ORG  SOC
start:
        LD    SP,TOS
L0:
        CALL  L6
L1:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2:
        ;;testBitwiseOperators.j(0) /* Program to test bitwise operators and, or and xor. */
L3:
        ;;testBitwiseOperators.j(1) class TestBitwiseOperators {
L4:
        ;class TestBitwiseOperators []
L5:
        ;;testBitwiseOperators.j(2)   private static byte b1 = 0x1C;
L6:
        LD    A,28
L7:
        LD    (05000H),A
L8:
        ;;testBitwiseOperators.j(3)   private static byte b2 = 0x07;
L9:
        LD    A,7
L10:
        LD    (05001H),A
L11:
        ;;testBitwiseOperators.j(4)   private static word w1 = 0x032C;
L12:
        LD    HL,812
L13:
        LD    (05002H),HL
L14:
        ;;testBitwiseOperators.j(5)   private static word w2 = 0x1234;
L15:
        LD    HL,4660
L16:
        LD    (05004H),HL
L17:
        JP    L24
L18:
        ;;testBitwiseOperators.j(6)   private static final byte fb1 = 0x1C;
L19:
        ;;testBitwiseOperators.j(7)   private static final byte fb2 = 0x07;
L20:
        ;;testBitwiseOperators.j(8)   private static final word fw1 = 0x032C;
L21:
        ;;testBitwiseOperators.j(9)   private static final word fw2 = 0x1234;
L22:
        ;;testBitwiseOperators.j(10) 
L23:
        ;;testBitwiseOperators.j(11)   public static void main() {
L24:
        ;method TestBitwiseOperators.main [public, static] void ()
L25:
        PUSH  IX
L26:
        LD    IX,0x0000
        ADD   IX,SP
L27:
L28:
        ;;testBitwiseOperators.j(12)     println(0);
L29:
        LD    A,0
L30:
        CALL  writeLineA
L31:
        ;;testBitwiseOperators.j(13)     
L32:
        ;;testBitwiseOperators.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
L33:
        ;;testBitwiseOperators.j(15)     // Possible data types: byte, word.
L34:
        ;;testBitwiseOperators.j(16)   
L35:
        ;;testBitwiseOperators.j(17)     //constant/constant
L36:
        ;;testBitwiseOperators.j(18)     //*****************
L37:
        ;;testBitwiseOperators.j(19)     //constant byte/constant byte
L38:
        ;;testBitwiseOperators.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
L39:
        LD    A,7
L40:
        AND   A,28
L41:
        SUB   A,4
L42:
        JP    NZ,L46
L43:
        LD    A,1
L44:
        CALL  writeLineA
L45:
        JP    L49
L46:
        LD    HL,999
L47:
        CALL  writeLineHL
L48:
        ;;testBitwiseOperators.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
L49:
        LD    A,7
L50:
        OR    A,28
L51:
        SUB   A,31
L52:
        JP    NZ,L56
L53:
        LD    A,2
L54:
        CALL  writeLineA
L55:
        JP    L59
L56:
        LD    HL,999
L57:
        CALL  writeLineHL
L58:
        ;;testBitwiseOperators.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
L59:
        LD    A,7
L60:
        XOR   A,28
L61:
        SUB   A,27
L62:
        JP    NZ,L66
L63:
        LD    A,3
L64:
        CALL  writeLineA
L65:
        JP    L70
L66:
        LD    HL,999
L67:
        CALL  writeLineHL
L68:
        ;;testBitwiseOperators.j(23)     //constant word/constant word
L69:
        ;;testBitwiseOperators.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
L70:
        LD    HL,4660
L71:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L72:
        LD    DE,548
        OR    A
        SBC   HL,DE
L73:
        JP    NZ,L77
L74:
        LD    A,4
L75:
        CALL  writeLineA
L76:
        JP    L81
L77:
        LD    HL,999
L78:
        CALL  writeLineHL
L79:
        ;;testBitwiseOperators.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
L80:
        ;;testBitwiseOperators.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
L81:
        LD    HL,4660
L82:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L83:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L84:
        JP    NZ,L88
L85:
        LD    A,5
L86:
        CALL  writeLineA
L87:
        JP    L92
L88:
        LD    HL,999
L89:
        CALL  writeLineHL
L90:
        ;;testBitwiseOperators.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
L91:
        ;;testBitwiseOperators.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
L92:
        LD    HL,4660
L93:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L94:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L95:
        JP    NZ,L99
L96:
        LD    A,6
L97:
        CALL  writeLineA
L98:
        JP    L104
L99:
        LD    HL,999
L100:
        CALL  writeLineHL
L101:
        ;;testBitwiseOperators.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
L102:
        ;;testBitwiseOperators.j(30)     //constant byte/constant word
L103:
        ;;testBitwiseOperators.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
L104:
        LD    A,28
L105:
        LD    L,A
        LD    H,0
L106:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L107:
        LD    A,20
L108:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L109:
        JP    NZ,L113
L110:
        LD    A,7
L111:
        CALL  writeLineA
L112:
        JP    L116
L113:
        LD    HL,999
L114:
        CALL  writeLineHL
L115:
        ;;testBitwiseOperators.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
L116:
        LD    A,28
L117:
        LD    L,A
        LD    H,0
L118:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L119:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L120:
        JP    NZ,L124
L121:
        LD    A,8
L122:
        CALL  writeLineA
L123:
        JP    L127
L124:
        LD    HL,999
L125:
        CALL  writeLineHL
L126:
        ;;testBitwiseOperators.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
L127:
        LD    A,28
L128:
        LD    L,A
        LD    H,0
L129:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L130:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L131:
        JP    NZ,L135
L132:
        LD    A,9
L133:
        CALL  writeLineA
L134:
        JP    L139
L135:
        LD    HL,999
L136:
        CALL  writeLineHL
L137:
        ;;testBitwiseOperators.j(34)     //constant word/constant byte
L138:
        ;;testBitwiseOperators.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
L139:
        LD    HL,4660
L140:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L141:
        LD    A,20
L142:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L143:
        JP    NZ,L147
L144:
        LD    A,10
L145:
        CALL  writeLineA
L146:
        JP    L150
L147:
        LD    HL,999
L148:
        CALL  writeLineHL
L149:
        ;;testBitwiseOperators.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
L150:
        LD    HL,4660
L151:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L152:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L153:
        JP    NZ,L157
L154:
        LD    A,11
L155:
        CALL  writeLineA
L156:
        JP    L160
L157:
        LD    HL,999
L158:
        CALL  writeLineHL
L159:
        ;;testBitwiseOperators.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
L160:
        LD    HL,4660
L161:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L162:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L163:
        JP    NZ,L167
L164:
        LD    A,12
L165:
        CALL  writeLineA
L166:
        JP    L174
L167:
        LD    HL,999
L168:
        CALL  writeLineHL
L169:
        ;;testBitwiseOperators.j(38)   
L170:
        ;;testBitwiseOperators.j(39)     //constant/acc
L171:
        ;;testBitwiseOperators.j(40)     //************
L172:
        ;;testBitwiseOperators.j(41)     //constant byte/acc byte
L173:
        ;;testBitwiseOperators.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
L174:
        LD    A,7
L175:
        PUSH  AF
        LD    A,16
L176:
        ADD   A,12
L177:
        POP   BC
        AND   A,B
L178:
        SUB   A,4
L179:
        JP    NZ,L183
L180:
        LD    A,13
L181:
        CALL  writeLineA
L182:
        JP    L186
L183:
        LD    HL,999
L184:
        CALL  writeLineHL
L185:
        ;;testBitwiseOperators.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
L186:
        LD    A,7
L187:
        PUSH  AF
        LD    A,16
L188:
        ADD   A,12
L189:
        POP   BC
        OR    A,B
L190:
        SUB   A,31
L191:
        JP    NZ,L195
L192:
        LD    A,14
L193:
        CALL  writeLineA
L194:
        JP    L198
L195:
        LD    HL,999
L196:
        CALL  writeLineHL
L197:
        ;;testBitwiseOperators.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
L198:
        LD    A,7
L199:
        PUSH  AF
        LD    A,16
L200:
        ADD   A,12
L201:
        POP   BC
        XOR   A,B
L202:
        SUB   A,27
L203:
        JP    NZ,L207
L204:
        LD    A,15
L205:
        CALL  writeLineA
L206:
        JP    L211
L207:
        LD    HL,999
L208:
        CALL  writeLineHL
L209:
        ;;testBitwiseOperators.j(45)     //constant word/acc word
L210:
        ;;testBitwiseOperators.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
L211:
        LD    HL,4660
L212:
        PUSH  HL
        LD    HL,256
L213:
        LD    DE,556
        ADD   HL,DE
L214:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L215:
        LD    DE,548
        OR    A
        SBC   HL,DE
L216:
        JP    NZ,L220
L217:
        LD    A,16
L218:
        CALL  writeLineA
L219:
        JP    L223
L220:
        LD    HL,999
L221:
        CALL  writeLineHL
L222:
        ;;testBitwiseOperators.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
L223:
        LD    HL,4660
L224:
        PUSH  HL
        LD    HL,256
L225:
        LD    DE,556
        ADD   HL,DE
L226:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L227:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L228:
        JP    NZ,L232
L229:
        LD    A,17
L230:
        CALL  writeLineA
L231:
        JP    L235
L232:
        LD    HL,999
L233:
        CALL  writeLineHL
L234:
        ;;testBitwiseOperators.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
L235:
        LD    HL,4660
L236:
        PUSH  HL
        LD    HL,256
L237:
        LD    DE,556
        ADD   HL,DE
L238:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L239:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L240:
        JP    NZ,L244
L241:
        LD    A,18
L242:
        CALL  writeLineA
L243:
        JP    L248
L244:
        LD    HL,999
L245:
        CALL  writeLineHL
L246:
        ;;testBitwiseOperators.j(49)     //constant byte/acc word
L247:
        ;;testBitwiseOperators.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
L248:
        LD    A,28
L249:
        LD    HL,4096
L250:
        LD    DE,564
        ADD   HL,DE
L251:
        AND   A,L
        LD    L,A
        LD    H,0
L252:
        LD    A,20
L253:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L254:
        JP    NZ,L258
L255:
        LD    A,19
L256:
        CALL  writeLineA
L257:
        JP    L261
L258:
        LD    HL,999
L259:
        CALL  writeLineHL
L260:
        ;;testBitwiseOperators.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
L261:
        LD    A,28
L262:
        LD    HL,4096
L263:
        LD    DE,564
        ADD   HL,DE
L264:
        OR    A,L
        LD    L,A
L265:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L266:
        JP    NZ,L270
L267:
        LD    A,20
L268:
        CALL  writeLineA
L269:
        JP    L273
L270:
        LD    HL,999
L271:
        CALL  writeLineHL
L272:
        ;;testBitwiseOperators.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
L273:
        LD    A,28
L274:
        LD    HL,4096
L275:
        LD    DE,564
        ADD   HL,DE
L276:
        XOR   A,L
        LD    L,A
L277:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L278:
        JP    NZ,L282
L279:
        LD    A,21
L280:
        CALL  writeLineA
L281:
        JP    L286
L282:
        LD    HL,999
L283:
        CALL  writeLineHL
L284:
        ;;testBitwiseOperators.j(53)     //constant word/acc byte
L285:
        ;;testBitwiseOperators.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
L286:
        LD    HL,4660
L287:
        LD    A,16
L288:
        ADD   A,12
L289:
        AND   A,L
        LD    L,A
        LD    H,0
L290:
        LD    A,20
L291:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L292:
        JP    NZ,L296
L293:
        LD    A,22
L294:
        CALL  writeLineA
L295:
        JP    L299
L296:
        LD    HL,999
L297:
        CALL  writeLineHL
L298:
        ;;testBitwiseOperators.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
L299:
        LD    HL,4660
L300:
        LD    A,16
L301:
        ADD   A,12
L302:
        OR    A,L
        LD    L,A
L303:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L304:
        JP    NZ,L308
L305:
        LD    A,23
L306:
        CALL  writeLineA
L307:
        JP    L311
L308:
        LD    HL,999
L309:
        CALL  writeLineHL
L310:
        ;;testBitwiseOperators.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
L311:
        LD    HL,4660
L312:
        LD    A,16
L313:
        ADD   A,12
L314:
        XOR   A,L
        LD    L,A
L315:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L316:
        JP    NZ,L320
L317:
        LD    A,24
L318:
        CALL  writeLineA
L319:
        JP    L327
L320:
        LD    HL,999
L321:
        CALL  writeLineHL
L322:
        ;;testBitwiseOperators.j(57)   
L323:
        ;;testBitwiseOperators.j(58)     //constant/var
L324:
        ;;testBitwiseOperators.j(59)     //*****************
L325:
        ;;testBitwiseOperators.j(60)     //constant byte/var byte
L326:
        ;;testBitwiseOperators.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
L327:
        LD    A,7
L328:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L329:
        SUB   A,4
L330:
        JP    NZ,L334
L331:
        LD    A,25
L332:
        CALL  writeLineA
L333:
        JP    L337
L334:
        LD    HL,999
L335:
        CALL  writeLineHL
L336:
        ;;testBitwiseOperators.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
L337:
        LD    A,7
L338:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L339:
        SUB   A,31
L340:
        JP    NZ,L344
L341:
        LD    A,26
L342:
        CALL  writeLineA
L343:
        JP    L347
L344:
        LD    HL,999
L345:
        CALL  writeLineHL
L346:
        ;;testBitwiseOperators.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
L347:
        LD    A,7
L348:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L349:
        SUB   A,27
L350:
        JP    NZ,L354
L351:
        LD    A,27
L352:
        CALL  writeLineA
L353:
        JP    L358
L354:
        LD    HL,999
L355:
        CALL  writeLineHL
L356:
        ;;testBitwiseOperators.j(64)     //constant word/var word
L357:
        ;;testBitwiseOperators.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
L358:
        LD    HL,4660
L359:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L360:
        LD    DE,548
        OR    A
        SBC   HL,DE
L361:
        JP    NZ,L365
L362:
        LD    A,28
L363:
        CALL  writeLineA
L364:
        JP    L368
L365:
        LD    HL,999
L366:
        CALL  writeLineHL
L367:
        ;;testBitwiseOperators.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
L368:
        LD    HL,4660
L369:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L370:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L371:
        JP    NZ,L375
L372:
        LD    A,29
L373:
        CALL  writeLineA
L374:
        JP    L378
L375:
        LD    HL,999
L376:
        CALL  writeLineHL
L377:
        ;;testBitwiseOperators.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
L378:
        LD    HL,4660
L379:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L380:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L381:
        JP    NZ,L385
L382:
        LD    A,30
L383:
        CALL  writeLineA
L384:
        JP    L389
L385:
        LD    HL,999
L386:
        CALL  writeLineHL
L387:
        ;;testBitwiseOperators.j(68)     //constant byte/var word
L388:
        ;;testBitwiseOperators.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
L389:
        LD    A,28
L390:
        LD    L,A
        LD    H,0
L391:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L392:
        LD    A,20
L393:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L394:
        JP    NZ,L398
L395:
        LD    A,31
L396:
        CALL  writeLineA
L397:
        JP    L401
L398:
        LD    HL,999
L399:
        CALL  writeLineHL
L400:
        ;;testBitwiseOperators.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
L401:
        LD    A,28
L402:
        LD    L,A
        LD    H,0
L403:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L404:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L405:
        JP    NZ,L409
L406:
        LD    A,32
L407:
        CALL  writeLineA
L408:
        JP    L412
L409:
        LD    HL,999
L410:
        CALL  writeLineHL
L411:
        ;;testBitwiseOperators.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
L412:
        LD    A,28
L413:
        LD    L,A
        LD    H,0
L414:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L415:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L416:
        JP    NZ,L420
L417:
        LD    A,33
L418:
        CALL  writeLineA
L419:
        JP    L424
L420:
        LD    HL,999
L421:
        CALL  writeLineHL
L422:
        ;;testBitwiseOperators.j(72)     //constant word/var byte
L423:
        ;;testBitwiseOperators.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
L424:
        LD    HL,4660
L425:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L426:
        LD    A,20
L427:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L428:
        JP    NZ,L432
L429:
        LD    A,34
L430:
        CALL  writeLineA
L431:
        JP    L435
L432:
        LD    HL,999
L433:
        CALL  writeLineHL
L434:
        ;;testBitwiseOperators.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
L435:
        LD    HL,4660
L436:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L437:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L438:
        JP    NZ,L442
L439:
        LD    A,35
L440:
        CALL  writeLineA
L441:
        JP    L445
L442:
        LD    HL,999
L443:
        CALL  writeLineHL
L444:
        ;;testBitwiseOperators.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
L445:
        LD    HL,4660
L446:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L447:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L448:
        JP    NZ,L452
L449:
        LD    A,36
L450:
        CALL  writeLineA
L451:
        JP    L459
L452:
        LD    HL,999
L453:
        CALL  writeLineHL
L454:
        ;;testBitwiseOperators.j(76)   
L455:
        ;;testBitwiseOperators.j(77)     //constant/final var
L456:
        ;;testBitwiseOperators.j(78)     //*****************
L457:
        ;;testBitwiseOperators.j(79)     //constant byte/final var byte
L458:
        ;;testBitwiseOperators.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
L459:
        LD    A,7
L460:
        AND   A,28
L461:
        SUB   A,4
L462:
        JP    NZ,L466
L463:
        LD    A,37
L464:
        CALL  writeLineA
L465:
        JP    L469
L466:
        LD    HL,999
L467:
        CALL  writeLineHL
L468:
        ;;testBitwiseOperators.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
L469:
        LD    A,7
L470:
        OR    A,28
L471:
        SUB   A,31
L472:
        JP    NZ,L476
L473:
        LD    A,38
L474:
        CALL  writeLineA
L475:
        JP    L479
L476:
        LD    HL,999
L477:
        CALL  writeLineHL
L478:
        ;;testBitwiseOperators.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
L479:
        LD    A,7
L480:
        XOR   A,28
L481:
        SUB   A,27
L482:
        JP    NZ,L486
L483:
        LD    A,39
L484:
        CALL  writeLineA
L485:
        JP    L490
L486:
        LD    HL,999
L487:
        CALL  writeLineHL
L488:
        ;;testBitwiseOperators.j(83)     //constant word/final var word
L489:
        ;;testBitwiseOperators.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
L490:
        LD    HL,4660
L491:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L492:
        LD    DE,548
        OR    A
        SBC   HL,DE
L493:
        JP    NZ,L497
L494:
        LD    A,40
L495:
        CALL  writeLineA
L496:
        JP    L500
L497:
        LD    HL,999
L498:
        CALL  writeLineHL
L499:
        ;;testBitwiseOperators.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
L500:
        LD    HL,4660
L501:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L502:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L503:
        JP    NZ,L507
L504:
        LD    A,41
L505:
        CALL  writeLineA
L506:
        JP    L510
L507:
        LD    HL,999
L508:
        CALL  writeLineHL
L509:
        ;;testBitwiseOperators.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
L510:
        LD    HL,4660
L511:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L512:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L513:
        JP    NZ,L517
L514:
        LD    A,42
L515:
        CALL  writeLineA
L516:
        JP    L521
L517:
        LD    HL,999
L518:
        CALL  writeLineHL
L519:
        ;;testBitwiseOperators.j(87)     //constant byte/final var word
L520:
        ;;testBitwiseOperators.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
L521:
        LD    A,28
L522:
        LD    L,A
        LD    H,0
L523:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L524:
        LD    A,20
L525:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L526:
        JP    NZ,L530
L527:
        LD    A,43
L528:
        CALL  writeLineA
L529:
        JP    L533
L530:
        LD    HL,999
L531:
        CALL  writeLineHL
L532:
        ;;testBitwiseOperators.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
L533:
        LD    A,28
L534:
        LD    L,A
        LD    H,0
L535:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L536:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L537:
        JP    NZ,L541
L538:
        LD    A,44
L539:
        CALL  writeLineA
L540:
        JP    L544
L541:
        LD    HL,999
L542:
        CALL  writeLineHL
L543:
        ;;testBitwiseOperators.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
L544:
        LD    A,28
L545:
        LD    L,A
        LD    H,0
L546:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L547:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L548:
        JP    NZ,L552
L549:
        LD    A,45
L550:
        CALL  writeLineA
L551:
        JP    L556
L552:
        LD    HL,999
L553:
        CALL  writeLineHL
L554:
        ;;testBitwiseOperators.j(91)     //constant word/final var byte
L555:
        ;;testBitwiseOperators.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
L556:
        LD    HL,4660
L557:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L558:
        LD    A,20
L559:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L560:
        JP    NZ,L564
L561:
        LD    A,46
L562:
        CALL  writeLineA
L563:
        JP    L567
L564:
        LD    HL,999
L565:
        CALL  writeLineHL
L566:
        ;;testBitwiseOperators.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
L567:
        LD    HL,4660
L568:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L569:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L570:
        JP    NZ,L574
L571:
        LD    A,47
L572:
        CALL  writeLineA
L573:
        JP    L577
L574:
        LD    HL,999
L575:
        CALL  writeLineHL
L576:
        ;;testBitwiseOperators.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
L577:
        LD    HL,4660
L578:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L579:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L580:
        JP    NZ,L584
L581:
        LD    A,48
L582:
        CALL  writeLineA
L583:
        JP    L591
L584:
        LD    HL,999
L585:
        CALL  writeLineHL
L586:
        ;;testBitwiseOperators.j(95)   
L587:
        ;;testBitwiseOperators.j(96)     //acc/constant
L588:
        ;;testBitwiseOperators.j(97)     //************
L589:
        ;;testBitwiseOperators.j(98)     //acc byte/constant byte
L590:
        ;;testBitwiseOperators.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
L591:
        LD    A,4
L592:
        ADD   A,3
L593:
        AND   A,28
L594:
        SUB   A,4
L595:
        JP    NZ,L599
L596:
        LD    A,49
L597:
        CALL  writeLineA
L598:
        JP    L602
L599:
        LD    HL,999
L600:
        CALL  writeLineHL
L601:
        ;;testBitwiseOperators.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
L602:
        LD    A,4
L603:
        ADD   A,3
L604:
        OR    A,28
L605:
        SUB   A,31
L606:
        JP    NZ,L610
L607:
        LD    A,50
L608:
        CALL  writeLineA
L609:
        JP    L613
L610:
        LD    HL,999
L611:
        CALL  writeLineHL
L612:
        ;;testBitwiseOperators.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
L613:
        LD    A,4
L614:
        ADD   A,3
L615:
        XOR   A,28
L616:
        SUB   A,27
L617:
        JP    NZ,L621
L618:
        LD    A,51
L619:
        CALL  writeLineA
L620:
        JP    L625
L621:
        LD    HL,999
L622:
        CALL  writeLineHL
L623:
        ;;testBitwiseOperators.j(102)     //acc word/constant word
L624:
        ;;testBitwiseOperators.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
L625:
        LD    HL,4096
L626:
        LD    DE,564
        ADD   HL,DE
L627:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L628:
        LD    DE,548
        OR    A
        SBC   HL,DE
L629:
        JP    NZ,L633
L630:
        LD    A,52
L631:
        CALL  writeLineA
L632:
        JP    L636
L633:
        LD    HL,999
L634:
        CALL  writeLineHL
L635:
        ;;testBitwiseOperators.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
L636:
        LD    HL,4096
L637:
        LD    DE,564
        ADD   HL,DE
L638:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L639:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L640:
        JP    NZ,L644
L641:
        LD    A,53
L642:
        CALL  writeLineA
L643:
        JP    L647
L644:
        LD    HL,999
L645:
        CALL  writeLineHL
L646:
        ;;testBitwiseOperators.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
L647:
        LD    HL,4096
L648:
        LD    DE,564
        ADD   HL,DE
L649:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L650:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L651:
        JP    NZ,L655
L652:
        LD    A,54
L653:
        CALL  writeLineA
L654:
        JP    L659
L655:
        LD    HL,999
L656:
        CALL  writeLineHL
L657:
        ;;testBitwiseOperators.j(106)     //acc byte/constant word
L658:
        ;;testBitwiseOperators.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
L659:
        LD    A,16
L660:
        ADD   A,12
L661:
        LD    L,A
        LD    H,0
L662:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L663:
        LD    A,20
L664:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L665:
        JP    NZ,L669
L666:
        LD    A,55
L667:
        CALL  writeLineA
L668:
        JP    L672
L669:
        LD    HL,999
L670:
        CALL  writeLineHL
L671:
        ;;testBitwiseOperators.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
L672:
        LD    A,16
L673:
        ADD   A,12
L674:
        LD    L,A
        LD    H,0
L675:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L676:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L677:
        JP    NZ,L681
L678:
        LD    A,56
L679:
        CALL  writeLineA
L680:
        JP    L684
L681:
        LD    HL,999
L682:
        CALL  writeLineHL
L683:
        ;;testBitwiseOperators.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
L684:
        LD    A,16
L685:
        ADD   A,12
L686:
        LD    L,A
        LD    H,0
L687:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L688:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L689:
        JP    NZ,L693
L690:
        LD    A,57
L691:
        CALL  writeLineA
L692:
        JP    L697
L693:
        LD    HL,999
L694:
        CALL  writeLineHL
L695:
        ;;testBitwiseOperators.j(110)     //acc word/constant byte
L696:
        ;;testBitwiseOperators.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
L697:
        LD    HL,4096
L698:
        LD    DE,564
        ADD   HL,DE
L699:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L700:
        LD    A,20
L701:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L702:
        JP    NZ,L706
L703:
        LD    A,58
L704:
        CALL  writeLineA
L705:
        JP    L709
L706:
        LD    HL,999
L707:
        CALL  writeLineHL
L708:
        ;;testBitwiseOperators.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
L709:
        LD    HL,4096
L710:
        LD    DE,564
        ADD   HL,DE
L711:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L712:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L713:
        JP    NZ,L717
L714:
        LD    A,59
L715:
        CALL  writeLineA
L716:
        JP    L720
L717:
        LD    HL,999
L718:
        CALL  writeLineHL
L719:
        ;;testBitwiseOperators.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
L720:
        LD    HL,4096
L721:
        LD    DE,564
        ADD   HL,DE
L722:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L723:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L724:
        JP    NZ,L728
L725:
        LD    A,60
L726:
        CALL  writeLineA
L727:
        JP    L735
L728:
        LD    HL,999
L729:
        CALL  writeLineHL
L730:
        ;;testBitwiseOperators.j(114)   
L731:
        ;;testBitwiseOperators.j(115)     //acc/acc
L732:
        ;;testBitwiseOperators.j(116)     //*******
L733:
        ;;testBitwiseOperators.j(117)     //acc byte/acc byte
L734:
        ;;testBitwiseOperators.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
L735:
        LD    A,4
L736:
        ADD   A,3
L737:
        PUSH  AF
        LD    A,16
L738:
        ADD   A,12
L739:
        POP   BC
        AND   A,B
L740:
        SUB   A,4
L741:
        JP    NZ,L745
L742:
        LD    A,61
L743:
        CALL  writeLineA
L744:
        JP    L748
L745:
        LD    HL,999
L746:
        CALL  writeLineHL
L747:
        ;;testBitwiseOperators.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
L748:
        LD    A,4
L749:
        ADD   A,3
L750:
        PUSH  AF
        LD    A,16
L751:
        ADD   A,12
L752:
        POP   BC
        OR    A,B
L753:
        SUB   A,31
L754:
        JP    NZ,L758
L755:
        LD    A,62
L756:
        CALL  writeLineA
L757:
        JP    L761
L758:
        LD    HL,999
L759:
        CALL  writeLineHL
L760:
        ;;testBitwiseOperators.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
L761:
        LD    A,4
L762:
        ADD   A,3
L763:
        PUSH  AF
        LD    A,16
L764:
        ADD   A,12
L765:
        POP   BC
        XOR   A,B
L766:
        SUB   A,27
L767:
        JP    NZ,L771
L768:
        LD    A,63
L769:
        CALL  writeLineA
L770:
        JP    L775
L771:
        LD    HL,999
L772:
        CALL  writeLineHL
L773:
        ;;testBitwiseOperators.j(121)     //acc word/acc word
L774:
        ;;testBitwiseOperators.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
L775:
        LD    HL,4096
L776:
        LD    DE,564
        ADD   HL,DE
L777:
        PUSH  HL
        LD    HL,256
L778:
        LD    DE,556
        ADD   HL,DE
L779:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L780:
        LD    DE,548
        OR    A
        SBC   HL,DE
L781:
        JP    NZ,L785
L782:
        LD    A,64
L783:
        CALL  writeLineA
L784:
        JP    L788
L785:
        LD    HL,999
L786:
        CALL  writeLineHL
L787:
        ;;testBitwiseOperators.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
L788:
        LD    HL,4096
L789:
        LD    DE,564
        ADD   HL,DE
L790:
        PUSH  HL
        LD    HL,256
L791:
        LD    DE,556
        ADD   HL,DE
L792:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L793:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L794:
        JP    NZ,L798
L795:
        LD    A,65
L796:
        CALL  writeLineA
L797:
        JP    L801
L798:
        LD    HL,999
L799:
        CALL  writeLineHL
L800:
        ;;testBitwiseOperators.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
L801:
        LD    HL,4096
L802:
        LD    DE,564
        ADD   HL,DE
L803:
        PUSH  HL
        LD    HL,256
L804:
        LD    DE,556
        ADD   HL,DE
L805:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L806:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L807:
        JP    NZ,L811
L808:
        LD    A,66
L809:
        CALL  writeLineA
L810:
        JP    L815
L811:
        LD    HL,999
L812:
        CALL  writeLineHL
L813:
        ;;testBitwiseOperators.j(125)     //acc byte/acc word
L814:
        ;;testBitwiseOperators.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
L815:
        LD    A,16
L816:
        ADD   A,12
L817:
        LD    HL,4096
L818:
        LD    DE,564
        ADD   HL,DE
L819:
        AND   A,L
        LD    L,A
        LD    H,0
L820:
        LD    A,20
L821:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L822:
        JP    NZ,L826
L823:
        LD    A,67
L824:
        CALL  writeLineA
L825:
        JP    L829
L826:
        LD    HL,999
L827:
        CALL  writeLineHL
L828:
        ;;testBitwiseOperators.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
L829:
        LD    A,16
L830:
        ADD   A,12
L831:
        LD    HL,4096
L832:
        LD    DE,564
        ADD   HL,DE
L833:
        OR    A,L
        LD    L,A
L834:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L835:
        JP    NZ,L839
L836:
        LD    A,68
L837:
        CALL  writeLineA
L838:
        JP    L842
L839:
        LD    HL,999
L840:
        CALL  writeLineHL
L841:
        ;;testBitwiseOperators.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
L842:
        LD    A,16
L843:
        ADD   A,12
L844:
        LD    HL,4096
L845:
        LD    DE,564
        ADD   HL,DE
L846:
        XOR   A,L
        LD    L,A
L847:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L848:
        JP    NZ,L852
L849:
        LD    A,69
L850:
        CALL  writeLineA
L851:
        JP    L856
L852:
        LD    HL,999
L853:
        CALL  writeLineHL
L854:
        ;;testBitwiseOperators.j(129)     //acc word/acc byte
L855:
        ;;testBitwiseOperators.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
L856:
        LD    HL,4096
L857:
        LD    DE,564
        ADD   HL,DE
L858:
        LD    A,16
L859:
        ADD   A,12
L860:
        AND   A,L
        LD    L,A
        LD    H,0
L861:
        LD    A,20
L862:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L863:
        JP    NZ,L867
L864:
        LD    A,70
L865:
        CALL  writeLineA
L866:
        JP    L870
L867:
        LD    HL,999
L868:
        CALL  writeLineHL
L869:
        ;;testBitwiseOperators.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
L870:
        LD    HL,4096
L871:
        LD    DE,564
        ADD   HL,DE
L872:
        LD    A,16
L873:
        ADD   A,12
L874:
        OR    A,L
        LD    L,A
L875:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L876:
        JP    NZ,L880
L877:
        LD    A,71
L878:
        CALL  writeLineA
L879:
        JP    L883
L880:
        LD    HL,999
L881:
        CALL  writeLineHL
L882:
        ;;testBitwiseOperators.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
L883:
        LD    HL,4096
L884:
        LD    DE,564
        ADD   HL,DE
L885:
        LD    A,16
L886:
        ADD   A,12
L887:
        XOR   A,L
        LD    L,A
L888:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L889:
        JP    NZ,L893
L890:
        LD    A,72
L891:
        CALL  writeLineA
L892:
        JP    L900
L893:
        LD    HL,999
L894:
        CALL  writeLineHL
L895:
        ;;testBitwiseOperators.j(133)   
L896:
        ;;testBitwiseOperators.j(134)     //acc/var
L897:
        ;;testBitwiseOperators.j(135)     //*******
L898:
        ;;testBitwiseOperators.j(136)     //acc byte/var byte
L899:
        ;;testBitwiseOperators.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
L900:
        LD    A,4
L901:
        ADD   A,3
L902:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L903:
        SUB   A,4
L904:
        JP    NZ,L908
L905:
        LD    A,73
L906:
        CALL  writeLineA
L907:
        JP    L911
L908:
        LD    HL,999
L909:
        CALL  writeLineHL
L910:
        ;;testBitwiseOperators.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
L911:
        LD    A,4
L912:
        ADD   A,3
L913:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L914:
        SUB   A,31
L915:
        JP    NZ,L919
L916:
        LD    A,74
L917:
        CALL  writeLineA
L918:
        JP    L922
L919:
        LD    HL,999
L920:
        CALL  writeLineHL
L921:
        ;;testBitwiseOperators.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
L922:
        LD    A,4
L923:
        ADD   A,3
L924:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L925:
        SUB   A,27
L926:
        JP    NZ,L930
L927:
        LD    A,75
L928:
        CALL  writeLineA
L929:
        JP    L934
L930:
        LD    HL,999
L931:
        CALL  writeLineHL
L932:
        ;;testBitwiseOperators.j(140)     //acc word/var word
L933:
        ;;testBitwiseOperators.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
L934:
        LD    HL,4096
L935:
        LD    DE,564
        ADD   HL,DE
L936:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L937:
        LD    DE,548
        OR    A
        SBC   HL,DE
L938:
        JP    NZ,L942
L939:
        LD    A,76
L940:
        CALL  writeLineA
L941:
        JP    L945
L942:
        LD    HL,999
L943:
        CALL  writeLineHL
L944:
        ;;testBitwiseOperators.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
L945:
        LD    HL,4096
L946:
        LD    DE,564
        ADD   HL,DE
L947:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L948:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L949:
        JP    NZ,L953
L950:
        LD    A,77
L951:
        CALL  writeLineA
L952:
        JP    L956
L953:
        LD    HL,999
L954:
        CALL  writeLineHL
L955:
        ;;testBitwiseOperators.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
L956:
        LD    HL,4096
L957:
        LD    DE,564
        ADD   HL,DE
L958:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L959:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L960:
        JP    NZ,L964
L961:
        LD    A,78
L962:
        CALL  writeLineA
L963:
        JP    L968
L964:
        LD    HL,999
L965:
        CALL  writeLineHL
L966:
        ;;testBitwiseOperators.j(144)     //acc byte/var word
L967:
        ;;testBitwiseOperators.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
L968:
        LD    A,16
L969:
        ADD   A,12
L970:
        LD    L,A
        LD    H,0
L971:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L972:
        LD    A,20
L973:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L974:
        JP    NZ,L978
L975:
        LD    A,79
L976:
        CALL  writeLineA
L977:
        JP    L981
L978:
        LD    HL,999
L979:
        CALL  writeLineHL
L980:
        ;;testBitwiseOperators.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
L981:
        LD    A,16
L982:
        ADD   A,12
L983:
        LD    L,A
        LD    H,0
L984:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L985:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L986:
        JP    NZ,L990
L987:
        LD    A,80
L988:
        CALL  writeLineA
L989:
        JP    L993
L990:
        LD    HL,999
L991:
        CALL  writeLineHL
L992:
        ;;testBitwiseOperators.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
L993:
        LD    A,16
L994:
        ADD   A,12
L995:
        LD    L,A
        LD    H,0
L996:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L997:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L998:
        JP    NZ,L1002
L999:
        LD    A,81
L1000:
        CALL  writeLineA
L1001:
        JP    L1006
L1002:
        LD    HL,999
L1003:
        CALL  writeLineHL
L1004:
        ;;testBitwiseOperators.j(148)     //acc word/var byte
L1005:
        ;;testBitwiseOperators.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
L1006:
        LD    HL,4096
L1007:
        LD    DE,564
        ADD   HL,DE
L1008:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1009:
        LD    A,20
L1010:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1011:
        JP    NZ,L1015
L1012:
        LD    A,82
L1013:
        CALL  writeLineA
L1014:
        JP    L1018
L1015:
        LD    HL,999
L1016:
        CALL  writeLineHL
L1017:
        ;;testBitwiseOperators.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
L1018:
        LD    HL,4096
L1019:
        LD    DE,564
        ADD   HL,DE
L1020:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1021:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1022:
        JP    NZ,L1026
L1023:
        LD    A,83
L1024:
        CALL  writeLineA
L1025:
        JP    L1029
L1026:
        LD    HL,999
L1027:
        CALL  writeLineHL
L1028:
        ;;testBitwiseOperators.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
L1029:
        LD    HL,4096
L1030:
        LD    DE,564
        ADD   HL,DE
L1031:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1032:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1033:
        JP    NZ,L1037
L1034:
        LD    A,84
L1035:
        CALL  writeLineA
L1036:
        JP    L1044
L1037:
        LD    HL,999
L1038:
        CALL  writeLineHL
L1039:
        ;;testBitwiseOperators.j(152)   
L1040:
        ;;testBitwiseOperators.j(153)     //acc/final var
L1041:
        ;;testBitwiseOperators.j(154)     //*************
L1042:
        ;;testBitwiseOperators.j(155)     //acc byte/final var byte
L1043:
        ;;testBitwiseOperators.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
L1044:
        LD    A,4
L1045:
        ADD   A,3
L1046:
        AND   A,28
L1047:
        SUB   A,4
L1048:
        JP    NZ,L1052
L1049:
        LD    A,85
L1050:
        CALL  writeLineA
L1051:
        JP    L1055
L1052:
        LD    HL,999
L1053:
        CALL  writeLineHL
L1054:
        ;;testBitwiseOperators.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
L1055:
        LD    A,4
L1056:
        ADD   A,3
L1057:
        OR    A,28
L1058:
        SUB   A,31
L1059:
        JP    NZ,L1063
L1060:
        LD    A,86
L1061:
        CALL  writeLineA
L1062:
        JP    L1066
L1063:
        LD    HL,999
L1064:
        CALL  writeLineHL
L1065:
        ;;testBitwiseOperators.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
L1066:
        LD    A,4
L1067:
        ADD   A,3
L1068:
        XOR   A,28
L1069:
        SUB   A,27
L1070:
        JP    NZ,L1074
L1071:
        LD    A,87
L1072:
        CALL  writeLineA
L1073:
        JP    L1078
L1074:
        LD    HL,999
L1075:
        CALL  writeLineHL
L1076:
        ;;testBitwiseOperators.j(159)     //acc word/final var word
L1077:
        ;;testBitwiseOperators.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
L1078:
        LD    HL,4096
L1079:
        LD    DE,564
        ADD   HL,DE
L1080:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1081:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1082:
        JP    NZ,L1086
L1083:
        LD    A,88
L1084:
        CALL  writeLineA
L1085:
        JP    L1089
L1086:
        LD    HL,999
L1087:
        CALL  writeLineHL
L1088:
        ;;testBitwiseOperators.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
L1089:
        LD    HL,4096
L1090:
        LD    DE,564
        ADD   HL,DE
L1091:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1092:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1093:
        JP    NZ,L1097
L1094:
        LD    A,89
L1095:
        CALL  writeLineA
L1096:
        JP    L1100
L1097:
        LD    HL,999
L1098:
        CALL  writeLineHL
L1099:
        ;;testBitwiseOperators.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
L1100:
        LD    HL,4096
L1101:
        LD    DE,564
        ADD   HL,DE
L1102:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1103:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1104:
        JP    NZ,L1108
L1105:
        LD    A,90
L1106:
        CALL  writeLineA
L1107:
        JP    L1112
L1108:
        LD    HL,999
L1109:
        CALL  writeLineHL
L1110:
        ;;testBitwiseOperators.j(163)     //acc byte/final var word
L1111:
        ;;testBitwiseOperators.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
L1112:
        LD    A,16
L1113:
        ADD   A,12
L1114:
        LD    L,A
        LD    H,0
L1115:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1116:
        LD    A,20
L1117:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1118:
        JP    NZ,L1122
L1119:
        LD    A,91
L1120:
        CALL  writeLineA
L1121:
        JP    L1125
L1122:
        LD    HL,999
L1123:
        CALL  writeLineHL
L1124:
        ;;testBitwiseOperators.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
L1125:
        LD    A,16
L1126:
        ADD   A,12
L1127:
        LD    L,A
        LD    H,0
L1128:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1129:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1130:
        JP    NZ,L1134
L1131:
        LD    A,92
L1132:
        CALL  writeLineA
L1133:
        JP    L1137
L1134:
        LD    HL,999
L1135:
        CALL  writeLineHL
L1136:
        ;;testBitwiseOperators.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
L1137:
        LD    A,16
L1138:
        ADD   A,12
L1139:
        LD    L,A
        LD    H,0
L1140:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1141:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1142:
        JP    NZ,L1146
L1143:
        LD    A,93
L1144:
        CALL  writeLineA
L1145:
        JP    L1150
L1146:
        LD    HL,999
L1147:
        CALL  writeLineHL
L1148:
        ;;testBitwiseOperators.j(167)     //acc word/final var byte
L1149:
        ;;testBitwiseOperators.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
L1150:
        LD    HL,4096
L1151:
        LD    DE,564
        ADD   HL,DE
L1152:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1153:
        LD    A,20
L1154:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1155:
        JP    NZ,L1159
L1156:
        LD    A,94
L1157:
        CALL  writeLineA
L1158:
        JP    L1162
L1159:
        LD    HL,999
L1160:
        CALL  writeLineHL
L1161:
        ;;testBitwiseOperators.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
L1162:
        LD    HL,4096
L1163:
        LD    DE,564
        ADD   HL,DE
L1164:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1165:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1166:
        JP    NZ,L1170
L1167:
        LD    A,95
L1168:
        CALL  writeLineA
L1169:
        JP    L1173
L1170:
        LD    HL,999
L1171:
        CALL  writeLineHL
L1172:
        ;;testBitwiseOperators.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
L1173:
        LD    HL,4096
L1174:
        LD    DE,564
        ADD   HL,DE
L1175:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1176:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1177:
        JP    NZ,L1181
L1178:
        LD    A,96
L1179:
        CALL  writeLineA
L1180:
        JP    L1188
L1181:
        LD    HL,999
L1182:
        CALL  writeLineHL
L1183:
        ;;testBitwiseOperators.j(171)   
L1184:
        ;;testBitwiseOperators.j(172)     //var/constant
L1185:
        ;;testBitwiseOperators.j(173)     //************
L1186:
        ;;testBitwiseOperators.j(174)     //var byte/constant byte
L1187:
        ;;testBitwiseOperators.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
L1188:
        LD    A,(05001H)
L1189:
        AND   A,28
L1190:
        SUB   A,4
L1191:
        JP    NZ,L1195
L1192:
        LD    A,97
L1193:
        CALL  writeLineA
L1194:
        JP    L1198
L1195:
        LD    HL,999
L1196:
        CALL  writeLineHL
L1197:
        ;;testBitwiseOperators.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
L1198:
        LD    A,(05001H)
L1199:
        OR    A,28
L1200:
        SUB   A,31
L1201:
        JP    NZ,L1205
L1202:
        LD    A,98
L1203:
        CALL  writeLineA
L1204:
        JP    L1208
L1205:
        LD    HL,999
L1206:
        CALL  writeLineHL
L1207:
        ;;testBitwiseOperators.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
L1208:
        LD    A,(05001H)
L1209:
        XOR   A,28
L1210:
        SUB   A,27
L1211:
        JP    NZ,L1215
L1212:
        LD    A,99
L1213:
        CALL  writeLineA
L1214:
        JP    L1219
L1215:
        LD    HL,999
L1216:
        CALL  writeLineHL
L1217:
        ;;testBitwiseOperators.j(178)     //var word/constant word
L1218:
        ;;testBitwiseOperators.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
L1219:
        LD    HL,(05004H)
L1220:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1221:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1222:
        JP    NZ,L1226
L1223:
        LD    A,100
L1224:
        CALL  writeLineA
L1225:
        JP    L1229
L1226:
        LD    HL,999
L1227:
        CALL  writeLineHL
L1228:
        ;;testBitwiseOperators.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
L1229:
        LD    HL,(05004H)
L1230:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1231:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1232:
        JP    NZ,L1236
L1233:
        LD    A,101
L1234:
        CALL  writeLineA
L1235:
        JP    L1239
L1236:
        LD    HL,999
L1237:
        CALL  writeLineHL
L1238:
        ;;testBitwiseOperators.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
L1239:
        LD    HL,(05004H)
L1240:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1241:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1242:
        JP    NZ,L1246
L1243:
        LD    A,102
L1244:
        CALL  writeLineA
L1245:
        JP    L1250
L1246:
        LD    HL,999
L1247:
        CALL  writeLineHL
L1248:
        ;;testBitwiseOperators.j(182)     //var byte/constant word
L1249:
        ;;testBitwiseOperators.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
L1250:
        LD    A,(05000H)
L1251:
        LD    L,A
        LD    H,0
L1252:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1253:
        LD    A,20
L1254:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1255:
        JP    NZ,L1259
L1256:
        LD    A,103
L1257:
        CALL  writeLineA
L1258:
        JP    L1262
L1259:
        LD    HL,999
L1260:
        CALL  writeLineHL
L1261:
        ;;testBitwiseOperators.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
L1262:
        LD    A,(05000H)
L1263:
        LD    L,A
        LD    H,0
L1264:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1265:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1266:
        JP    NZ,L1270
L1267:
        LD    A,104
L1268:
        CALL  writeLineA
L1269:
        JP    L1273
L1270:
        LD    HL,999
L1271:
        CALL  writeLineHL
L1272:
        ;;testBitwiseOperators.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
L1273:
        LD    A,(05000H)
L1274:
        LD    L,A
        LD    H,0
L1275:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1276:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1277:
        JP    NZ,L1281
L1278:
        LD    A,105
L1279:
        CALL  writeLineA
L1280:
        JP    L1285
L1281:
        LD    HL,999
L1282:
        CALL  writeLineHL
L1283:
        ;;testBitwiseOperators.j(186)     //var word/constant byte
L1284:
        ;;testBitwiseOperators.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
L1285:
        LD    HL,(05004H)
L1286:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1287:
        LD    A,20
L1288:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1289:
        JP    NZ,L1293
L1290:
        LD    A,106
L1291:
        CALL  writeLineA
L1292:
        JP    L1296
L1293:
        LD    HL,999
L1294:
        CALL  writeLineHL
L1295:
        ;;testBitwiseOperators.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
L1296:
        LD    HL,(05004H)
L1297:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1298:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1299:
        JP    NZ,L1303
L1300:
        LD    A,107
L1301:
        CALL  writeLineA
L1302:
        JP    L1306
L1303:
        LD    HL,999
L1304:
        CALL  writeLineHL
L1305:
        ;;testBitwiseOperators.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
L1306:
        LD    HL,(05004H)
L1307:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1308:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1309:
        JP    NZ,L1313
L1310:
        LD    A,108
L1311:
        CALL  writeLineA
L1312:
        JP    L1320
L1313:
        LD    HL,999
L1314:
        CALL  writeLineHL
L1315:
        ;;testBitwiseOperators.j(190)   
L1316:
        ;;testBitwiseOperators.j(191)     //var/acc
L1317:
        ;;testBitwiseOperators.j(192)     //*******
L1318:
        ;;testBitwiseOperators.j(193)     //var byte/acc byte
L1319:
        ;;testBitwiseOperators.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
L1320:
        LD    A,(05001H)
L1321:
        PUSH  AF
        LD    A,16
L1322:
        ADD   A,12
L1323:
        POP   BC
        AND   A,B
L1324:
        SUB   A,4
L1325:
        JP    NZ,L1329
L1326:
        LD    A,109
L1327:
        CALL  writeLineA
L1328:
        JP    L1332
L1329:
        LD    HL,999
L1330:
        CALL  writeLineHL
L1331:
        ;;testBitwiseOperators.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
L1332:
        LD    A,(05001H)
L1333:
        PUSH  AF
        LD    A,16
L1334:
        ADD   A,12
L1335:
        POP   BC
        OR    A,B
L1336:
        SUB   A,31
L1337:
        JP    NZ,L1341
L1338:
        LD    A,110
L1339:
        CALL  writeLineA
L1340:
        JP    L1344
L1341:
        LD    HL,999
L1342:
        CALL  writeLineHL
L1343:
        ;;testBitwiseOperators.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
L1344:
        LD    A,(05001H)
L1345:
        PUSH  AF
        LD    A,16
L1346:
        ADD   A,12
L1347:
        POP   BC
        XOR   A,B
L1348:
        SUB   A,27
L1349:
        JP    NZ,L1353
L1350:
        LD    A,111
L1351:
        CALL  writeLineA
L1352:
        JP    L1357
L1353:
        LD    HL,999
L1354:
        CALL  writeLineHL
L1355:
        ;;testBitwiseOperators.j(197)     //var word/acc word
L1356:
        ;;testBitwiseOperators.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
L1357:
        LD    HL,(05004H)
L1358:
        PUSH  HL
        LD    HL,256
L1359:
        LD    DE,556
        ADD   HL,DE
L1360:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1361:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1362:
        JP    NZ,L1366
L1363:
        LD    A,112
L1364:
        CALL  writeLineA
L1365:
        JP    L1369
L1366:
        LD    HL,999
L1367:
        CALL  writeLineHL
L1368:
        ;;testBitwiseOperators.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
L1369:
        LD    HL,(05004H)
L1370:
        PUSH  HL
        LD    HL,256
L1371:
        LD    DE,556
        ADD   HL,DE
L1372:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1373:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1374:
        JP    NZ,L1378
L1375:
        LD    A,113
L1376:
        CALL  writeLineA
L1377:
        JP    L1381
L1378:
        LD    HL,999
L1379:
        CALL  writeLineHL
L1380:
        ;;testBitwiseOperators.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
L1381:
        LD    HL,(05004H)
L1382:
        PUSH  HL
        LD    HL,256
L1383:
        LD    DE,556
        ADD   HL,DE
L1384:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1385:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1386:
        JP    NZ,L1390
L1387:
        LD    A,114
L1388:
        CALL  writeLineA
L1389:
        JP    L1394
L1390:
        LD    HL,999
L1391:
        CALL  writeLineHL
L1392:
        ;;testBitwiseOperators.j(201)     //var byte/acc word
L1393:
        ;;testBitwiseOperators.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
L1394:
        LD    A,(05000H)
L1395:
        LD    HL,4096
L1396:
        LD    DE,564
        ADD   HL,DE
L1397:
        AND   A,L
        LD    L,A
        LD    H,0
L1398:
        LD    A,20
L1399:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1400:
        JP    NZ,L1404
L1401:
        LD    A,115
L1402:
        CALL  writeLineA
L1403:
        JP    L1407
L1404:
        LD    HL,999
L1405:
        CALL  writeLineHL
L1406:
        ;;testBitwiseOperators.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
L1407:
        LD    A,(05000H)
L1408:
        LD    HL,4096
L1409:
        LD    DE,564
        ADD   HL,DE
L1410:
        OR    A,L
        LD    L,A
L1411:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1412:
        JP    NZ,L1416
L1413:
        LD    A,116
L1414:
        CALL  writeLineA
L1415:
        JP    L1419
L1416:
        LD    HL,999
L1417:
        CALL  writeLineHL
L1418:
        ;;testBitwiseOperators.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
L1419:
        LD    A,(05000H)
L1420:
        LD    HL,4096
L1421:
        LD    DE,564
        ADD   HL,DE
L1422:
        XOR   A,L
        LD    L,A
L1423:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1424:
        JP    NZ,L1428
L1425:
        LD    A,117
L1426:
        CALL  writeLineA
L1427:
        JP    L1432
L1428:
        LD    HL,999
L1429:
        CALL  writeLineHL
L1430:
        ;;testBitwiseOperators.j(205)     //var word/acc byte
L1431:
        ;;testBitwiseOperators.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
L1432:
        LD    HL,(05004H)
L1433:
        LD    A,16
L1434:
        ADD   A,12
L1435:
        AND   A,L
        LD    L,A
        LD    H,0
L1436:
        LD    A,20
L1437:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1438:
        JP    NZ,L1442
L1439:
        LD    A,118
L1440:
        CALL  writeLineA
L1441:
        JP    L1445
L1442:
        LD    HL,999
L1443:
        CALL  writeLineHL
L1444:
        ;;testBitwiseOperators.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
L1445:
        LD    HL,(05004H)
L1446:
        LD    A,16
L1447:
        ADD   A,12
L1448:
        OR    A,L
        LD    L,A
L1449:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1450:
        JP    NZ,L1454
L1451:
        LD    A,119
L1452:
        CALL  writeLineA
L1453:
        JP    L1457
L1454:
        LD    HL,999
L1455:
        CALL  writeLineHL
L1456:
        ;;testBitwiseOperators.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
L1457:
        LD    HL,(05004H)
L1458:
        LD    A,16
L1459:
        ADD   A,12
L1460:
        XOR   A,L
        LD    L,A
L1461:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1462:
        JP    NZ,L1466
L1463:
        LD    A,120
L1464:
        CALL  writeLineA
L1465:
        JP    L1473
L1466:
        LD    HL,999
L1467:
        CALL  writeLineHL
L1468:
        ;;testBitwiseOperators.j(209)   
L1469:
        ;;testBitwiseOperators.j(210)     //var/var
L1470:
        ;;testBitwiseOperators.j(211)     //*******
L1471:
        ;;testBitwiseOperators.j(212)     //var byte/var byte
L1472:
        ;;testBitwiseOperators.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
L1473:
        LD    A,(05001H)
L1474:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L1475:
        SUB   A,4
L1476:
        JP    NZ,L1480
L1477:
        LD    A,121
L1478:
        CALL  writeLineA
L1479:
        JP    L1483
L1480:
        LD    HL,999
L1481:
        CALL  writeLineHL
L1482:
        ;;testBitwiseOperators.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
L1483:
        LD    A,(05001H)
L1484:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L1485:
        SUB   A,31
L1486:
        JP    NZ,L1490
L1487:
        LD    A,122
L1488:
        CALL  writeLineA
L1489:
        JP    L1493
L1490:
        LD    HL,999
L1491:
        CALL  writeLineHL
L1492:
        ;;testBitwiseOperators.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
L1493:
        LD    A,(05001H)
L1494:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L1495:
        SUB   A,27
L1496:
        JP    NZ,L1500
L1497:
        LD    A,123
L1498:
        CALL  writeLineA
L1499:
        JP    L1504
L1500:
        LD    HL,999
L1501:
        CALL  writeLineHL
L1502:
        ;;testBitwiseOperators.j(216)     //var word/var word
L1503:
        ;;testBitwiseOperators.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
L1504:
        LD    HL,(05004H)
L1505:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1506:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1507:
        JP    NZ,L1511
L1508:
        LD    A,124
L1509:
        CALL  writeLineA
L1510:
        JP    L1514
L1511:
        LD    HL,999
L1512:
        CALL  writeLineHL
L1513:
        ;;testBitwiseOperators.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
L1514:
        LD    HL,(05004H)
L1515:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1516:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1517:
        JP    NZ,L1521
L1518:
        LD    A,125
L1519:
        CALL  writeLineA
L1520:
        JP    L1524
L1521:
        LD    HL,999
L1522:
        CALL  writeLineHL
L1523:
        ;;testBitwiseOperators.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
L1524:
        LD    HL,(05004H)
L1525:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1526:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1527:
        JP    NZ,L1531
L1528:
        LD    A,126
L1529:
        CALL  writeLineA
L1530:
        JP    L1535
L1531:
        LD    HL,999
L1532:
        CALL  writeLineHL
L1533:
        ;;testBitwiseOperators.j(220)     //var byte/var word
L1534:
        ;;testBitwiseOperators.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
L1535:
        LD    A,(05000H)
L1536:
        LD    L,A
        LD    H,0
L1537:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1538:
        LD    A,20
L1539:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1540:
        JP    NZ,L1544
L1541:
        LD    A,127
L1542:
        CALL  writeLineA
L1543:
        JP    L1547
L1544:
        LD    HL,999
L1545:
        CALL  writeLineHL
L1546:
        ;;testBitwiseOperators.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
L1547:
        LD    A,(05000H)
L1548:
        LD    L,A
        LD    H,0
L1549:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1550:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1551:
        JP    NZ,L1555
L1552:
        LD    A,128
L1553:
        CALL  writeLineA
L1554:
        JP    L1558
L1555:
        LD    HL,999
L1556:
        CALL  writeLineHL
L1557:
        ;;testBitwiseOperators.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
L1558:
        LD    A,(05000H)
L1559:
        LD    L,A
        LD    H,0
L1560:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1561:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1562:
        JP    NZ,L1566
L1563:
        LD    A,129
L1564:
        CALL  writeLineA
L1565:
        JP    L1570
L1566:
        LD    HL,999
L1567:
        CALL  writeLineHL
L1568:
        ;;testBitwiseOperators.j(224)     //var word/var byte
L1569:
        ;;testBitwiseOperators.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
L1570:
        LD    HL,(05004H)
L1571:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1572:
        LD    A,20
L1573:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1574:
        JP    NZ,L1578
L1575:
        LD    A,130
L1576:
        CALL  writeLineA
L1577:
        JP    L1581
L1578:
        LD    HL,999
L1579:
        CALL  writeLineHL
L1580:
        ;;testBitwiseOperators.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
L1581:
        LD    HL,(05004H)
L1582:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1583:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1584:
        JP    NZ,L1588
L1585:
        LD    A,131
L1586:
        CALL  writeLineA
L1587:
        JP    L1591
L1588:
        LD    HL,999
L1589:
        CALL  writeLineHL
L1590:
        ;;testBitwiseOperators.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
L1591:
        LD    HL,(05004H)
L1592:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1593:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1594:
        JP    NZ,L1598
L1595:
        LD    A,132
L1596:
        CALL  writeLineA
L1597:
        JP    L1605
L1598:
        LD    HL,999
L1599:
        CALL  writeLineHL
L1600:
        ;;testBitwiseOperators.j(228)   
L1601:
        ;;testBitwiseOperators.j(229)     //var/final var
L1602:
        ;;testBitwiseOperators.j(230)     //*************
L1603:
        ;;testBitwiseOperators.j(231)     //var byte/final var byte
L1604:
        ;;testBitwiseOperators.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
L1605:
        LD    A,(05001H)
L1606:
        AND   A,28
L1607:
        SUB   A,4
L1608:
        JP    NZ,L1612
L1609:
        LD    A,133
L1610:
        CALL  writeLineA
L1611:
        JP    L1615
L1612:
        LD    HL,999
L1613:
        CALL  writeLineHL
L1614:
        ;;testBitwiseOperators.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
L1615:
        LD    A,(05001H)
L1616:
        OR    A,28
L1617:
        SUB   A,31
L1618:
        JP    NZ,L1622
L1619:
        LD    A,134
L1620:
        CALL  writeLineA
L1621:
        JP    L1625
L1622:
        LD    HL,999
L1623:
        CALL  writeLineHL
L1624:
        ;;testBitwiseOperators.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
L1625:
        LD    A,(05001H)
L1626:
        XOR   A,28
L1627:
        SUB   A,27
L1628:
        JP    NZ,L1632
L1629:
        LD    A,135
L1630:
        CALL  writeLineA
L1631:
        JP    L1636
L1632:
        LD    HL,999
L1633:
        CALL  writeLineHL
L1634:
        ;;testBitwiseOperators.j(235)     //var word/final var word
L1635:
        ;;testBitwiseOperators.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
L1636:
        LD    HL,(05004H)
L1637:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1638:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1639:
        JP    NZ,L1643
L1640:
        LD    A,136
L1641:
        CALL  writeLineA
L1642:
        JP    L1646
L1643:
        LD    HL,999
L1644:
        CALL  writeLineHL
L1645:
        ;;testBitwiseOperators.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
L1646:
        LD    HL,(05004H)
L1647:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1648:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1649:
        JP    NZ,L1653
L1650:
        LD    A,137
L1651:
        CALL  writeLineA
L1652:
        JP    L1656
L1653:
        LD    HL,999
L1654:
        CALL  writeLineHL
L1655:
        ;;testBitwiseOperators.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
L1656:
        LD    HL,(05004H)
L1657:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1658:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1659:
        JP    NZ,L1663
L1660:
        LD    A,138
L1661:
        CALL  writeLineA
L1662:
        JP    L1667
L1663:
        LD    HL,999
L1664:
        CALL  writeLineHL
L1665:
        ;;testBitwiseOperators.j(239)     //var byte/final var word
L1666:
        ;;testBitwiseOperators.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
L1667:
        LD    A,(05000H)
L1668:
        LD    L,A
        LD    H,0
L1669:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1670:
        LD    A,20
L1671:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1672:
        JP    NZ,L1676
L1673:
        LD    A,139
L1674:
        CALL  writeLineA
L1675:
        JP    L1679
L1676:
        LD    HL,999
L1677:
        CALL  writeLineHL
L1678:
        ;;testBitwiseOperators.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
L1679:
        LD    A,(05000H)
L1680:
        LD    L,A
        LD    H,0
L1681:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1682:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1683:
        JP    NZ,L1687
L1684:
        LD    A,140
L1685:
        CALL  writeLineA
L1686:
        JP    L1690
L1687:
        LD    HL,999
L1688:
        CALL  writeLineHL
L1689:
        ;;testBitwiseOperators.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
L1690:
        LD    A,(05000H)
L1691:
        LD    L,A
        LD    H,0
L1692:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1693:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1694:
        JP    NZ,L1698
L1695:
        LD    A,141
L1696:
        CALL  writeLineA
L1697:
        JP    L1702
L1698:
        LD    HL,999
L1699:
        CALL  writeLineHL
L1700:
        ;;testBitwiseOperators.j(243)     //var word/final var byte
L1701:
        ;;testBitwiseOperators.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
L1702:
        LD    HL,(05004H)
L1703:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1704:
        LD    A,20
L1705:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1706:
        JP    NZ,L1710
L1707:
        LD    A,142
L1708:
        CALL  writeLineA
L1709:
        JP    L1713
L1710:
        LD    HL,999
L1711:
        CALL  writeLineHL
L1712:
        ;;testBitwiseOperators.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
L1713:
        LD    HL,(05004H)
L1714:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1715:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1716:
        JP    NZ,L1720
L1717:
        LD    A,143
L1718:
        CALL  writeLineA
L1719:
        JP    L1723
L1720:
        LD    HL,999
L1721:
        CALL  writeLineHL
L1722:
        ;;testBitwiseOperators.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
L1723:
        LD    HL,(05004H)
L1724:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1725:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1726:
        JP    NZ,L1730
L1727:
        LD    A,144
L1728:
        CALL  writeLineA
L1729:
        JP    L1737
L1730:
        LD    HL,999
L1731:
        CALL  writeLineHL
L1732:
        ;;testBitwiseOperators.j(247)   
L1733:
        ;;testBitwiseOperators.j(248)     //final var/constant
L1734:
        ;;testBitwiseOperators.j(249)     //******************
L1735:
        ;;testBitwiseOperators.j(250)     //final var byte/constant byte
L1736:
        ;;testBitwiseOperators.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
L1737:
        LD    A,(05001H)
L1738:
        AND   A,28
L1739:
        SUB   A,4
L1740:
        JP    NZ,L1744
L1741:
        LD    A,145
L1742:
        CALL  writeLineA
L1743:
        JP    L1747
L1744:
        LD    HL,999
L1745:
        CALL  writeLineHL
L1746:
        ;;testBitwiseOperators.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
L1747:
        LD    A,(05001H)
L1748:
        OR    A,28
L1749:
        SUB   A,31
L1750:
        JP    NZ,L1754
L1751:
        LD    A,146
L1752:
        CALL  writeLineA
L1753:
        JP    L1757
L1754:
        LD    HL,999
L1755:
        CALL  writeLineHL
L1756:
        ;;testBitwiseOperators.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
L1757:
        LD    A,(05001H)
L1758:
        XOR   A,28
L1759:
        SUB   A,27
L1760:
        JP    NZ,L1764
L1761:
        LD    A,147
L1762:
        CALL  writeLineA
L1763:
        JP    L1768
L1764:
        LD    HL,999
L1765:
        CALL  writeLineHL
L1766:
        ;;testBitwiseOperators.j(254)     //final var word/constant word
L1767:
        ;;testBitwiseOperators.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
L1768:
        LD    HL,(05004H)
L1769:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1770:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1771:
        JP    NZ,L1775
L1772:
        LD    A,148
L1773:
        CALL  writeLineA
L1774:
        JP    L1778
L1775:
        LD    HL,999
L1776:
        CALL  writeLineHL
L1777:
        ;;testBitwiseOperators.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
L1778:
        LD    HL,(05004H)
L1779:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1780:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1781:
        JP    NZ,L1785
L1782:
        LD    A,149
L1783:
        CALL  writeLineA
L1784:
        JP    L1788
L1785:
        LD    HL,999
L1786:
        CALL  writeLineHL
L1787:
        ;;testBitwiseOperators.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
L1788:
        LD    HL,(05004H)
L1789:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1790:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1791:
        JP    NZ,L1795
L1792:
        LD    A,150
L1793:
        CALL  writeLineA
L1794:
        JP    L1799
L1795:
        LD    HL,999
L1796:
        CALL  writeLineHL
L1797:
        ;;testBitwiseOperators.j(258)     //final var byte/constant word
L1798:
        ;;testBitwiseOperators.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
L1799:
        LD    A,(05000H)
L1800:
        LD    L,A
        LD    H,0
L1801:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1802:
        LD    A,20
L1803:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1804:
        JP    NZ,L1808
L1805:
        LD    A,151
L1806:
        CALL  writeLineA
L1807:
        JP    L1811
L1808:
        LD    HL,999
L1809:
        CALL  writeLineHL
L1810:
        ;;testBitwiseOperators.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
L1811:
        LD    A,(05000H)
L1812:
        LD    L,A
        LD    H,0
L1813:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1814:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1815:
        JP    NZ,L1819
L1816:
        LD    A,152
L1817:
        CALL  writeLineA
L1818:
        JP    L1822
L1819:
        LD    HL,999
L1820:
        CALL  writeLineHL
L1821:
        ;;testBitwiseOperators.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
L1822:
        LD    A,(05000H)
L1823:
        LD    L,A
        LD    H,0
L1824:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1825:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1826:
        JP    NZ,L1830
L1827:
        LD    A,153
L1828:
        CALL  writeLineA
L1829:
        JP    L1834
L1830:
        LD    HL,999
L1831:
        CALL  writeLineHL
L1832:
        ;;testBitwiseOperators.j(262)     //final var word/constant byte
L1833:
        ;;testBitwiseOperators.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
L1834:
        LD    HL,(05004H)
L1835:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1836:
        LD    A,20
L1837:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1838:
        JP    NZ,L1842
L1839:
        LD    A,154
L1840:
        CALL  writeLineA
L1841:
        JP    L1845
L1842:
        LD    HL,999
L1843:
        CALL  writeLineHL
L1844:
        ;;testBitwiseOperators.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
L1845:
        LD    HL,(05004H)
L1846:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1847:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1848:
        JP    NZ,L1852
L1849:
        LD    A,155
L1850:
        CALL  writeLineA
L1851:
        JP    L1855
L1852:
        LD    HL,999
L1853:
        CALL  writeLineHL
L1854:
        ;;testBitwiseOperators.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
L1855:
        LD    HL,(05004H)
L1856:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1857:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1858:
        JP    NZ,L1862
L1859:
        LD    A,156
L1860:
        CALL  writeLineA
L1861:
        JP    L1869
L1862:
        LD    HL,999
L1863:
        CALL  writeLineHL
L1864:
        ;;testBitwiseOperators.j(266)   
L1865:
        ;;testBitwiseOperators.j(267)     //final var/acc
L1866:
        ;;testBitwiseOperators.j(268)     //*************
L1867:
        ;;testBitwiseOperators.j(269)     //final var byte/acc byte
L1868:
        ;;testBitwiseOperators.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
L1869:
        LD    A,(05001H)
L1870:
        PUSH  AF
        LD    A,16
L1871:
        ADD   A,12
L1872:
        POP   BC
        AND   A,B
L1873:
        SUB   A,4
L1874:
        JP    NZ,L1878
L1875:
        LD    A,157
L1876:
        CALL  writeLineA
L1877:
        JP    L1881
L1878:
        LD    HL,999
L1879:
        CALL  writeLineHL
L1880:
        ;;testBitwiseOperators.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
L1881:
        LD    A,(05001H)
L1882:
        PUSH  AF
        LD    A,16
L1883:
        ADD   A,12
L1884:
        POP   BC
        OR    A,B
L1885:
        SUB   A,31
L1886:
        JP    NZ,L1890
L1887:
        LD    A,158
L1888:
        CALL  writeLineA
L1889:
        JP    L1893
L1890:
        LD    HL,999
L1891:
        CALL  writeLineHL
L1892:
        ;;testBitwiseOperators.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
L1893:
        LD    A,(05001H)
L1894:
        PUSH  AF
        LD    A,16
L1895:
        ADD   A,12
L1896:
        POP   BC
        XOR   A,B
L1897:
        SUB   A,27
L1898:
        JP    NZ,L1902
L1899:
        LD    A,159
L1900:
        CALL  writeLineA
L1901:
        JP    L1906
L1902:
        LD    HL,999
L1903:
        CALL  writeLineHL
L1904:
        ;;testBitwiseOperators.j(273)     //final var word/acc word
L1905:
        ;;testBitwiseOperators.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
L1906:
        LD    HL,(05004H)
L1907:
        PUSH  HL
        LD    HL,256
L1908:
        LD    DE,556
        ADD   HL,DE
L1909:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1910:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1911:
        JP    NZ,L1915
L1912:
        LD    A,160
L1913:
        CALL  writeLineA
L1914:
        JP    L1918
L1915:
        LD    HL,999
L1916:
        CALL  writeLineHL
L1917:
        ;;testBitwiseOperators.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
L1918:
        LD    HL,(05004H)
L1919:
        PUSH  HL
        LD    HL,256
L1920:
        LD    DE,556
        ADD   HL,DE
L1921:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1922:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1923:
        JP    NZ,L1927
L1924:
        LD    A,161
L1925:
        CALL  writeLineA
L1926:
        JP    L1930
L1927:
        LD    HL,999
L1928:
        CALL  writeLineHL
L1929:
        ;;testBitwiseOperators.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
L1930:
        LD    HL,(05004H)
L1931:
        PUSH  HL
        LD    HL,256
L1932:
        LD    DE,556
        ADD   HL,DE
L1933:
        POP   DE
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L1934:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1935:
        JP    NZ,L1939
L1936:
        LD    A,162
L1937:
        CALL  writeLineA
L1938:
        JP    L1943
L1939:
        LD    HL,999
L1940:
        CALL  writeLineHL
L1941:
        ;;testBitwiseOperators.j(277)     //final var byte/acc word
L1942:
        ;;testBitwiseOperators.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
L1943:
        LD    A,(05000H)
L1944:
        LD    HL,4096
L1945:
        LD    DE,564
        ADD   HL,DE
L1946:
        AND   A,L
        LD    L,A
        LD    H,0
L1947:
        LD    A,20
L1948:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1949:
        JP    NZ,L1953
L1950:
        LD    A,163
L1951:
        CALL  writeLineA
L1952:
        JP    L1956
L1953:
        LD    HL,999
L1954:
        CALL  writeLineHL
L1955:
        ;;testBitwiseOperators.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
L1956:
        LD    A,(05000H)
L1957:
        LD    HL,4096
L1958:
        LD    DE,564
        ADD   HL,DE
L1959:
        OR    A,L
        LD    L,A
L1960:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1961:
        JP    NZ,L1965
L1962:
        LD    A,164
L1963:
        CALL  writeLineA
L1964:
        JP    L1968
L1965:
        LD    HL,999
L1966:
        CALL  writeLineHL
L1967:
        ;;testBitwiseOperators.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
L1968:
        LD    A,(05000H)
L1969:
        LD    HL,4096
L1970:
        LD    DE,564
        ADD   HL,DE
L1971:
        XOR   A,L
        LD    L,A
L1972:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1973:
        JP    NZ,L1977
L1974:
        LD    A,165
L1975:
        CALL  writeLineA
L1976:
        JP    L1981
L1977:
        LD    HL,999
L1978:
        CALL  writeLineHL
L1979:
        ;;testBitwiseOperators.j(281)     //final var word/acc byte
L1980:
        ;;testBitwiseOperators.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
L1981:
        LD    HL,(05004H)
L1982:
        LD    A,16
L1983:
        ADD   A,12
L1984:
        AND   A,L
        LD    L,A
        LD    H,0
L1985:
        LD    A,20
L1986:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1987:
        JP    NZ,L1991
L1988:
        LD    A,166
L1989:
        CALL  writeLineA
L1990:
        JP    L1994
L1991:
        LD    HL,999
L1992:
        CALL  writeLineHL
L1993:
        ;;testBitwiseOperators.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
L1994:
        LD    HL,(05004H)
L1995:
        LD    A,16
L1996:
        ADD   A,12
L1997:
        OR    A,L
        LD    L,A
L1998:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1999:
        JP    NZ,L2003
L2000:
        LD    A,167
L2001:
        CALL  writeLineA
L2002:
        JP    L2006
L2003:
        LD    HL,999
L2004:
        CALL  writeLineHL
L2005:
        ;;testBitwiseOperators.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
L2006:
        LD    HL,(05004H)
L2007:
        LD    A,16
L2008:
        ADD   A,12
L2009:
        XOR   A,L
        LD    L,A
L2010:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2011:
        JP    NZ,L2015
L2012:
        LD    A,168
L2013:
        CALL  writeLineA
L2014:
        JP    L2022
L2015:
        LD    HL,999
L2016:
        CALL  writeLineHL
L2017:
        ;;testBitwiseOperators.j(285)   
L2018:
        ;;testBitwiseOperators.j(286)     //final var/var
L2019:
        ;;testBitwiseOperators.j(287)     //*************
L2020:
        ;;testBitwiseOperators.j(288)     //final var byte/var byte
L2021:
        ;;testBitwiseOperators.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
L2022:
        LD    A,(05001H)
L2023:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L2024:
        SUB   A,4
L2025:
        JP    NZ,L2029
L2026:
        LD    A,169
L2027:
        CALL  writeLineA
L2028:
        JP    L2032
L2029:
        LD    HL,999
L2030:
        CALL  writeLineHL
L2031:
        ;;testBitwiseOperators.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
L2032:
        LD    A,(05001H)
L2033:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L2034:
        SUB   A,31
L2035:
        JP    NZ,L2039
L2036:
        LD    A,170
L2037:
        CALL  writeLineA
L2038:
        JP    L2042
L2039:
        LD    HL,999
L2040:
        CALL  writeLineHL
L2041:
        ;;testBitwiseOperators.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
L2042:
        LD    A,(05001H)
L2043:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L2044:
        SUB   A,27
L2045:
        JP    NZ,L2049
L2046:
        LD    A,171
L2047:
        CALL  writeLineA
L2048:
        JP    L2053
L2049:
        LD    HL,999
L2050:
        CALL  writeLineHL
L2051:
        ;;testBitwiseOperators.j(292)     //final var word/var word
L2052:
        ;;testBitwiseOperators.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
L2053:
        LD    HL,(05004H)
L2054:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2055:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2056:
        JP    NZ,L2060
L2057:
        LD    A,172
L2058:
        CALL  writeLineA
L2059:
        JP    L2063
L2060:
        LD    HL,999
L2061:
        CALL  writeLineHL
L2062:
        ;;testBitwiseOperators.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
L2063:
        LD    HL,(05004H)
L2064:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2065:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2066:
        JP    NZ,L2070
L2067:
        LD    A,173
L2068:
        CALL  writeLineA
L2069:
        JP    L2073
L2070:
        LD    HL,999
L2071:
        CALL  writeLineHL
L2072:
        ;;testBitwiseOperators.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
L2073:
        LD    HL,(05004H)
L2074:
        LD    DE,(05002H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2075:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2076:
        JP    NZ,L2080
L2077:
        LD    A,174
L2078:
        CALL  writeLineA
L2079:
        JP    L2084
L2080:
        LD    HL,999
L2081:
        CALL  writeLineHL
L2082:
        ;;testBitwiseOperators.j(296)     //final var byte/var word
L2083:
        ;;testBitwiseOperators.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
L2084:
        LD    A,(05000H)
L2085:
        LD    L,A
        LD    H,0
L2086:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2087:
        LD    A,20
L2088:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2089:
        JP    NZ,L2093
L2090:
        LD    A,175
L2091:
        CALL  writeLineA
L2092:
        JP    L2096
L2093:
        LD    HL,999
L2094:
        CALL  writeLineHL
L2095:
        ;;testBitwiseOperators.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
L2096:
        LD    A,(05000H)
L2097:
        LD    L,A
        LD    H,0
L2098:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2099:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2100:
        JP    NZ,L2104
L2101:
        LD    A,176
L2102:
        CALL  writeLineA
L2103:
        JP    L2107
L2104:
        LD    HL,999
L2105:
        CALL  writeLineHL
L2106:
        ;;testBitwiseOperators.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
L2107:
        LD    A,(05000H)
L2108:
        LD    L,A
        LD    H,0
L2109:
        LD    DE,(05004H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2110:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2111:
        JP    NZ,L2115
L2112:
        LD    A,177
L2113:
        CALL  writeLineA
L2114:
        JP    L2119
L2115:
        LD    HL,999
L2116:
        CALL  writeLineHL
L2117:
        ;;testBitwiseOperators.j(300)     //final var word/var byte
L2118:
        ;;testBitwiseOperators.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
L2119:
        LD    HL,(05004H)
L2120:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2121:
        LD    A,20
L2122:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2123:
        JP    NZ,L2127
L2124:
        LD    A,178
L2125:
        CALL  writeLineA
L2126:
        JP    L2130
L2127:
        LD    HL,999
L2128:
        CALL  writeLineHL
L2129:
        ;;testBitwiseOperators.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
L2130:
        LD    HL,(05004H)
L2131:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2132:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2133:
        JP    NZ,L2137
L2134:
        LD    A,179
L2135:
        CALL  writeLineA
L2136:
        JP    L2140
L2137:
        LD    HL,999
L2138:
        CALL  writeLineHL
L2139:
        ;;testBitwiseOperators.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
L2140:
        LD    HL,(05004H)
L2141:
        LD    DE,(05000H)
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2142:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2143:
        JP    NZ,L2147
L2144:
        LD    A,180
L2145:
        CALL  writeLineA
L2146:
        JP    L2154
L2147:
        LD    HL,999
L2148:
        CALL  writeLineHL
L2149:
        ;;testBitwiseOperators.j(304)   
L2150:
        ;;testBitwiseOperators.j(305)     //final var/final var
L2151:
        ;;testBitwiseOperators.j(306)     //*******************
L2152:
        ;;testBitwiseOperators.j(307)     //final var byte/final var byte
L2153:
        ;;testBitwiseOperators.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
L2154:
        LD    A,7
L2155:
        AND   A,28
L2156:
        SUB   A,4
L2157:
        JP    NZ,L2161
L2158:
        LD    A,181
L2159:
        CALL  writeLineA
L2160:
        JP    L2164
L2161:
        LD    HL,999
L2162:
        CALL  writeLineHL
L2163:
        ;;testBitwiseOperators.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
L2164:
        LD    A,7
L2165:
        OR    A,28
L2166:
        SUB   A,31
L2167:
        JP    NZ,L2171
L2168:
        LD    A,182
L2169:
        CALL  writeLineA
L2170:
        JP    L2174
L2171:
        LD    HL,999
L2172:
        CALL  writeLineHL
L2173:
        ;;testBitwiseOperators.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
L2174:
        LD    A,7
L2175:
        XOR   A,28
L2176:
        SUB   A,27
L2177:
        JP    NZ,L2181
L2178:
        LD    A,183
L2179:
        CALL  writeLineA
L2180:
        JP    L2185
L2181:
        LD    HL,999
L2182:
        CALL  writeLineHL
L2183:
        ;;testBitwiseOperators.j(311)     //final var word/final var word
L2184:
        ;;testBitwiseOperators.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
L2185:
        LD    HL,4660
L2186:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2187:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2188:
        JP    NZ,L2192
L2189:
        LD    A,184
L2190:
        CALL  writeLineA
L2191:
        JP    L2195
L2192:
        LD    HL,999
L2193:
        CALL  writeLineHL
L2194:
        ;;testBitwiseOperators.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
L2195:
        LD    HL,4660
L2196:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2197:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2198:
        JP    NZ,L2202
L2199:
        LD    A,185
L2200:
        CALL  writeLineA
L2201:
        JP    L2205
L2202:
        LD    HL,999
L2203:
        CALL  writeLineHL
L2204:
        ;;testBitwiseOperators.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
L2205:
        LD    HL,4660
L2206:
        LD    DE,812
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2207:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2208:
        JP    NZ,L2212
L2209:
        LD    A,186
L2210:
        CALL  writeLineA
L2211:
        JP    L2216
L2212:
        LD    HL,999
L2213:
        CALL  writeLineHL
L2214:
        ;;testBitwiseOperators.j(315)     //final var byte/final var word
L2215:
        ;;testBitwiseOperators.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
L2216:
        LD    A,28
L2217:
        LD    L,A
        LD    H,0
L2218:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2219:
        LD    A,20
L2220:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2221:
        JP    NZ,L2225
L2222:
        LD    A,187
L2223:
        CALL  writeLineA
L2224:
        JP    L2228
L2225:
        LD    HL,999
L2226:
        CALL  writeLineHL
L2227:
        ;;testBitwiseOperators.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
L2228:
        LD    A,28
L2229:
        LD    L,A
        LD    H,0
L2230:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2231:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2232:
        JP    NZ,L2236
L2233:
        LD    A,188
L2234:
        CALL  writeLineA
L2235:
        JP    L2239
L2236:
        LD    HL,999
L2237:
        CALL  writeLineHL
L2238:
        ;;testBitwiseOperators.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
L2239:
        LD    A,28
L2240:
        LD    L,A
        LD    H,0
L2241:
        LD    DE,4660
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2242:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2243:
        JP    NZ,L2247
L2244:
        LD    A,189
L2245:
        CALL  writeLineA
L2246:
        JP    L2251
L2247:
        LD    HL,999
L2248:
        CALL  writeLineHL
L2249:
        ;;testBitwiseOperators.j(319)     //final var word/final var byte
L2250:
        ;;testBitwiseOperators.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
L2251:
        LD    HL,4660
L2252:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        AND   A,D
        LD    H,A
        LD    A,L
        AND   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2253:
        LD    A,20
L2254:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2255:
        JP    NZ,L2259
L2256:
        LD    A,190
L2257:
        CALL  writeLineA
L2258:
        JP    L2262
L2259:
        LD    HL,999
L2260:
        CALL  writeLineHL
L2261:
        ;;testBitwiseOperators.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
L2262:
        LD    HL,4660
L2263:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2264:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2265:
        JP    NZ,L2269
L2266:
        LD    A,191
L2267:
        CALL  writeLineA
L2268:
        JP    L2272
L2269:
        LD    HL,999
L2270:
        CALL  writeLineHL
L2271:
        ;;testBitwiseOperators.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
L2272:
        LD    HL,4660
L2273:
        LD    DE,28
        PUSH  BC
        LD    B,A
        LD    A,H
        XOR   A,D
        LD    H,A
        LD    A,L
        XOR   A,E
        LD    L,A
        LD    A,B
        POP   BC
L2274:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2275:
        JP    NZ,L2279
L2276:
        LD    A,192
L2277:
        CALL  writeLineA
L2278:
        JP    L2283
L2279:
        LD    HL,999
L2280:
        CALL  writeLineHL
L2281:
        ;;testBitwiseOperators.j(323)   
L2282:
        ;;testBitwiseOperators.j(324)     println("Klaar");
L2283:
        LD    HL,L2290
L2284:
        CALL  writeLineStr
L2285:
        ;;testBitwiseOperators.j(325)   }
L2286:
        LD    SP,IX
L2287:
        POP   IX
L2288:
        return
L2289:
        ;;testBitwiseOperators.j(326) }
L2290:
        .ASCIZ  "Klaar"
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
