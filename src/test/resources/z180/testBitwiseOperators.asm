SOC     equ 02000H        ;start of code, i.e.lowest external RAM address.
TOS     equ 0FD00H        ;top of stack, i.e. bottom of MONITOR user global data.
        .ORG  SOC
start:
        LD    SP,TOS
L0:
        CALL  L23
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
        ;;testBitwiseOperators.j(6)   private static final byte fb1 = 0x1C;
L18:
        ;;testBitwiseOperators.j(7)   private static final byte fb2 = 0x07;
L19:
        ;;testBitwiseOperators.j(8)   private static final word fw1 = 0x032C;
L20:
        ;;testBitwiseOperators.j(9)   private static final word fw2 = 0x1234;
L21:
        ;;testBitwiseOperators.j(10) 
L22:
        ;;testBitwiseOperators.j(11)   public static void main() {
L23:
        ;method TestBitwiseOperators.main [public, static] void ()
L24:
        PUSH  IX
L25:
        LD    IX,0x0000
        ADD   IX,SP
L26:
L27:
        ;;testBitwiseOperators.j(12)     println(0);
L28:
        LD    A,0
L29:
        CALL  writeLineA
L30:
        ;;testBitwiseOperators.j(13)     
L31:
        ;;testBitwiseOperators.j(14)     // Possible operand types: constant, acc, var, final var, stack8, stack16.
L32:
        ;;testBitwiseOperators.j(15)     // Possible data types: byte, word.
L33:
        ;;testBitwiseOperators.j(16)   
L34:
        ;;testBitwiseOperators.j(17)     //constant/constant
L35:
        ;;testBitwiseOperators.j(18)     //*****************
L36:
        ;;testBitwiseOperators.j(19)     //constant byte/constant byte
L37:
        ;;testBitwiseOperators.j(20)     if (0x07 & 0x1C == 0x04) println (1); else println (999); //0000.0111 & 0001.1100 = 0000.0100
L38:
        LD    A,7
L39:
        AND   A,28
L40:
        SUB   A,4
L41:
        JP    NZ,L47
L42:
        LD    A,1
L43:
        CALL  writeLineA
L44:
        JP    L50
L45:
        LD    HL,999
L46:
        CALL  writeLineHL
L47:
        ;;testBitwiseOperators.j(21)     if (0x07 | 0x1C == 0x1F) println (2); else println (999); //0000.0111 | 0001.1100 = 0001.1111
L48:
        LD    A,7
L49:
        OR    A,28
L50:
        SUB   A,31
L51:
        JP    NZ,L59
L52:
        LD    A,2
L53:
        CALL  writeLineA
L54:
        JP    L62
L55:
        LD    HL,999
L56:
        CALL  writeLineHL
L57:
        ;;testBitwiseOperators.j(22)     if (0x07 ^ 0x1C == 0x1B) println (3); else println (999); //0000.0111 ^ 0001.1100 = 0001.1011
L58:
        LD    A,7
L59:
        XOR   A,28
L60:
        SUB   A,27
L61:
        JP    NZ,L71
L62:
        LD    A,3
L63:
        CALL  writeLineA
L64:
        JP    L75
L65:
        LD    HL,999
L66:
        CALL  writeLineHL
L67:
        ;;testBitwiseOperators.j(23)     //constant word/constant word
L68:
        ;;testBitwiseOperators.j(24)     if (0x1234 & 0x032C == 0x0224) println (4); else println (999);
L69:
        LD    HL,4660
L70:
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
L71:
        LD    DE,548
        OR    A
        SBC   HL,DE
L72:
        JP    NZ,L84
L73:
        LD    A,4
L74:
        CALL  writeLineA
L75:
        JP    L88
L76:
        LD    HL,999
L77:
        CALL  writeLineHL
L78:
        ;;testBitwiseOperators.j(25)     //0001.0010.0011.0100 & 0000.0011.0010.1100 = 0000.0010.0010.0100
L79:
        ;;testBitwiseOperators.j(26)     if (0x1234 | 0x032C == 0x133C) println (5); else println (999);
L80:
        LD    HL,4660
L81:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L82:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L83:
        JP    NZ,L97
L84:
        LD    A,5
L85:
        CALL  writeLineA
L86:
        JP    L101
L87:
        LD    HL,999
L88:
        CALL  writeLineHL
L89:
        ;;testBitwiseOperators.j(27)     //0001.0010.0011.0100 | 0000.0011.0010.1100 = 0001.0011.0011.1100
L90:
        ;;testBitwiseOperators.j(28)     if (0x1234 ^ 0x032C == 0x1118) println (6); else println (999);
L91:
        LD    HL,4660
L92:
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
L93:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L94:
        JP    NZ,L110
L95:
        LD    A,6
L96:
        CALL  writeLineA
L97:
        JP    L115
L98:
        LD    HL,999
L99:
        CALL  writeLineHL
L100:
        ;;testBitwiseOperators.j(29)     //0001.0010.0011.0100 ^ 0000.0011.0010.1100 = 0001.0001.0001.1000
L101:
        ;;testBitwiseOperators.j(30)     //constant byte/constant word
L102:
        ;;testBitwiseOperators.j(31)     if (0x1C & 0x1234 == 0x0014) println (7); else println (999); //0001.1100 & 0001.0010.0011.0100 = 0000.0000.0001.0100
L103:
        LD    A,28
L104:
        LD    L,A
        LD    H,0
L105:
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
L106:
        LD    A,20
L107:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L108:
        JP    NZ,L126
L109:
        LD    A,7
L110:
        CALL  writeLineA
L111:
        JP    L129
L112:
        LD    HL,999
L113:
        CALL  writeLineHL
L114:
        ;;testBitwiseOperators.j(32)     if (0x1C | 0x1234 == 0x123C) println (8); else println (999); //0001.1100 | 0001.0010.0011.0100 = 0001.0010.0011.1100
L115:
        LD    A,28
L116:
        LD    L,A
        LD    H,0
L117:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L118:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L119:
        JP    NZ,L139
L120:
        LD    A,8
L121:
        CALL  writeLineA
L122:
        JP    L142
L123:
        LD    HL,999
L124:
        CALL  writeLineHL
L125:
        ;;testBitwiseOperators.j(33)     if (0x1C ^ 0x1234 == 0x1228) println (9); else println (999); //0001.1100 ^ 0001.0010.0011.0100 = 0001.0010.0010.1000
L126:
        LD    A,28
L127:
        LD    L,A
        LD    H,0
L128:
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
L129:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L130:
        JP    NZ,L152
L131:
        LD    A,9
L132:
        CALL  writeLineA
L133:
        JP    L156
L134:
        LD    HL,999
L135:
        CALL  writeLineHL
L136:
        ;;testBitwiseOperators.j(34)     //constant word/constant byte
L137:
        ;;testBitwiseOperators.j(35)     if (0x1234 & 0x1C == 0x0014) println (10); else println (999); //0001.0010.0011.0100 & 0001.1100 = 0000.0000.0001.0100
L138:
        LD    HL,4660
L139:
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
L140:
        LD    A,20
L141:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L142:
        JP    NZ,L166
L143:
        LD    A,10
L144:
        CALL  writeLineA
L145:
        JP    L169
L146:
        LD    HL,999
L147:
        CALL  writeLineHL
L148:
        ;;testBitwiseOperators.j(36)     if (0x1234 | 0x1C == 0x123C) println (11); else println (999); //0001.0010.0011.0100 | 0001.1100 = 0001.0010.0011.1100
L149:
        LD    HL,4660
L150:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L151:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L152:
        JP    NZ,L178
L153:
        LD    A,11
L154:
        CALL  writeLineA
L155:
        JP    L181
L156:
        LD    HL,999
L157:
        CALL  writeLineHL
L158:
        ;;testBitwiseOperators.j(37)     if (0x1234 ^ 0x1C == 0x1228) println (12); else println (999); //0001.0010.0011.0100 ^ 0001.1100 = 0001.0010.0010.1000
L159:
        LD    HL,4660
L160:
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
L161:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L162:
        JP    NZ,L190
L163:
        LD    A,12
L164:
        CALL  writeLineA
L165:
        JP    L197
L166:
        LD    HL,999
L167:
        CALL  writeLineHL
L168:
        ;;testBitwiseOperators.j(38)   
L169:
        ;;testBitwiseOperators.j(39)     //constant/acc
L170:
        ;;testBitwiseOperators.j(40)     //************
L171:
        ;;testBitwiseOperators.j(41)     //constant byte/acc byte
L172:
        ;;testBitwiseOperators.j(42)     if (0x07 & (0x10 + 0x0C) == 0x04) println (13); else println (999);
L173:
        LD    A,7
L174:
        PUSH  AF
        LD    A,16
L175:
        ADD   A,12
L176:
        POP   BC
        AND   A,B
L177:
        SUB   A,4
L178:
        JP    NZ,L208
L179:
        LD    A,13
L180:
        CALL  writeLineA
L181:
        JP    L211
L182:
        LD    HL,999
L183:
        CALL  writeLineHL
L184:
        ;;testBitwiseOperators.j(43)     if (0x07 | (0x10 + 0x0C) == 0x1F) println (14); else println (999);
L185:
        LD    A,7
L186:
        PUSH  AF
        LD    A,16
L187:
        ADD   A,12
L188:
        POP   BC
        OR    A,B
L189:
        SUB   A,31
L190:
        JP    NZ,L222
L191:
        LD    A,14
L192:
        CALL  writeLineA
L193:
        JP    L225
L194:
        LD    HL,999
L195:
        CALL  writeLineHL
L196:
        ;;testBitwiseOperators.j(44)     if (0x07 ^ (0x10 + 0x0C) == 0x1B) println (15); else println (999);
L197:
        LD    A,7
L198:
        PUSH  AF
        LD    A,16
L199:
        ADD   A,12
L200:
        POP   BC
        XOR   A,B
L201:
        SUB   A,27
L202:
        JP    NZ,L236
L203:
        LD    A,15
L204:
        CALL  writeLineA
L205:
        JP    L240
L206:
        LD    HL,999
L207:
        CALL  writeLineHL
L208:
        ;;testBitwiseOperators.j(45)     //constant word/acc word
L209:
        ;;testBitwiseOperators.j(46)     if (0x1234 & 0x0100 + 0x022C == 0x0224) println (16); else println (999);
L210:
        LD    HL,4660
L211:
        PUSH  HL
        LD    HL,256
L212:
        LD    DE,556
        ADD   HL,DE
L213:
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
L214:
        LD    DE,548
        OR    A
        SBC   HL,DE
L215:
        JP    NZ,L251
L216:
        LD    A,16
L217:
        CALL  writeLineA
L218:
        JP    L254
L219:
        LD    HL,999
L220:
        CALL  writeLineHL
L221:
        ;;testBitwiseOperators.j(47)     if (0x1234 | 0x0100 + 0x022C == 0x133C) println (17); else println (999);
L222:
        LD    HL,4660
L223:
        PUSH  HL
        LD    HL,256
L224:
        LD    DE,556
        ADD   HL,DE
L225:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L226:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L227:
        JP    NZ,L265
L228:
        LD    A,17
L229:
        CALL  writeLineA
L230:
        JP    L268
L231:
        LD    HL,999
L232:
        CALL  writeLineHL
L233:
        ;;testBitwiseOperators.j(48)     if (0x1234 ^ 0x0100 + 0x022C == 0x1118) println (18); else println (999);
L234:
        LD    HL,4660
L235:
        PUSH  HL
        LD    HL,256
L236:
        LD    DE,556
        ADD   HL,DE
L237:
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
L238:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L239:
        JP    NZ,L279
L240:
        LD    A,18
L241:
        CALL  writeLineA
L242:
        JP    L283
L243:
        LD    HL,999
L244:
        CALL  writeLineHL
L245:
        ;;testBitwiseOperators.j(49)     //constant byte/acc word
L246:
        ;;testBitwiseOperators.j(50)     if (0x1C & 0x1000 + 0x0234 == 0x0014) println (19); else println (999);
L247:
        LD    A,28
L248:
        LD    HL,4096
L249:
        LD    DE,564
        ADD   HL,DE
L250:
        AND   A,L
        LD    L,A
        LD    H,0
L251:
        LD    A,20
L252:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L253:
        JP    NZ,L295
L254:
        LD    A,19
L255:
        CALL  writeLineA
L256:
        JP    L298
L257:
        LD    HL,999
L258:
        CALL  writeLineHL
L259:
        ;;testBitwiseOperators.j(51)     if (0x1C | 0x1000 + 0x0234 == 0x123C) println (20); else println (999);
L260:
        LD    A,28
L261:
        LD    HL,4096
L262:
        LD    DE,564
        ADD   HL,DE
L263:
        OR    A,L
        LD    L,A
L264:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L265:
        JP    NZ,L309
L266:
        LD    A,20
L267:
        CALL  writeLineA
L268:
        JP    L312
L269:
        LD    HL,999
L270:
        CALL  writeLineHL
L271:
        ;;testBitwiseOperators.j(52)     if (0x1C ^ 0x1000 + 0x0234 == 0x1228) println (21); else println (999);
L272:
        LD    A,28
L273:
        LD    HL,4096
L274:
        LD    DE,564
        ADD   HL,DE
L275:
        XOR   A,L
        LD    L,A
L276:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L277:
        JP    NZ,L323
L278:
        LD    A,21
L279:
        CALL  writeLineA
L280:
        JP    L327
L281:
        LD    HL,999
L282:
        CALL  writeLineHL
L283:
        ;;testBitwiseOperators.j(53)     //constant word/acc byte
L284:
        ;;testBitwiseOperators.j(54)     if (0x1234 & 0x10 + 0x0C == 0x0014) println (22); else println (999);
L285:
        LD    HL,4660
L286:
        LD    A,16
L287:
        ADD   A,12
L288:
        AND   A,L
        LD    L,A
        LD    H,0
L289:
        LD    A,20
L290:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L291:
        JP    NZ,L339
L292:
        LD    A,22
L293:
        CALL  writeLineA
L294:
        JP    L342
L295:
        LD    HL,999
L296:
        CALL  writeLineHL
L297:
        ;;testBitwiseOperators.j(55)     if (0x1234 | 0x10 + 0x0C == 0x123C) println (23); else println (999);
L298:
        LD    HL,4660
L299:
        LD    A,16
L300:
        ADD   A,12
L301:
        OR    A,L
        LD    L,A
L302:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L303:
        JP    NZ,L353
L304:
        LD    A,23
L305:
        CALL  writeLineA
L306:
        JP    L356
L307:
        LD    HL,999
L308:
        CALL  writeLineHL
L309:
        ;;testBitwiseOperators.j(56)     if (0x1234 ^ 0x10 + 0x0C == 0x1228) println (24); else println (999);
L310:
        LD    HL,4660
L311:
        LD    A,16
L312:
        ADD   A,12
L313:
        XOR   A,L
        LD    L,A
L314:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L315:
        JP    NZ,L367
L316:
        LD    A,24
L317:
        CALL  writeLineA
L318:
        JP    L374
L319:
        LD    HL,999
L320:
        CALL  writeLineHL
L321:
        ;;testBitwiseOperators.j(57)   
L322:
        ;;testBitwiseOperators.j(58)     //constant/var
L323:
        ;;testBitwiseOperators.j(59)     //*****************
L324:
        ;;testBitwiseOperators.j(60)     //constant byte/var byte
L325:
        ;;testBitwiseOperators.j(61)     if (0x07 & b1 == 0x04) println (25); else println (999);
L326:
        LD    A,7
L327:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L328:
        SUB   A,4
L329:
        JP    NZ,L383
L330:
        LD    A,25
L331:
        CALL  writeLineA
L332:
        JP    L386
L333:
        LD    HL,999
L334:
        CALL  writeLineHL
L335:
        ;;testBitwiseOperators.j(62)     if (0x07 | b1 == 0x1F) println (26); else println (999);
L336:
        LD    A,7
L337:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L338:
        SUB   A,31
L339:
        JP    NZ,L395
L340:
        LD    A,26
L341:
        CALL  writeLineA
L342:
        JP    L398
L343:
        LD    HL,999
L344:
        CALL  writeLineHL
L345:
        ;;testBitwiseOperators.j(63)     if (0x07 ^ b1 == 0x1B) println (27); else println (999);
L346:
        LD    A,7
L347:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L348:
        SUB   A,27
L349:
        JP    NZ,L407
L350:
        LD    A,27
L351:
        CALL  writeLineA
L352:
        JP    L411
L353:
        LD    HL,999
L354:
        CALL  writeLineHL
L355:
        ;;testBitwiseOperators.j(64)     //constant word/var word
L356:
        ;;testBitwiseOperators.j(65)     if (0x1234 & w1 == 0x0224) println (28); else println (999);
L357:
        LD    HL,4660
L358:
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
L359:
        LD    DE,548
        OR    A
        SBC   HL,DE
L360:
        JP    NZ,L420
L361:
        LD    A,28
L362:
        CALL  writeLineA
L363:
        JP    L423
L364:
        LD    HL,999
L365:
        CALL  writeLineHL
L366:
        ;;testBitwiseOperators.j(66)     if (0x1234 | w1 == 0x133C) println (29); else println (999);
L367:
        LD    HL,4660
L368:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L369:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L370:
        JP    NZ,L432
L371:
        LD    A,29
L372:
        CALL  writeLineA
L373:
        JP    L435
L374:
        LD    HL,999
L375:
        CALL  writeLineHL
L376:
        ;;testBitwiseOperators.j(67)     if (0x1234 ^ w1 == 0x1118) println (30); else println (999);
L377:
        LD    HL,4660
L378:
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
L379:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L380:
        JP    NZ,L444
L381:
        LD    A,30
L382:
        CALL  writeLineA
L383:
        JP    L448
L384:
        LD    HL,999
L385:
        CALL  writeLineHL
L386:
        ;;testBitwiseOperators.j(68)     //constant byte/var word
L387:
        ;;testBitwiseOperators.j(69)     if (0x1C & w2 == 0x0014) println (31); else println (999);
L388:
        LD    A,28
L389:
        LD    L,A
        LD    H,0
L390:
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
L391:
        LD    A,20
L392:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L393:
        JP    NZ,L459
L394:
        LD    A,31
L395:
        CALL  writeLineA
L396:
        JP    L462
L397:
        LD    HL,999
L398:
        CALL  writeLineHL
L399:
        ;;testBitwiseOperators.j(70)     if (0x1C | w2 == 0x123C) println (32); else println (999);
L400:
        LD    A,28
L401:
        LD    L,A
        LD    H,0
L402:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L403:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L404:
        JP    NZ,L472
L405:
        LD    A,32
L406:
        CALL  writeLineA
L407:
        JP    L475
L408:
        LD    HL,999
L409:
        CALL  writeLineHL
L410:
        ;;testBitwiseOperators.j(71)     if (0x1C ^ w2 == 0x1228) println (33); else println (999);
L411:
        LD    A,28
L412:
        LD    L,A
        LD    H,0
L413:
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
L414:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L415:
        JP    NZ,L485
L416:
        LD    A,33
L417:
        CALL  writeLineA
L418:
        JP    L489
L419:
        LD    HL,999
L420:
        CALL  writeLineHL
L421:
        ;;testBitwiseOperators.j(72)     //constant word/var byte
L422:
        ;;testBitwiseOperators.j(73)     if (0x1234 & b1 == 0x0014) println (34); else println (999);
L423:
        LD    HL,4660
L424:
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
L425:
        LD    A,20
L426:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L427:
        JP    NZ,L499
L428:
        LD    A,34
L429:
        CALL  writeLineA
L430:
        JP    L502
L431:
        LD    HL,999
L432:
        CALL  writeLineHL
L433:
        ;;testBitwiseOperators.j(74)     if (0x1234 | b1 == 0x123C) println (35); else println (999);
L434:
        LD    HL,4660
L435:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L436:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L437:
        JP    NZ,L511
L438:
        LD    A,35
L439:
        CALL  writeLineA
L440:
        JP    L514
L441:
        LD    HL,999
L442:
        CALL  writeLineHL
L443:
        ;;testBitwiseOperators.j(75)     if (0x1234 ^ b1 == 0x1228) println (36); else println (999);
L444:
        LD    HL,4660
L445:
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
L446:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L447:
        JP    NZ,L523
L448:
        LD    A,36
L449:
        CALL  writeLineA
L450:
        JP    L530
L451:
        LD    HL,999
L452:
        CALL  writeLineHL
L453:
        ;;testBitwiseOperators.j(76)   
L454:
        ;;testBitwiseOperators.j(77)     //constant/final var
L455:
        ;;testBitwiseOperators.j(78)     //*****************
L456:
        ;;testBitwiseOperators.j(79)     //constant byte/final var byte
L457:
        ;;testBitwiseOperators.j(80)     if (0x07 & fb1 == 0x04) println (37); else println (999);
L458:
        LD    A,7
L459:
        AND   A,28
L460:
        SUB   A,4
L461:
        JP    NZ,L539
L462:
        LD    A,37
L463:
        CALL  writeLineA
L464:
        JP    L542
L465:
        LD    HL,999
L466:
        CALL  writeLineHL
L467:
        ;;testBitwiseOperators.j(81)     if (0x07 | fb1 == 0x1F) println (38); else println (999);
L468:
        LD    A,7
L469:
        OR    A,28
L470:
        SUB   A,31
L471:
        JP    NZ,L551
L472:
        LD    A,38
L473:
        CALL  writeLineA
L474:
        JP    L554
L475:
        LD    HL,999
L476:
        CALL  writeLineHL
L477:
        ;;testBitwiseOperators.j(82)     if (0x07 ^ fb1 == 0x1B) println (39); else println (999);
L478:
        LD    A,7
L479:
        XOR   A,28
L480:
        SUB   A,27
L481:
        JP    NZ,L563
L482:
        LD    A,39
L483:
        CALL  writeLineA
L484:
        JP    L567
L485:
        LD    HL,999
L486:
        CALL  writeLineHL
L487:
        ;;testBitwiseOperators.j(83)     //constant word/final var word
L488:
        ;;testBitwiseOperators.j(84)     if (0x1234 & fw1 == 0x0224) println (40); else println (999);
L489:
        LD    HL,4660
L490:
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
L491:
        LD    DE,548
        OR    A
        SBC   HL,DE
L492:
        JP    NZ,L576
L493:
        LD    A,40
L494:
        CALL  writeLineA
L495:
        JP    L579
L496:
        LD    HL,999
L497:
        CALL  writeLineHL
L498:
        ;;testBitwiseOperators.j(85)     if (0x1234 | fw1 == 0x133C) println (41); else println (999);
L499:
        LD    HL,4660
L500:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L501:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L502:
        JP    NZ,L588
L503:
        LD    A,41
L504:
        CALL  writeLineA
L505:
        JP    L591
L506:
        LD    HL,999
L507:
        CALL  writeLineHL
L508:
        ;;testBitwiseOperators.j(86)     if (0x1234 ^ fw1 == 0x1118) println (42); else println (999);
L509:
        LD    HL,4660
L510:
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
L511:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L512:
        JP    NZ,L600
L513:
        LD    A,42
L514:
        CALL  writeLineA
L515:
        JP    L604
L516:
        LD    HL,999
L517:
        CALL  writeLineHL
L518:
        ;;testBitwiseOperators.j(87)     //constant byte/final var word
L519:
        ;;testBitwiseOperators.j(88)     if (0x1C & fw2 == 0x0014) println (43); else println (999);
L520:
        LD    A,28
L521:
        LD    L,A
        LD    H,0
L522:
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
L523:
        LD    A,20
L524:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L525:
        JP    NZ,L615
L526:
        LD    A,43
L527:
        CALL  writeLineA
L528:
        JP    L618
L529:
        LD    HL,999
L530:
        CALL  writeLineHL
L531:
        ;;testBitwiseOperators.j(89)     if (0x1C | fw2 == 0x123C) println (44); else println (999);
L532:
        LD    A,28
L533:
        LD    L,A
        LD    H,0
L534:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L535:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L536:
        JP    NZ,L628
L537:
        LD    A,44
L538:
        CALL  writeLineA
L539:
        JP    L631
L540:
        LD    HL,999
L541:
        CALL  writeLineHL
L542:
        ;;testBitwiseOperators.j(90)     if (0x1C ^ fw2 == 0x1228) println (45); else println (999);
L543:
        LD    A,28
L544:
        LD    L,A
        LD    H,0
L545:
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
L546:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L547:
        JP    NZ,L641
L548:
        LD    A,45
L549:
        CALL  writeLineA
L550:
        JP    L645
L551:
        LD    HL,999
L552:
        CALL  writeLineHL
L553:
        ;;testBitwiseOperators.j(91)     //constant word/final var byte
L554:
        ;;testBitwiseOperators.j(92)     if (0x1234 & fb1 == 0x0014) println (46); else println (999);
L555:
        LD    HL,4660
L556:
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
L557:
        LD    A,20
L558:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L559:
        JP    NZ,L655
L560:
        LD    A,46
L561:
        CALL  writeLineA
L562:
        JP    L658
L563:
        LD    HL,999
L564:
        CALL  writeLineHL
L565:
        ;;testBitwiseOperators.j(93)     if (0x1234 | fb1 == 0x123C) println (47); else println (999);
L566:
        LD    HL,4660
L567:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L568:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L569:
        JP    NZ,L667
L570:
        LD    A,47
L571:
        CALL  writeLineA
L572:
        JP    L670
L573:
        LD    HL,999
L574:
        CALL  writeLineHL
L575:
        ;;testBitwiseOperators.j(94)     if (0x1234 ^ fb1 == 0x1228) println (48); else println (999);
L576:
        LD    HL,4660
L577:
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
L578:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L579:
        JP    NZ,L679
L580:
        LD    A,48
L581:
        CALL  writeLineA
L582:
        JP    L686
L583:
        LD    HL,999
L584:
        CALL  writeLineHL
L585:
        ;;testBitwiseOperators.j(95)   
L586:
        ;;testBitwiseOperators.j(96)     //acc/constant
L587:
        ;;testBitwiseOperators.j(97)     //************
L588:
        ;;testBitwiseOperators.j(98)     //acc byte/constant byte
L589:
        ;;testBitwiseOperators.j(99)     if ((0x04 + 0x03) & 0x1C == 0x04) println (49); else println (999);
L590:
        LD    A,4
L591:
        ADD   A,3
L592:
        AND   A,28
L593:
        SUB   A,4
L594:
        JP    NZ,L696
L595:
        LD    A,49
L596:
        CALL  writeLineA
L597:
        JP    L699
L598:
        LD    HL,999
L599:
        CALL  writeLineHL
L600:
        ;;testBitwiseOperators.j(100)     if ((0x04 + 0x03) | 0x1C == 0x1F) println (50); else println (999);
L601:
        LD    A,4
L602:
        ADD   A,3
L603:
        OR    A,28
L604:
        SUB   A,31
L605:
        JP    NZ,L709
L606:
        LD    A,50
L607:
        CALL  writeLineA
L608:
        JP    L712
L609:
        LD    HL,999
L610:
        CALL  writeLineHL
L611:
        ;;testBitwiseOperators.j(101)     if ((0x04 + 0x03) ^ 0x1C == 0x1B) println (51); else println (999);
L612:
        LD    A,4
L613:
        ADD   A,3
L614:
        XOR   A,28
L615:
        SUB   A,27
L616:
        JP    NZ,L722
L617:
        LD    A,51
L618:
        CALL  writeLineA
L619:
        JP    L726
L620:
        LD    HL,999
L621:
        CALL  writeLineHL
L622:
        ;;testBitwiseOperators.j(102)     //acc word/constant word
L623:
        ;;testBitwiseOperators.j(103)     if (0x1000 + 0x0234 & 0x032C == 0x0224) println (52); else println (999);
L624:
        LD    HL,4096
L625:
        LD    DE,564
        ADD   HL,DE
L626:
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
L627:
        LD    DE,548
        OR    A
        SBC   HL,DE
L628:
        JP    NZ,L736
L629:
        LD    A,52
L630:
        CALL  writeLineA
L631:
        JP    L739
L632:
        LD    HL,999
L633:
        CALL  writeLineHL
L634:
        ;;testBitwiseOperators.j(104)     if (0x1000 + 0x0234 | 0x032C == 0x133C) println (53); else println (999);
L635:
        LD    HL,4096
L636:
        LD    DE,564
        ADD   HL,DE
L637:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L638:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L639:
        JP    NZ,L749
L640:
        LD    A,53
L641:
        CALL  writeLineA
L642:
        JP    L752
L643:
        LD    HL,999
L644:
        CALL  writeLineHL
L645:
        ;;testBitwiseOperators.j(105)     if (0x1000 + 0x0234 ^ 0x032C == 0x1118) println (54); else println (999);
L646:
        LD    HL,4096
L647:
        LD    DE,564
        ADD   HL,DE
L648:
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
L649:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L650:
        JP    NZ,L762
L651:
        LD    A,54
L652:
        CALL  writeLineA
L653:
        JP    L766
L654:
        LD    HL,999
L655:
        CALL  writeLineHL
L656:
        ;;testBitwiseOperators.j(106)     //acc byte/constant word
L657:
        ;;testBitwiseOperators.j(107)     if (0x10 + 0x0C & 0x1234 == 0x0014) println (55); else println (999);
L658:
        LD    A,16
L659:
        ADD   A,12
L660:
        LD    L,A
        LD    H,0
L661:
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
L662:
        LD    A,20
L663:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L664:
        JP    NZ,L778
L665:
        LD    A,55
L666:
        CALL  writeLineA
L667:
        JP    L781
L668:
        LD    HL,999
L669:
        CALL  writeLineHL
L670:
        ;;testBitwiseOperators.j(108)     if (0x10 + 0x0C | 0x1234 == 0x123C) println (56); else println (999);
L671:
        LD    A,16
L672:
        ADD   A,12
L673:
        LD    L,A
        LD    H,0
L674:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L675:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L676:
        JP    NZ,L792
L677:
        LD    A,56
L678:
        CALL  writeLineA
L679:
        JP    L795
L680:
        LD    HL,999
L681:
        CALL  writeLineHL
L682:
        ;;testBitwiseOperators.j(109)     if (0x10 + 0x0C ^ 0x1234 == 0x1228) println (57); else println (999);
L683:
        LD    A,16
L684:
        ADD   A,12
L685:
        LD    L,A
        LD    H,0
L686:
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
L687:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L688:
        JP    NZ,L806
L689:
        LD    A,57
L690:
        CALL  writeLineA
L691:
        JP    L810
L692:
        LD    HL,999
L693:
        CALL  writeLineHL
L694:
        ;;testBitwiseOperators.j(110)     //acc word/constant byte
L695:
        ;;testBitwiseOperators.j(111)     if (0x1000 + 0x0234 & 0x1C == 0x0014) println (58); else println (999);
L696:
        LD    HL,4096
L697:
        LD    DE,564
        ADD   HL,DE
L698:
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
L699:
        LD    A,20
L700:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L701:
        JP    NZ,L821
L702:
        LD    A,58
L703:
        CALL  writeLineA
L704:
        JP    L824
L705:
        LD    HL,999
L706:
        CALL  writeLineHL
L707:
        ;;testBitwiseOperators.j(112)     if (0x1000 + 0x0234 | 0x1C == 0x123C) println (59); else println (999);
L708:
        LD    HL,4096
L709:
        LD    DE,564
        ADD   HL,DE
L710:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L711:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L712:
        JP    NZ,L834
L713:
        LD    A,59
L714:
        CALL  writeLineA
L715:
        JP    L837
L716:
        LD    HL,999
L717:
        CALL  writeLineHL
L718:
        ;;testBitwiseOperators.j(113)     if (0x1000 + 0x0234 ^ 0x1C == 0x1228) println (60); else println (999);
L719:
        LD    HL,4096
L720:
        LD    DE,564
        ADD   HL,DE
L721:
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
L722:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L723:
        JP    NZ,L847
L724:
        LD    A,60
L725:
        CALL  writeLineA
L726:
        JP    L854
L727:
        LD    HL,999
L728:
        CALL  writeLineHL
L729:
        ;;testBitwiseOperators.j(114)   
L730:
        ;;testBitwiseOperators.j(115)     //acc/acc
L731:
        ;;testBitwiseOperators.j(116)     //*******
L732:
        ;;testBitwiseOperators.j(117)     //acc byte/acc byte
L733:
        ;;testBitwiseOperators.j(118)     if (0x04 + 0x03 & 0x10 + 0x0C == 0x04) println (61); else println (999);
L734:
        LD    A,4
L735:
        ADD   A,3
L736:
        PUSH  AF
        LD    A,16
L737:
        ADD   A,12
L738:
        POP   BC
        AND   A,B
L739:
        SUB   A,4
L740:
        JP    NZ,L866
L741:
        LD    A,61
L742:
        CALL  writeLineA
L743:
        JP    L869
L744:
        LD    HL,999
L745:
        CALL  writeLineHL
L746:
        ;;testBitwiseOperators.j(119)     if (0x04 + 0x03 | 0x10 + 0x0C == 0x1F) println (62); else println (999);
L747:
        LD    A,4
L748:
        ADD   A,3
L749:
        PUSH  AF
        LD    A,16
L750:
        ADD   A,12
L751:
        POP   BC
        OR    A,B
L752:
        SUB   A,31
L753:
        JP    NZ,L881
L754:
        LD    A,62
L755:
        CALL  writeLineA
L756:
        JP    L884
L757:
        LD    HL,999
L758:
        CALL  writeLineHL
L759:
        ;;testBitwiseOperators.j(120)     if (0x04 + 0x03 ^ 0x10 + 0x0C == 0x1B) println (63); else println (999);
L760:
        LD    A,4
L761:
        ADD   A,3
L762:
        PUSH  AF
        LD    A,16
L763:
        ADD   A,12
L764:
        POP   BC
        XOR   A,B
L765:
        SUB   A,27
L766:
        JP    NZ,L896
L767:
        LD    A,63
L768:
        CALL  writeLineA
L769:
        JP    L900
L770:
        LD    HL,999
L771:
        CALL  writeLineHL
L772:
        ;;testBitwiseOperators.j(121)     //acc word/acc word
L773:
        ;;testBitwiseOperators.j(122)     if (0x1000 + 0x0234 & 0x0100 + 0x022C == 0x0224) println (64); else println (999);
L774:
        LD    HL,4096
L775:
        LD    DE,564
        ADD   HL,DE
L776:
        PUSH  HL
        LD    HL,256
L777:
        LD    DE,556
        ADD   HL,DE
L778:
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
L779:
        LD    DE,548
        OR    A
        SBC   HL,DE
L780:
        JP    NZ,L912
L781:
        LD    A,64
L782:
        CALL  writeLineA
L783:
        JP    L915
L784:
        LD    HL,999
L785:
        CALL  writeLineHL
L786:
        ;;testBitwiseOperators.j(123)     if (0x1000 + 0x0234 | 0x0100 + 0x022C == 0x133C) println (65); else println (999);
L787:
        LD    HL,4096
L788:
        LD    DE,564
        ADD   HL,DE
L789:
        PUSH  HL
        LD    HL,256
L790:
        LD    DE,556
        ADD   HL,DE
L791:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L792:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L793:
        JP    NZ,L927
L794:
        LD    A,65
L795:
        CALL  writeLineA
L796:
        JP    L930
L797:
        LD    HL,999
L798:
        CALL  writeLineHL
L799:
        ;;testBitwiseOperators.j(124)     if (0x1000 + 0x0234 ^ 0x0100 + 0x022C == 0x1118) println (66); else println (999);
L800:
        LD    HL,4096
L801:
        LD    DE,564
        ADD   HL,DE
L802:
        PUSH  HL
        LD    HL,256
L803:
        LD    DE,556
        ADD   HL,DE
L804:
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
L805:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L806:
        JP    NZ,L942
L807:
        LD    A,66
L808:
        CALL  writeLineA
L809:
        JP    L946
L810:
        LD    HL,999
L811:
        CALL  writeLineHL
L812:
        ;;testBitwiseOperators.j(125)     //acc byte/acc word
L813:
        ;;testBitwiseOperators.j(126)     if (0x10 + 0x0C & 0x1000 + 0x0234 == 0x0014) println (67); else println (999);
L814:
        LD    A,16
L815:
        ADD   A,12
L816:
        LD    HL,4096
L817:
        LD    DE,564
        ADD   HL,DE
L818:
        AND   A,L
        LD    L,A
        LD    H,0
L819:
        LD    A,20
L820:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L821:
        JP    NZ,L959
L822:
        LD    A,67
L823:
        CALL  writeLineA
L824:
        JP    L962
L825:
        LD    HL,999
L826:
        CALL  writeLineHL
L827:
        ;;testBitwiseOperators.j(127)     if (0x10 + 0x0C | 0x1000 + 0x0234 == 0x123C) println (68); else println (999);
L828:
        LD    A,16
L829:
        ADD   A,12
L830:
        LD    HL,4096
L831:
        LD    DE,564
        ADD   HL,DE
L832:
        OR    A,L
        LD    L,A
L833:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L834:
        JP    NZ,L974
L835:
        LD    A,68
L836:
        CALL  writeLineA
L837:
        JP    L977
L838:
        LD    HL,999
L839:
        CALL  writeLineHL
L840:
        ;;testBitwiseOperators.j(128)     if (0x10 + 0x0C ^ 0x1000 + 0x0234 == 0x1228) println (69); else println (999);
L841:
        LD    A,16
L842:
        ADD   A,12
L843:
        LD    HL,4096
L844:
        LD    DE,564
        ADD   HL,DE
L845:
        XOR   A,L
        LD    L,A
L846:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L847:
        JP    NZ,L989
L848:
        LD    A,69
L849:
        CALL  writeLineA
L850:
        JP    L993
L851:
        LD    HL,999
L852:
        CALL  writeLineHL
L853:
        ;;testBitwiseOperators.j(129)     //acc word/acc byte
L854:
        ;;testBitwiseOperators.j(130)     if (0x1000 + 0x0234 & 0x10 + 0x0C == 0x0014) println (70); else println (999);
L855:
        LD    HL,4096
L856:
        LD    DE,564
        ADD   HL,DE
L857:
        LD    A,16
L858:
        ADD   A,12
L859:
        AND   A,L
        LD    L,A
        LD    H,0
L860:
        LD    A,20
L861:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L862:
        JP    NZ,L1006
L863:
        LD    A,70
L864:
        CALL  writeLineA
L865:
        JP    L1009
L866:
        LD    HL,999
L867:
        CALL  writeLineHL
L868:
        ;;testBitwiseOperators.j(131)     if (0x1000 + 0x0234 | 0x10 + 0x0C == 0x123C) println (71); else println (999);
L869:
        LD    HL,4096
L870:
        LD    DE,564
        ADD   HL,DE
L871:
        LD    A,16
L872:
        ADD   A,12
L873:
        OR    A,L
        LD    L,A
L874:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L875:
        JP    NZ,L1021
L876:
        LD    A,71
L877:
        CALL  writeLineA
L878:
        JP    L1024
L879:
        LD    HL,999
L880:
        CALL  writeLineHL
L881:
        ;;testBitwiseOperators.j(132)     if (0x1000 + 0x0234 ^ 0x10 + 0x0C == 0x1228) println (72); else println (999);
L882:
        LD    HL,4096
L883:
        LD    DE,564
        ADD   HL,DE
L884:
        LD    A,16
L885:
        ADD   A,12
L886:
        XOR   A,L
        LD    L,A
L887:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L888:
        JP    NZ,L1036
L889:
        LD    A,72
L890:
        CALL  writeLineA
L891:
        JP    L1043
L892:
        LD    HL,999
L893:
        CALL  writeLineHL
L894:
        ;;testBitwiseOperators.j(133)   
L895:
        ;;testBitwiseOperators.j(134)     //acc/var
L896:
        ;;testBitwiseOperators.j(135)     //*******
L897:
        ;;testBitwiseOperators.j(136)     //acc byte/var byte
L898:
        ;;testBitwiseOperators.j(137)     if (0x04 + 0x03 & b1 == 0x04) println (73); else println (999);
L899:
        LD    A,4
L900:
        ADD   A,3
L901:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L902:
        SUB   A,4
L903:
        JP    NZ,L1053
L904:
        LD    A,73
L905:
        CALL  writeLineA
L906:
        JP    L1056
L907:
        LD    HL,999
L908:
        CALL  writeLineHL
L909:
        ;;testBitwiseOperators.j(138)     if (0x04 + 0x03 | b1 == 0x1F) println (74); else println (999);
L910:
        LD    A,4
L911:
        ADD   A,3
L912:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L913:
        SUB   A,31
L914:
        JP    NZ,L1066
L915:
        LD    A,74
L916:
        CALL  writeLineA
L917:
        JP    L1069
L918:
        LD    HL,999
L919:
        CALL  writeLineHL
L920:
        ;;testBitwiseOperators.j(139)     if (0x04 + 0x03 ^ b1 == 0x1B) println (75); else println (999);
L921:
        LD    A,4
L922:
        ADD   A,3
L923:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L924:
        SUB   A,27
L925:
        JP    NZ,L1079
L926:
        LD    A,75
L927:
        CALL  writeLineA
L928:
        JP    L1083
L929:
        LD    HL,999
L930:
        CALL  writeLineHL
L931:
        ;;testBitwiseOperators.j(140)     //acc word/var word
L932:
        ;;testBitwiseOperators.j(141)     if (0x1000 + 0x0234 & w1 == 0x0224) println (76); else println (999);
L933:
        LD    HL,4096
L934:
        LD    DE,564
        ADD   HL,DE
L935:
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
L936:
        LD    DE,548
        OR    A
        SBC   HL,DE
L937:
        JP    NZ,L1093
L938:
        LD    A,76
L939:
        CALL  writeLineA
L940:
        JP    L1096
L941:
        LD    HL,999
L942:
        CALL  writeLineHL
L943:
        ;;testBitwiseOperators.j(142)     if (0x1000 + 0x0234 | w1 == 0x133C) println (77); else println (999);
L944:
        LD    HL,4096
L945:
        LD    DE,564
        ADD   HL,DE
L946:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L947:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L948:
        JP    NZ,L1106
L949:
        LD    A,77
L950:
        CALL  writeLineA
L951:
        JP    L1109
L952:
        LD    HL,999
L953:
        CALL  writeLineHL
L954:
        ;;testBitwiseOperators.j(143)     if (0x1000 + 0x0234 ^ w1 == 0x1118) println (78); else println (999);
L955:
        LD    HL,4096
L956:
        LD    DE,564
        ADD   HL,DE
L957:
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
L958:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L959:
        JP    NZ,L1119
L960:
        LD    A,78
L961:
        CALL  writeLineA
L962:
        JP    L1123
L963:
        LD    HL,999
L964:
        CALL  writeLineHL
L965:
        ;;testBitwiseOperators.j(144)     //acc byte/var word
L966:
        ;;testBitwiseOperators.j(145)     if (0x10 + 0x0C & w2 == 0x0014) println (79); else println (999);
L967:
        LD    A,16
L968:
        ADD   A,12
L969:
        LD    L,A
        LD    H,0
L970:
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
L971:
        LD    A,20
L972:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L973:
        JP    NZ,L1135
L974:
        LD    A,79
L975:
        CALL  writeLineA
L976:
        JP    L1138
L977:
        LD    HL,999
L978:
        CALL  writeLineHL
L979:
        ;;testBitwiseOperators.j(146)     if (0x10 + 0x0C | w2 == 0x123C) println (80); else println (999);
L980:
        LD    A,16
L981:
        ADD   A,12
L982:
        LD    L,A
        LD    H,0
L983:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L984:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L985:
        JP    NZ,L1149
L986:
        LD    A,80
L987:
        CALL  writeLineA
L988:
        JP    L1152
L989:
        LD    HL,999
L990:
        CALL  writeLineHL
L991:
        ;;testBitwiseOperators.j(147)     if (0x10 + 0x0C ^ w2 == 0x1228) println (81); else println (999);
L992:
        LD    A,16
L993:
        ADD   A,12
L994:
        LD    L,A
        LD    H,0
L995:
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
L996:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L997:
        JP    NZ,L1163
L998:
        LD    A,81
L999:
        CALL  writeLineA
L1000:
        JP    L1167
L1001:
        LD    HL,999
L1002:
        CALL  writeLineHL
L1003:
        ;;testBitwiseOperators.j(148)     //acc word/var byte
L1004:
        ;;testBitwiseOperators.j(149)     if (0x1000 + 0x0234 & b1 == 0x0014) println (82); else println (999);
L1005:
        LD    HL,4096
L1006:
        LD    DE,564
        ADD   HL,DE
L1007:
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
L1008:
        LD    A,20
L1009:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1010:
        JP    NZ,L1178
L1011:
        LD    A,82
L1012:
        CALL  writeLineA
L1013:
        JP    L1181
L1014:
        LD    HL,999
L1015:
        CALL  writeLineHL
L1016:
        ;;testBitwiseOperators.j(150)     if (0x1000 + 0x0234 | b1 == 0x123C) println (83); else println (999);
L1017:
        LD    HL,4096
L1018:
        LD    DE,564
        ADD   HL,DE
L1019:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1020:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1021:
        JP    NZ,L1191
L1022:
        LD    A,83
L1023:
        CALL  writeLineA
L1024:
        JP    L1194
L1025:
        LD    HL,999
L1026:
        CALL  writeLineHL
L1027:
        ;;testBitwiseOperators.j(151)     if (0x1000 + 0x0234 ^ b1 == 0x1228) println (84); else println (999);
L1028:
        LD    HL,4096
L1029:
        LD    DE,564
        ADD   HL,DE
L1030:
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
L1031:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1032:
        JP    NZ,L1204
L1033:
        LD    A,84
L1034:
        CALL  writeLineA
L1035:
        JP    L1211
L1036:
        LD    HL,999
L1037:
        CALL  writeLineHL
L1038:
        ;;testBitwiseOperators.j(152)   
L1039:
        ;;testBitwiseOperators.j(153)     //acc/final var
L1040:
        ;;testBitwiseOperators.j(154)     //*************
L1041:
        ;;testBitwiseOperators.j(155)     //acc byte/final var byte
L1042:
        ;;testBitwiseOperators.j(156)     if (0x04 + 0x03 & fb1 == 0x04) println (85); else println (999);
L1043:
        LD    A,4
L1044:
        ADD   A,3
L1045:
        AND   A,28
L1046:
        SUB   A,4
L1047:
        JP    NZ,L1221
L1048:
        LD    A,85
L1049:
        CALL  writeLineA
L1050:
        JP    L1224
L1051:
        LD    HL,999
L1052:
        CALL  writeLineHL
L1053:
        ;;testBitwiseOperators.j(157)     if (0x04 + 0x03 | fb1 == 0x1F) println (86); else println (999);
L1054:
        LD    A,4
L1055:
        ADD   A,3
L1056:
        OR    A,28
L1057:
        SUB   A,31
L1058:
        JP    NZ,L1234
L1059:
        LD    A,86
L1060:
        CALL  writeLineA
L1061:
        JP    L1237
L1062:
        LD    HL,999
L1063:
        CALL  writeLineHL
L1064:
        ;;testBitwiseOperators.j(158)     if (0x04 + 0x03 ^ fb1 == 0x1B) println (87); else println (999);
L1065:
        LD    A,4
L1066:
        ADD   A,3
L1067:
        XOR   A,28
L1068:
        SUB   A,27
L1069:
        JP    NZ,L1247
L1070:
        LD    A,87
L1071:
        CALL  writeLineA
L1072:
        JP    L1251
L1073:
        LD    HL,999
L1074:
        CALL  writeLineHL
L1075:
        ;;testBitwiseOperators.j(159)     //acc word/final var word
L1076:
        ;;testBitwiseOperators.j(160)     if (0x1000 + 0x0234 & fw1 == 0x0224) println (88); else println (999);
L1077:
        LD    HL,4096
L1078:
        LD    DE,564
        ADD   HL,DE
L1079:
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
L1080:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1081:
        JP    NZ,L1261
L1082:
        LD    A,88
L1083:
        CALL  writeLineA
L1084:
        JP    L1264
L1085:
        LD    HL,999
L1086:
        CALL  writeLineHL
L1087:
        ;;testBitwiseOperators.j(161)     if (0x1000 + 0x0234 | fw1 == 0x133C) println (89); else println (999);
L1088:
        LD    HL,4096
L1089:
        LD    DE,564
        ADD   HL,DE
L1090:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1091:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1092:
        JP    NZ,L1274
L1093:
        LD    A,89
L1094:
        CALL  writeLineA
L1095:
        JP    L1277
L1096:
        LD    HL,999
L1097:
        CALL  writeLineHL
L1098:
        ;;testBitwiseOperators.j(162)     if (0x1000 + 0x0234 ^ fw1 == 0x1118) println (90); else println (999);
L1099:
        LD    HL,4096
L1100:
        LD    DE,564
        ADD   HL,DE
L1101:
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
L1102:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1103:
        JP    NZ,L1287
L1104:
        LD    A,90
L1105:
        CALL  writeLineA
L1106:
        JP    L1291
L1107:
        LD    HL,999
L1108:
        CALL  writeLineHL
L1109:
        ;;testBitwiseOperators.j(163)     //acc byte/final var word
L1110:
        ;;testBitwiseOperators.j(164)     if (0x10 + 0x0C & fw2 == 0x0014) println (91); else println (999);
L1111:
        LD    A,16
L1112:
        ADD   A,12
L1113:
        LD    L,A
        LD    H,0
L1114:
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
L1115:
        LD    A,20
L1116:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1117:
        JP    NZ,L1303
L1118:
        LD    A,91
L1119:
        CALL  writeLineA
L1120:
        JP    L1306
L1121:
        LD    HL,999
L1122:
        CALL  writeLineHL
L1123:
        ;;testBitwiseOperators.j(165)     if (0x10 + 0x0C | fw2 == 0x123C) println (92); else println (999);
L1124:
        LD    A,16
L1125:
        ADD   A,12
L1126:
        LD    L,A
        LD    H,0
L1127:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1128:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1129:
        JP    NZ,L1317
L1130:
        LD    A,92
L1131:
        CALL  writeLineA
L1132:
        JP    L1320
L1133:
        LD    HL,999
L1134:
        CALL  writeLineHL
L1135:
        ;;testBitwiseOperators.j(166)     if (0x10 + 0x0C ^ fw2 == 0x1228) println (93); else println (999);
L1136:
        LD    A,16
L1137:
        ADD   A,12
L1138:
        LD    L,A
        LD    H,0
L1139:
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
L1140:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1141:
        JP    NZ,L1331
L1142:
        LD    A,93
L1143:
        CALL  writeLineA
L1144:
        JP    L1335
L1145:
        LD    HL,999
L1146:
        CALL  writeLineHL
L1147:
        ;;testBitwiseOperators.j(167)     //acc word/final var byte
L1148:
        ;;testBitwiseOperators.j(168)     if (0x1000 + 0x0234 & fb1 == 0x0014) println (94); else println (999);
L1149:
        LD    HL,4096
L1150:
        LD    DE,564
        ADD   HL,DE
L1151:
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
L1152:
        LD    A,20
L1153:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1154:
        JP    NZ,L1346
L1155:
        LD    A,94
L1156:
        CALL  writeLineA
L1157:
        JP    L1349
L1158:
        LD    HL,999
L1159:
        CALL  writeLineHL
L1160:
        ;;testBitwiseOperators.j(169)     if (0x1000 + 0x0234 | fb1 == 0x123C) println (95); else println (999);
L1161:
        LD    HL,4096
L1162:
        LD    DE,564
        ADD   HL,DE
L1163:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1164:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1165:
        JP    NZ,L1359
L1166:
        LD    A,95
L1167:
        CALL  writeLineA
L1168:
        JP    L1362
L1169:
        LD    HL,999
L1170:
        CALL  writeLineHL
L1171:
        ;;testBitwiseOperators.j(170)     if (0x1000 + 0x0234 ^ fb1 == 0x1228) println (96); else println (999);
L1172:
        LD    HL,4096
L1173:
        LD    DE,564
        ADD   HL,DE
L1174:
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
L1175:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1176:
        JP    NZ,L1372
L1177:
        LD    A,96
L1178:
        CALL  writeLineA
L1179:
        JP    L1379
L1180:
        LD    HL,999
L1181:
        CALL  writeLineHL
L1182:
        ;;testBitwiseOperators.j(171)   
L1183:
        ;;testBitwiseOperators.j(172)     //var/constant
L1184:
        ;;testBitwiseOperators.j(173)     //************
L1185:
        ;;testBitwiseOperators.j(174)     //var byte/constant byte
L1186:
        ;;testBitwiseOperators.j(175)     if (b2 & 0x1C == 0x04) println (97); else println (999);
L1187:
        LD    A,(05001H)
L1188:
        AND   A,28
L1189:
        SUB   A,4
L1190:
        JP    NZ,L1388
L1191:
        LD    A,97
L1192:
        CALL  writeLineA
L1193:
        JP    L1391
L1194:
        LD    HL,999
L1195:
        CALL  writeLineHL
L1196:
        ;;testBitwiseOperators.j(176)     if (b2 | 0x1C == 0x1F) println (98); else println (999);
L1197:
        LD    A,(05001H)
L1198:
        OR    A,28
L1199:
        SUB   A,31
L1200:
        JP    NZ,L1400
L1201:
        LD    A,98
L1202:
        CALL  writeLineA
L1203:
        JP    L1403
L1204:
        LD    HL,999
L1205:
        CALL  writeLineHL
L1206:
        ;;testBitwiseOperators.j(177)     if (b2 ^ 0x1C == 0x1B) println (99); else println (999);
L1207:
        LD    A,(05001H)
L1208:
        XOR   A,28
L1209:
        SUB   A,27
L1210:
        JP    NZ,L1412
L1211:
        LD    A,99
L1212:
        CALL  writeLineA
L1213:
        JP    L1416
L1214:
        LD    HL,999
L1215:
        CALL  writeLineHL
L1216:
        ;;testBitwiseOperators.j(178)     //var word/constant word
L1217:
        ;;testBitwiseOperators.j(179)     if (w2 & 0x032C == 0x0224) println (100); else println (999);
L1218:
        LD    HL,(05004H)
L1219:
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
L1220:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1221:
        JP    NZ,L1425
L1222:
        LD    A,100
L1223:
        CALL  writeLineA
L1224:
        JP    L1428
L1225:
        LD    HL,999
L1226:
        CALL  writeLineHL
L1227:
        ;;testBitwiseOperators.j(180)     if (w2 | 0x032C == 0x133C) println (101); else println (999);
L1228:
        LD    HL,(05004H)
L1229:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1230:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1231:
        JP    NZ,L1437
L1232:
        LD    A,101
L1233:
        CALL  writeLineA
L1234:
        JP    L1440
L1235:
        LD    HL,999
L1236:
        CALL  writeLineHL
L1237:
        ;;testBitwiseOperators.j(181)     if (w2 ^ 0x032C == 0x1118) println (102); else println (999);
L1238:
        LD    HL,(05004H)
L1239:
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
L1240:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1241:
        JP    NZ,L1449
L1242:
        LD    A,102
L1243:
        CALL  writeLineA
L1244:
        JP    L1453
L1245:
        LD    HL,999
L1246:
        CALL  writeLineHL
L1247:
        ;;testBitwiseOperators.j(182)     //var byte/constant word
L1248:
        ;;testBitwiseOperators.j(183)     if (b1 & 0x1234 == 0x0014) println (103); else println (999);
L1249:
        LD    A,(05000H)
L1250:
        LD    L,A
        LD    H,0
L1251:
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
L1252:
        LD    A,20
L1253:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1254:
        JP    NZ,L1464
L1255:
        LD    A,103
L1256:
        CALL  writeLineA
L1257:
        JP    L1467
L1258:
        LD    HL,999
L1259:
        CALL  writeLineHL
L1260:
        ;;testBitwiseOperators.j(184)     if (b1 | 0x1234 == 0x123C) println (104); else println (999);
L1261:
        LD    A,(05000H)
L1262:
        LD    L,A
        LD    H,0
L1263:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1264:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1265:
        JP    NZ,L1477
L1266:
        LD    A,104
L1267:
        CALL  writeLineA
L1268:
        JP    L1480
L1269:
        LD    HL,999
L1270:
        CALL  writeLineHL
L1271:
        ;;testBitwiseOperators.j(185)     if (b1 ^ 0x1234 == 0x1228) println (105); else println (999);
L1272:
        LD    A,(05000H)
L1273:
        LD    L,A
        LD    H,0
L1274:
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
L1275:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1276:
        JP    NZ,L1490
L1277:
        LD    A,105
L1278:
        CALL  writeLineA
L1279:
        JP    L1494
L1280:
        LD    HL,999
L1281:
        CALL  writeLineHL
L1282:
        ;;testBitwiseOperators.j(186)     //var word/constant byte
L1283:
        ;;testBitwiseOperators.j(187)     if (w2 & 0x1C == 0x0014) println (106); else println (999);
L1284:
        LD    HL,(05004H)
L1285:
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
L1286:
        LD    A,20
L1287:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1288:
        JP    NZ,L1504
L1289:
        LD    A,106
L1290:
        CALL  writeLineA
L1291:
        JP    L1507
L1292:
        LD    HL,999
L1293:
        CALL  writeLineHL
L1294:
        ;;testBitwiseOperators.j(188)     if (w2 | 0x1C == 0x123C) println (107); else println (999);
L1295:
        LD    HL,(05004H)
L1296:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1297:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1298:
        JP    NZ,L1516
L1299:
        LD    A,107
L1300:
        CALL  writeLineA
L1301:
        JP    L1519
L1302:
        LD    HL,999
L1303:
        CALL  writeLineHL
L1304:
        ;;testBitwiseOperators.j(189)     if (w2 ^ 0x1C == 0x1228) println (108); else println (999);
L1305:
        LD    HL,(05004H)
L1306:
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
L1307:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1308:
        JP    NZ,L1528
L1309:
        LD    A,108
L1310:
        CALL  writeLineA
L1311:
        JP    L1535
L1312:
        LD    HL,999
L1313:
        CALL  writeLineHL
L1314:
        ;;testBitwiseOperators.j(190)   
L1315:
        ;;testBitwiseOperators.j(191)     //var/acc
L1316:
        ;;testBitwiseOperators.j(192)     //*******
L1317:
        ;;testBitwiseOperators.j(193)     //var byte/acc byte
L1318:
        ;;testBitwiseOperators.j(194)     if (b2 & (0x10 + 0x0C) == 0x04) println (109); else println (999);
L1319:
        LD    A,(05001H)
L1320:
        PUSH  AF
        LD    A,16
L1321:
        ADD   A,12
L1322:
        POP   BC
        AND   A,B
L1323:
        SUB   A,4
L1324:
        JP    NZ,L1546
L1325:
        LD    A,109
L1326:
        CALL  writeLineA
L1327:
        JP    L1549
L1328:
        LD    HL,999
L1329:
        CALL  writeLineHL
L1330:
        ;;testBitwiseOperators.j(195)     if (b2 | (0x10 + 0x0C) == 0x1F) println (110); else println (999);
L1331:
        LD    A,(05001H)
L1332:
        PUSH  AF
        LD    A,16
L1333:
        ADD   A,12
L1334:
        POP   BC
        OR    A,B
L1335:
        SUB   A,31
L1336:
        JP    NZ,L1560
L1337:
        LD    A,110
L1338:
        CALL  writeLineA
L1339:
        JP    L1563
L1340:
        LD    HL,999
L1341:
        CALL  writeLineHL
L1342:
        ;;testBitwiseOperators.j(196)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (111); else println (999);
L1343:
        LD    A,(05001H)
L1344:
        PUSH  AF
        LD    A,16
L1345:
        ADD   A,12
L1346:
        POP   BC
        XOR   A,B
L1347:
        SUB   A,27
L1348:
        JP    NZ,L1574
L1349:
        LD    A,111
L1350:
        CALL  writeLineA
L1351:
        JP    L1578
L1352:
        LD    HL,999
L1353:
        CALL  writeLineHL
L1354:
        ;;testBitwiseOperators.j(197)     //var word/acc word
L1355:
        ;;testBitwiseOperators.j(198)     if (w2 & 0x0100 + 0x022C == 0x0224) println (112); else println (999);
L1356:
        LD    HL,(05004H)
L1357:
        PUSH  HL
        LD    HL,256
L1358:
        LD    DE,556
        ADD   HL,DE
L1359:
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
L1360:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1361:
        JP    NZ,L1589
L1362:
        LD    A,112
L1363:
        CALL  writeLineA
L1364:
        JP    L1592
L1365:
        LD    HL,999
L1366:
        CALL  writeLineHL
L1367:
        ;;testBitwiseOperators.j(199)     if (w2 | 0x0100 + 0x022C == 0x133C) println (113); else println (999);
L1368:
        LD    HL,(05004H)
L1369:
        PUSH  HL
        LD    HL,256
L1370:
        LD    DE,556
        ADD   HL,DE
L1371:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1372:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1373:
        JP    NZ,L1603
L1374:
        LD    A,113
L1375:
        CALL  writeLineA
L1376:
        JP    L1606
L1377:
        LD    HL,999
L1378:
        CALL  writeLineHL
L1379:
        ;;testBitwiseOperators.j(200)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (114); else println (999);
L1380:
        LD    HL,(05004H)
L1381:
        PUSH  HL
        LD    HL,256
L1382:
        LD    DE,556
        ADD   HL,DE
L1383:
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
L1384:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1385:
        JP    NZ,L1617
L1386:
        LD    A,114
L1387:
        CALL  writeLineA
L1388:
        JP    L1621
L1389:
        LD    HL,999
L1390:
        CALL  writeLineHL
L1391:
        ;;testBitwiseOperators.j(201)     //var byte/acc word
L1392:
        ;;testBitwiseOperators.j(202)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (115); else println (999);
L1393:
        LD    A,(05000H)
L1394:
        LD    HL,4096
L1395:
        LD    DE,564
        ADD   HL,DE
L1396:
        AND   A,L
        LD    L,A
        LD    H,0
L1397:
        LD    A,20
L1398:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1399:
        JP    NZ,L1633
L1400:
        LD    A,115
L1401:
        CALL  writeLineA
L1402:
        JP    L1636
L1403:
        LD    HL,999
L1404:
        CALL  writeLineHL
L1405:
        ;;testBitwiseOperators.j(203)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (116); else println (999);
L1406:
        LD    A,(05000H)
L1407:
        LD    HL,4096
L1408:
        LD    DE,564
        ADD   HL,DE
L1409:
        OR    A,L
        LD    L,A
L1410:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1411:
        JP    NZ,L1647
L1412:
        LD    A,116
L1413:
        CALL  writeLineA
L1414:
        JP    L1650
L1415:
        LD    HL,999
L1416:
        CALL  writeLineHL
L1417:
        ;;testBitwiseOperators.j(204)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (117); else println (999);
L1418:
        LD    A,(05000H)
L1419:
        LD    HL,4096
L1420:
        LD    DE,564
        ADD   HL,DE
L1421:
        XOR   A,L
        LD    L,A
L1422:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1423:
        JP    NZ,L1661
L1424:
        LD    A,117
L1425:
        CALL  writeLineA
L1426:
        JP    L1665
L1427:
        LD    HL,999
L1428:
        CALL  writeLineHL
L1429:
        ;;testBitwiseOperators.j(205)     //var word/acc byte
L1430:
        ;;testBitwiseOperators.j(206)     if (w2 & 0x10 + 0x0C == 0x0014) println (118); else println (999);
L1431:
        LD    HL,(05004H)
L1432:
        LD    A,16
L1433:
        ADD   A,12
L1434:
        AND   A,L
        LD    L,A
        LD    H,0
L1435:
        LD    A,20
L1436:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1437:
        JP    NZ,L1677
L1438:
        LD    A,118
L1439:
        CALL  writeLineA
L1440:
        JP    L1680
L1441:
        LD    HL,999
L1442:
        CALL  writeLineHL
L1443:
        ;;testBitwiseOperators.j(207)     if (w2 | 0x10 + 0x0C == 0x123C) println (119); else println (999);
L1444:
        LD    HL,(05004H)
L1445:
        LD    A,16
L1446:
        ADD   A,12
L1447:
        OR    A,L
        LD    L,A
L1448:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1449:
        JP    NZ,L1691
L1450:
        LD    A,119
L1451:
        CALL  writeLineA
L1452:
        JP    L1694
L1453:
        LD    HL,999
L1454:
        CALL  writeLineHL
L1455:
        ;;testBitwiseOperators.j(208)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (120); else println (999);
L1456:
        LD    HL,(05004H)
L1457:
        LD    A,16
L1458:
        ADD   A,12
L1459:
        XOR   A,L
        LD    L,A
L1460:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1461:
        JP    NZ,L1705
L1462:
        LD    A,120
L1463:
        CALL  writeLineA
L1464:
        JP    L1712
L1465:
        LD    HL,999
L1466:
        CALL  writeLineHL
L1467:
        ;;testBitwiseOperators.j(209)   
L1468:
        ;;testBitwiseOperators.j(210)     //var/var
L1469:
        ;;testBitwiseOperators.j(211)     //*******
L1470:
        ;;testBitwiseOperators.j(212)     //var byte/var byte
L1471:
        ;;testBitwiseOperators.j(213)     if (b2 & b1 == 0x04) println (121); else println (999);
L1472:
        LD    A,(05001H)
L1473:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L1474:
        SUB   A,4
L1475:
        JP    NZ,L1721
L1476:
        LD    A,121
L1477:
        CALL  writeLineA
L1478:
        JP    L1724
L1479:
        LD    HL,999
L1480:
        CALL  writeLineHL
L1481:
        ;;testBitwiseOperators.j(214)     if (b2 | b1 == 0x1F) println (122); else println (999);
L1482:
        LD    A,(05001H)
L1483:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L1484:
        SUB   A,31
L1485:
        JP    NZ,L1733
L1486:
        LD    A,122
L1487:
        CALL  writeLineA
L1488:
        JP    L1736
L1489:
        LD    HL,999
L1490:
        CALL  writeLineHL
L1491:
        ;;testBitwiseOperators.j(215)     if (b2 ^ b1 == 0x1B) println (123); else println (999);
L1492:
        LD    A,(05001H)
L1493:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L1494:
        SUB   A,27
L1495:
        JP    NZ,L1745
L1496:
        LD    A,123
L1497:
        CALL  writeLineA
L1498:
        JP    L1749
L1499:
        LD    HL,999
L1500:
        CALL  writeLineHL
L1501:
        ;;testBitwiseOperators.j(216)     //var word/var word
L1502:
        ;;testBitwiseOperators.j(217)     if (w2 & w1 == 0x0224) println (124); else println (999);
L1503:
        LD    HL,(05004H)
L1504:
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
L1505:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1506:
        JP    NZ,L1758
L1507:
        LD    A,124
L1508:
        CALL  writeLineA
L1509:
        JP    L1761
L1510:
        LD    HL,999
L1511:
        CALL  writeLineHL
L1512:
        ;;testBitwiseOperators.j(218)     if (w2 | w1 == 0x133C) println (125); else println (999);
L1513:
        LD    HL,(05004H)
L1514:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1515:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1516:
        JP    NZ,L1770
L1517:
        LD    A,125
L1518:
        CALL  writeLineA
L1519:
        JP    L1773
L1520:
        LD    HL,999
L1521:
        CALL  writeLineHL
L1522:
        ;;testBitwiseOperators.j(219)     if (w2 ^ w1 == 0x1118) println (126); else println (999);
L1523:
        LD    HL,(05004H)
L1524:
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
L1525:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1526:
        JP    NZ,L1782
L1527:
        LD    A,126
L1528:
        CALL  writeLineA
L1529:
        JP    L1786
L1530:
        LD    HL,999
L1531:
        CALL  writeLineHL
L1532:
        ;;testBitwiseOperators.j(220)     //var byte/var word
L1533:
        ;;testBitwiseOperators.j(221)     if (b1 & w2 == 0x0014) println (127); else println (999);
L1534:
        LD    A,(05000H)
L1535:
        LD    L,A
        LD    H,0
L1536:
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
L1537:
        LD    A,20
L1538:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1539:
        JP    NZ,L1797
L1540:
        LD    A,127
L1541:
        CALL  writeLineA
L1542:
        JP    L1800
L1543:
        LD    HL,999
L1544:
        CALL  writeLineHL
L1545:
        ;;testBitwiseOperators.j(222)     if (b1 | w2 == 0x123C) println (128); else println (999);
L1546:
        LD    A,(05000H)
L1547:
        LD    L,A
        LD    H,0
L1548:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1549:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1550:
        JP    NZ,L1810
L1551:
        LD    A,128
L1552:
        CALL  writeLineA
L1553:
        JP    L1813
L1554:
        LD    HL,999
L1555:
        CALL  writeLineHL
L1556:
        ;;testBitwiseOperators.j(223)     if (b1 ^ w2 == 0x1228) println (129); else println (999);
L1557:
        LD    A,(05000H)
L1558:
        LD    L,A
        LD    H,0
L1559:
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
L1560:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1561:
        JP    NZ,L1823
L1562:
        LD    A,129
L1563:
        CALL  writeLineA
L1564:
        JP    L1827
L1565:
        LD    HL,999
L1566:
        CALL  writeLineHL
L1567:
        ;;testBitwiseOperators.j(224)     //var word/var byte
L1568:
        ;;testBitwiseOperators.j(225)     if (w2 & b1 == 0x0014) println (130); else println (999);
L1569:
        LD    HL,(05004H)
L1570:
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
L1571:
        LD    A,20
L1572:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1573:
        JP    NZ,L1837
L1574:
        LD    A,130
L1575:
        CALL  writeLineA
L1576:
        JP    L1840
L1577:
        LD    HL,999
L1578:
        CALL  writeLineHL
L1579:
        ;;testBitwiseOperators.j(226)     if (w2 | b1 == 0x123C) println (131); else println (999);
L1580:
        LD    HL,(05004H)
L1581:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1582:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1583:
        JP    NZ,L1849
L1584:
        LD    A,131
L1585:
        CALL  writeLineA
L1586:
        JP    L1852
L1587:
        LD    HL,999
L1588:
        CALL  writeLineHL
L1589:
        ;;testBitwiseOperators.j(227)     if (w2 ^ b1 == 0x1228) println (132); else println (999);
L1590:
        LD    HL,(05004H)
L1591:
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
L1592:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1593:
        JP    NZ,L1861
L1594:
        LD    A,132
L1595:
        CALL  writeLineA
L1596:
        JP    L1868
L1597:
        LD    HL,999
L1598:
        CALL  writeLineHL
L1599:
        ;;testBitwiseOperators.j(228)   
L1600:
        ;;testBitwiseOperators.j(229)     //var/final var
L1601:
        ;;testBitwiseOperators.j(230)     //*************
L1602:
        ;;testBitwiseOperators.j(231)     //var byte/final var byte
L1603:
        ;;testBitwiseOperators.j(232)     if (b2 & fb1 == 0x04) println (133); else println (999);
L1604:
        LD    A,(05001H)
L1605:
        AND   A,28
L1606:
        SUB   A,4
L1607:
        JP    NZ,L1877
L1608:
        LD    A,133
L1609:
        CALL  writeLineA
L1610:
        JP    L1880
L1611:
        LD    HL,999
L1612:
        CALL  writeLineHL
L1613:
        ;;testBitwiseOperators.j(233)     if (b2 | fb1 == 0x1F) println (134); else println (999);
L1614:
        LD    A,(05001H)
L1615:
        OR    A,28
L1616:
        SUB   A,31
L1617:
        JP    NZ,L1889
L1618:
        LD    A,134
L1619:
        CALL  writeLineA
L1620:
        JP    L1892
L1621:
        LD    HL,999
L1622:
        CALL  writeLineHL
L1623:
        ;;testBitwiseOperators.j(234)     if (b2 ^ fb1 == 0x1B) println (135); else println (999);
L1624:
        LD    A,(05001H)
L1625:
        XOR   A,28
L1626:
        SUB   A,27
L1627:
        JP    NZ,L1901
L1628:
        LD    A,135
L1629:
        CALL  writeLineA
L1630:
        JP    L1905
L1631:
        LD    HL,999
L1632:
        CALL  writeLineHL
L1633:
        ;;testBitwiseOperators.j(235)     //var word/final var word
L1634:
        ;;testBitwiseOperators.j(236)     if (w2 & fw1 == 0x0224) println (136); else println (999);
L1635:
        LD    HL,(05004H)
L1636:
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
L1637:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1638:
        JP    NZ,L1914
L1639:
        LD    A,136
L1640:
        CALL  writeLineA
L1641:
        JP    L1917
L1642:
        LD    HL,999
L1643:
        CALL  writeLineHL
L1644:
        ;;testBitwiseOperators.j(237)     if (w2 | fw1 == 0x133C) println (137); else println (999);
L1645:
        LD    HL,(05004H)
L1646:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1647:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1648:
        JP    NZ,L1926
L1649:
        LD    A,137
L1650:
        CALL  writeLineA
L1651:
        JP    L1929
L1652:
        LD    HL,999
L1653:
        CALL  writeLineHL
L1654:
        ;;testBitwiseOperators.j(238)     if (w2 ^ fw1 == 0x1118) println (138); else println (999);
L1655:
        LD    HL,(05004H)
L1656:
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
L1657:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1658:
        JP    NZ,L1938
L1659:
        LD    A,138
L1660:
        CALL  writeLineA
L1661:
        JP    L1942
L1662:
        LD    HL,999
L1663:
        CALL  writeLineHL
L1664:
        ;;testBitwiseOperators.j(239)     //var byte/final var word
L1665:
        ;;testBitwiseOperators.j(240)     if (b1 & fw2 == 0x0014) println (139); else println (999);
L1666:
        LD    A,(05000H)
L1667:
        LD    L,A
        LD    H,0
L1668:
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
L1669:
        LD    A,20
L1670:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1671:
        JP    NZ,L1953
L1672:
        LD    A,139
L1673:
        CALL  writeLineA
L1674:
        JP    L1956
L1675:
        LD    HL,999
L1676:
        CALL  writeLineHL
L1677:
        ;;testBitwiseOperators.j(241)     if (b1 | fw2 == 0x123C) println (140); else println (999);
L1678:
        LD    A,(05000H)
L1679:
        LD    L,A
        LD    H,0
L1680:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1681:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1682:
        JP    NZ,L1966
L1683:
        LD    A,140
L1684:
        CALL  writeLineA
L1685:
        JP    L1969
L1686:
        LD    HL,999
L1687:
        CALL  writeLineHL
L1688:
        ;;testBitwiseOperators.j(242)     if (b1 ^ fw2 == 0x1228) println (141); else println (999);
L1689:
        LD    A,(05000H)
L1690:
        LD    L,A
        LD    H,0
L1691:
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
L1692:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1693:
        JP    NZ,L1979
L1694:
        LD    A,141
L1695:
        CALL  writeLineA
L1696:
        JP    L1983
L1697:
        LD    HL,999
L1698:
        CALL  writeLineHL
L1699:
        ;;testBitwiseOperators.j(243)     //var word/final var byte
L1700:
        ;;testBitwiseOperators.j(244)     if (w2 & fb1 == 0x0014) println (142); else println (999);
L1701:
        LD    HL,(05004H)
L1702:
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
L1703:
        LD    A,20
L1704:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1705:
        JP    NZ,L1993
L1706:
        LD    A,142
L1707:
        CALL  writeLineA
L1708:
        JP    L1996
L1709:
        LD    HL,999
L1710:
        CALL  writeLineHL
L1711:
        ;;testBitwiseOperators.j(245)     if (w2 | fb1 == 0x123C) println (143); else println (999);
L1712:
        LD    HL,(05004H)
L1713:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1714:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1715:
        JP    NZ,L2005
L1716:
        LD    A,143
L1717:
        CALL  writeLineA
L1718:
        JP    L2008
L1719:
        LD    HL,999
L1720:
        CALL  writeLineHL
L1721:
        ;;testBitwiseOperators.j(246)     if (w2 ^ fb1 == 0x1228) println (144); else println (999);
L1722:
        LD    HL,(05004H)
L1723:
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
L1724:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1725:
        JP    NZ,L2017
L1726:
        LD    A,144
L1727:
        CALL  writeLineA
L1728:
        JP    L2024
L1729:
        LD    HL,999
L1730:
        CALL  writeLineHL
L1731:
        ;;testBitwiseOperators.j(247)   
L1732:
        ;;testBitwiseOperators.j(248)     //final var/constant
L1733:
        ;;testBitwiseOperators.j(249)     //******************
L1734:
        ;;testBitwiseOperators.j(250)     //final var byte/constant byte
L1735:
        ;;testBitwiseOperators.j(251)     if (b2 & 0x1C == 0x04) println (145); else println (999);
L1736:
        LD    A,(05001H)
L1737:
        AND   A,28
L1738:
        SUB   A,4
L1739:
        JP    NZ,L2033
L1740:
        LD    A,145
L1741:
        CALL  writeLineA
L1742:
        JP    L2036
L1743:
        LD    HL,999
L1744:
        CALL  writeLineHL
L1745:
        ;;testBitwiseOperators.j(252)     if (b2 | 0x1C == 0x1F) println (146); else println (999);
L1746:
        LD    A,(05001H)
L1747:
        OR    A,28
L1748:
        SUB   A,31
L1749:
        JP    NZ,L2045
L1750:
        LD    A,146
L1751:
        CALL  writeLineA
L1752:
        JP    L2048
L1753:
        LD    HL,999
L1754:
        CALL  writeLineHL
L1755:
        ;;testBitwiseOperators.j(253)     if (b2 ^ 0x1C == 0x1B) println (147); else println (999);
L1756:
        LD    A,(05001H)
L1757:
        XOR   A,28
L1758:
        SUB   A,27
L1759:
        JP    NZ,L2057
L1760:
        LD    A,147
L1761:
        CALL  writeLineA
L1762:
        JP    L2061
L1763:
        LD    HL,999
L1764:
        CALL  writeLineHL
L1765:
        ;;testBitwiseOperators.j(254)     //final var word/constant word
L1766:
        ;;testBitwiseOperators.j(255)     if (w2 & 0x032C == 0x0224) println (148); else println (999);
L1767:
        LD    HL,(05004H)
L1768:
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
L1769:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1770:
        JP    NZ,L2070
L1771:
        LD    A,148
L1772:
        CALL  writeLineA
L1773:
        JP    L2073
L1774:
        LD    HL,999
L1775:
        CALL  writeLineHL
L1776:
        ;;testBitwiseOperators.j(256)     if (w2 | 0x032C == 0x133C) println (149); else println (999);
L1777:
        LD    HL,(05004H)
L1778:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1779:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1780:
        JP    NZ,L2082
L1781:
        LD    A,149
L1782:
        CALL  writeLineA
L1783:
        JP    L2085
L1784:
        LD    HL,999
L1785:
        CALL  writeLineHL
L1786:
        ;;testBitwiseOperators.j(257)     if (w2 ^ 0x032C == 0x1118) println (150); else println (999);
L1787:
        LD    HL,(05004H)
L1788:
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
L1789:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1790:
        JP    NZ,L2094
L1791:
        LD    A,150
L1792:
        CALL  writeLineA
L1793:
        JP    L2098
L1794:
        LD    HL,999
L1795:
        CALL  writeLineHL
L1796:
        ;;testBitwiseOperators.j(258)     //final var byte/constant word
L1797:
        ;;testBitwiseOperators.j(259)     if (b1 & 0x1234 == 0x0014) println (151); else println (999);
L1798:
        LD    A,(05000H)
L1799:
        LD    L,A
        LD    H,0
L1800:
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
L1801:
        LD    A,20
L1802:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1803:
        JP    NZ,L2109
L1804:
        LD    A,151
L1805:
        CALL  writeLineA
L1806:
        JP    L2112
L1807:
        LD    HL,999
L1808:
        CALL  writeLineHL
L1809:
        ;;testBitwiseOperators.j(260)     if (b1 | 0x1234 == 0x123C) println (152); else println (999);
L1810:
        LD    A,(05000H)
L1811:
        LD    L,A
        LD    H,0
L1812:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1813:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1814:
        JP    NZ,L2122
L1815:
        LD    A,152
L1816:
        CALL  writeLineA
L1817:
        JP    L2125
L1818:
        LD    HL,999
L1819:
        CALL  writeLineHL
L1820:
        ;;testBitwiseOperators.j(261)     if (b1 ^ 0x1234 == 0x1228) println (153); else println (999);
L1821:
        LD    A,(05000H)
L1822:
        LD    L,A
        LD    H,0
L1823:
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
L1824:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1825:
        JP    NZ,L2135
L1826:
        LD    A,153
L1827:
        CALL  writeLineA
L1828:
        JP    L2139
L1829:
        LD    HL,999
L1830:
        CALL  writeLineHL
L1831:
        ;;testBitwiseOperators.j(262)     //final var word/constant byte
L1832:
        ;;testBitwiseOperators.j(263)     if (w2 & 0x1C == 0x0014) println (154); else println (999);
L1833:
        LD    HL,(05004H)
L1834:
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
L1835:
        LD    A,20
L1836:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1837:
        JP    NZ,L2149
L1838:
        LD    A,154
L1839:
        CALL  writeLineA
L1840:
        JP    L2152
L1841:
        LD    HL,999
L1842:
        CALL  writeLineHL
L1843:
        ;;testBitwiseOperators.j(264)     if (w2 | 0x1C == 0x123C) println (155); else println (999);
L1844:
        LD    HL,(05004H)
L1845:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1846:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1847:
        JP    NZ,L2161
L1848:
        LD    A,155
L1849:
        CALL  writeLineA
L1850:
        JP    L2164
L1851:
        LD    HL,999
L1852:
        CALL  writeLineHL
L1853:
        ;;testBitwiseOperators.j(265)     if (w2 ^ 0x1C == 0x1228) println (156); else println (999);
L1854:
        LD    HL,(05004H)
L1855:
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
L1856:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1857:
        JP    NZ,L2173
L1858:
        LD    A,156
L1859:
        CALL  writeLineA
L1860:
        JP    L2180
L1861:
        LD    HL,999
L1862:
        CALL  writeLineHL
L1863:
        ;;testBitwiseOperators.j(266)   
L1864:
        ;;testBitwiseOperators.j(267)     //final var/acc
L1865:
        ;;testBitwiseOperators.j(268)     //*************
L1866:
        ;;testBitwiseOperators.j(269)     //final var byte/acc byte
L1867:
        ;;testBitwiseOperators.j(270)     if (b2 & (0x10 + 0x0C) == 0x04) println (157); else println (999);
L1868:
        LD    A,(05001H)
L1869:
        PUSH  AF
        LD    A,16
L1870:
        ADD   A,12
L1871:
        POP   BC
        AND   A,B
L1872:
        SUB   A,4
L1873:
        JP    NZ,L2191
L1874:
        LD    A,157
L1875:
        CALL  writeLineA
L1876:
        JP    L2194
L1877:
        LD    HL,999
L1878:
        CALL  writeLineHL
L1879:
        ;;testBitwiseOperators.j(271)     if (b2 | (0x10 + 0x0C) == 0x1F) println (158); else println (999);
L1880:
        LD    A,(05001H)
L1881:
        PUSH  AF
        LD    A,16
L1882:
        ADD   A,12
L1883:
        POP   BC
        OR    A,B
L1884:
        SUB   A,31
L1885:
        JP    NZ,L2205
L1886:
        LD    A,158
L1887:
        CALL  writeLineA
L1888:
        JP    L2208
L1889:
        LD    HL,999
L1890:
        CALL  writeLineHL
L1891:
        ;;testBitwiseOperators.j(272)     if (b2 ^ (0x10 + 0x0C) == 0x1B) println (159); else println (999);
L1892:
        LD    A,(05001H)
L1893:
        PUSH  AF
        LD    A,16
L1894:
        ADD   A,12
L1895:
        POP   BC
        XOR   A,B
L1896:
        SUB   A,27
L1897:
        JP    NZ,L2219
L1898:
        LD    A,159
L1899:
        CALL  writeLineA
L1900:
        JP    L2223
L1901:
        LD    HL,999
L1902:
        CALL  writeLineHL
L1903:
        ;;testBitwiseOperators.j(273)     //final var word/acc word
L1904:
        ;;testBitwiseOperators.j(274)     if (w2 & 0x0100 + 0x022C == 0x0224) println (160); else println (999);
L1905:
        LD    HL,(05004H)
L1906:
        PUSH  HL
        LD    HL,256
L1907:
        LD    DE,556
        ADD   HL,DE
L1908:
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
L1909:
        LD    DE,548
        OR    A
        SBC   HL,DE
L1910:
        JP    NZ,L2234
L1911:
        LD    A,160
L1912:
        CALL  writeLineA
L1913:
        JP    L2237
L1914:
        LD    HL,999
L1915:
        CALL  writeLineHL
L1916:
        ;;testBitwiseOperators.j(275)     if (w2 | 0x0100 + 0x022C == 0x133C) println (161); else println (999);
L1917:
        LD    HL,(05004H)
L1918:
        PUSH  HL
        LD    HL,256
L1919:
        LD    DE,556
        ADD   HL,DE
L1920:
        POP   DE
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L1921:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L1922:
        JP    NZ,L2248
L1923:
        LD    A,161
L1924:
        CALL  writeLineA
L1925:
        JP    L2251
L1926:
        LD    HL,999
L1927:
        CALL  writeLineHL
L1928:
        ;;testBitwiseOperators.j(276)     if (w2 ^ 0x0100 + 0x022C == 0x1118) println (162); else println (999);
L1929:
        LD    HL,(05004H)
L1930:
        PUSH  HL
        LD    HL,256
L1931:
        LD    DE,556
        ADD   HL,DE
L1932:
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
L1933:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L1934:
        JP    NZ,L2262
L1935:
        LD    A,162
L1936:
        CALL  writeLineA
L1937:
        JP    L2266
L1938:
        LD    HL,999
L1939:
        CALL  writeLineHL
L1940:
        ;;testBitwiseOperators.j(277)     //final var byte/acc word
L1941:
        ;;testBitwiseOperators.j(278)     if (b1 & 0x1000 + 0x0234 == 0x0014) println (163); else println (999);
L1942:
        LD    A,(05000H)
L1943:
        LD    HL,4096
L1944:
        LD    DE,564
        ADD   HL,DE
L1945:
        AND   A,L
        LD    L,A
        LD    H,0
L1946:
        LD    A,20
L1947:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1948:
        JP    NZ,L2278
L1949:
        LD    A,163
L1950:
        CALL  writeLineA
L1951:
        JP    L2281
L1952:
        LD    HL,999
L1953:
        CALL  writeLineHL
L1954:
        ;;testBitwiseOperators.j(279)     if (b1 | 0x1000 + 0x0234 == 0x123C) println (164); else println (999);
L1955:
        LD    A,(05000H)
L1956:
        LD    HL,4096
L1957:
        LD    DE,564
        ADD   HL,DE
L1958:
        OR    A,L
        LD    L,A
L1959:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1960:
        JP    NZ,L2292
L1961:
        LD    A,164
L1962:
        CALL  writeLineA
L1963:
        JP    L2295
L1964:
        LD    HL,999
L1965:
        CALL  writeLineHL
L1966:
        ;;testBitwiseOperators.j(280)     if (b1 ^ 0x1000 + 0x0234 == 0x1228) println (165); else println (999);
L1967:
        LD    A,(05000H)
L1968:
        LD    HL,4096
L1969:
        LD    DE,564
        ADD   HL,DE
L1970:
        XOR   A,L
        LD    L,A
L1971:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L1972:
        JP    NZ,L2306
L1973:
        LD    A,165
L1974:
        CALL  writeLineA
L1975:
        JP    L2310
L1976:
        LD    HL,999
L1977:
        CALL  writeLineHL
L1978:
        ;;testBitwiseOperators.j(281)     //final var word/acc byte
L1979:
        ;;testBitwiseOperators.j(282)     if (w2 & 0x10 + 0x0C == 0x0014) println (166); else println (999);
L1980:
        LD    HL,(05004H)
L1981:
        LD    A,16
L1982:
        ADD   A,12
L1983:
        AND   A,L
        LD    L,A
        LD    H,0
L1984:
        LD    A,20
L1985:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1986:
        JP    NZ,L2322
L1987:
        LD    A,166
L1988:
        CALL  writeLineA
L1989:
        JP    L2325
L1990:
        LD    HL,999
L1991:
        CALL  writeLineHL
L1992:
        ;;testBitwiseOperators.j(283)     if (w2 | 0x10 + 0x0C == 0x123C) println (167); else println (999);
L1993:
        LD    HL,(05004H)
L1994:
        LD    A,16
L1995:
        ADD   A,12
L1996:
        OR    A,L
        LD    L,A
L1997:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L1998:
        JP    NZ,L2336
L1999:
        LD    A,167
L2000:
        CALL  writeLineA
L2001:
        JP    L2339
L2002:
        LD    HL,999
L2003:
        CALL  writeLineHL
L2004:
        ;;testBitwiseOperators.j(284)     if (w2 ^ 0x10 + 0x0C == 0x1228) println (168); else println (999);
L2005:
        LD    HL,(05004H)
L2006:
        LD    A,16
L2007:
        ADD   A,12
L2008:
        XOR   A,L
        LD    L,A
L2009:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2010:
        JP    NZ,L2350
L2011:
        LD    A,168
L2012:
        CALL  writeLineA
L2013:
        JP    L2357
L2014:
        LD    HL,999
L2015:
        CALL  writeLineHL
L2016:
        ;;testBitwiseOperators.j(285)   
L2017:
        ;;testBitwiseOperators.j(286)     //final var/var
L2018:
        ;;testBitwiseOperators.j(287)     //*************
L2019:
        ;;testBitwiseOperators.j(288)     //final var byte/var byte
L2020:
        ;;testBitwiseOperators.j(289)     if (b2 & b1 == 0x04) println (169); else println (999);
L2021:
        LD    A,(05001H)
L2022:
        LD    B,A
        LD    A,(05000H)
        AND   A,B
L2023:
        SUB   A,4
L2024:
        JP    NZ,L2366
L2025:
        LD    A,169
L2026:
        CALL  writeLineA
L2027:
        JP    L2369
L2028:
        LD    HL,999
L2029:
        CALL  writeLineHL
L2030:
        ;;testBitwiseOperators.j(290)     if (b2 | b1 == 0x1F) println (170); else println (999);
L2031:
        LD    A,(05001H)
L2032:
        LD    B,A
        LD    A,(05000H)
        OR    A,B
L2033:
        SUB   A,31
L2034:
        JP    NZ,L2378
L2035:
        LD    A,170
L2036:
        CALL  writeLineA
L2037:
        JP    L2381
L2038:
        LD    HL,999
L2039:
        CALL  writeLineHL
L2040:
        ;;testBitwiseOperators.j(291)     if (b2 ^ b1 == 0x1B) println (171); else println (999);
L2041:
        LD    A,(05001H)
L2042:
        LD    B,A
        LD    A,(05000H)
        XOR   A,B
L2043:
        SUB   A,27
L2044:
        JP    NZ,L2390
L2045:
        LD    A,171
L2046:
        CALL  writeLineA
L2047:
        JP    L2394
L2048:
        LD    HL,999
L2049:
        CALL  writeLineHL
L2050:
        ;;testBitwiseOperators.j(292)     //final var word/var word
L2051:
        ;;testBitwiseOperators.j(293)     if (w2 & w1 == 0x0224) println (172); else println (999);
L2052:
        LD    HL,(05004H)
L2053:
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
L2054:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2055:
        JP    NZ,L2403
L2056:
        LD    A,172
L2057:
        CALL  writeLineA
L2058:
        JP    L2406
L2059:
        LD    HL,999
L2060:
        CALL  writeLineHL
L2061:
        ;;testBitwiseOperators.j(294)     if (w2 | w1 == 0x133C) println (173); else println (999);
L2062:
        LD    HL,(05004H)
L2063:
        LD    DE,(05002H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2064:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2065:
        JP    NZ,L2415
L2066:
        LD    A,173
L2067:
        CALL  writeLineA
L2068:
        JP    L2418
L2069:
        LD    HL,999
L2070:
        CALL  writeLineHL
L2071:
        ;;testBitwiseOperators.j(295)     if (w2 ^ w1 == 0x1118) println (174); else println (999);
L2072:
        LD    HL,(05004H)
L2073:
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
L2074:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2075:
        JP    NZ,L2427
L2076:
        LD    A,174
L2077:
        CALL  writeLineA
L2078:
        JP    L2431
L2079:
        LD    HL,999
L2080:
        CALL  writeLineHL
L2081:
        ;;testBitwiseOperators.j(296)     //final var byte/var word
L2082:
        ;;testBitwiseOperators.j(297)     if (b1 & w2 == 0x0014) println (175); else println (999);
L2083:
        LD    A,(05000H)
L2084:
        LD    L,A
        LD    H,0
L2085:
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
L2086:
        LD    A,20
L2087:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2088:
        JP    NZ,L2442
L2089:
        LD    A,175
L2090:
        CALL  writeLineA
L2091:
        JP    L2445
L2092:
        LD    HL,999
L2093:
        CALL  writeLineHL
L2094:
        ;;testBitwiseOperators.j(298)     if (b1 | w2 == 0x123C) println (176); else println (999);
L2095:
        LD    A,(05000H)
L2096:
        LD    L,A
        LD    H,0
L2097:
        LD    DE,(05004H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2098:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2099:
        JP    NZ,L2455
L2100:
        LD    A,176
L2101:
        CALL  writeLineA
L2102:
        JP    L2458
L2103:
        LD    HL,999
L2104:
        CALL  writeLineHL
L2105:
        ;;testBitwiseOperators.j(299)     if (b1 ^ w2 == 0x1228) println (177); else println (999);
L2106:
        LD    A,(05000H)
L2107:
        LD    L,A
        LD    H,0
L2108:
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
L2109:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2110:
        JP    NZ,L2468
L2111:
        LD    A,177
L2112:
        CALL  writeLineA
L2113:
        JP    L2472
L2114:
        LD    HL,999
L2115:
        CALL  writeLineHL
L2116:
        ;;testBitwiseOperators.j(300)     //final var word/var byte
L2117:
        ;;testBitwiseOperators.j(301)     if (w2 & b1 == 0x0014) println (178); else println (999);
L2118:
        LD    HL,(05004H)
L2119:
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
L2120:
        LD    A,20
L2121:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2122:
        JP    NZ,L2482
L2123:
        LD    A,178
L2124:
        CALL  writeLineA
L2125:
        JP    L2485
L2126:
        LD    HL,999
L2127:
        CALL  writeLineHL
L2128:
        ;;testBitwiseOperators.j(302)     if (w2 | b1 == 0x123C) println (179); else println (999);
L2129:
        LD    HL,(05004H)
L2130:
        LD    DE,(05000H)
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2131:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2132:
        JP    NZ,L2494
L2133:
        LD    A,179
L2134:
        CALL  writeLineA
L2135:
        JP    L2497
L2136:
        LD    HL,999
L2137:
        CALL  writeLineHL
L2138:
        ;;testBitwiseOperators.j(303)     if (w2 ^ b1 == 0x1228) println (180); else println (999);
L2139:
        LD    HL,(05004H)
L2140:
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
L2141:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2142:
        JP    NZ,L2506
L2143:
        LD    A,180
L2144:
        CALL  writeLineA
L2145:
        JP    L2513
L2146:
        LD    HL,999
L2147:
        CALL  writeLineHL
L2148:
        ;;testBitwiseOperators.j(304)   
L2149:
        ;;testBitwiseOperators.j(305)     //final var/final var
L2150:
        ;;testBitwiseOperators.j(306)     //*******************
L2151:
        ;;testBitwiseOperators.j(307)     //final var byte/final var byte
L2152:
        ;;testBitwiseOperators.j(308)     if (fb2 & fb1 == 0x04) println (181); else println (999);
L2153:
        LD    A,7
L2154:
        AND   A,28
L2155:
        SUB   A,4
L2156:
        JP    NZ,L2522
L2157:
        LD    A,181
L2158:
        CALL  writeLineA
L2159:
        JP    L2525
L2160:
        LD    HL,999
L2161:
        CALL  writeLineHL
L2162:
        ;;testBitwiseOperators.j(309)     if (fb2 | fb1 == 0x1F) println (182); else println (999);
L2163:
        LD    A,7
L2164:
        OR    A,28
L2165:
        SUB   A,31
L2166:
        JP    NZ,L2534
L2167:
        LD    A,182
L2168:
        CALL  writeLineA
L2169:
        JP    L2537
L2170:
        LD    HL,999
L2171:
        CALL  writeLineHL
L2172:
        ;;testBitwiseOperators.j(310)     if (fb2 ^ fb1 == 0x1B) println (183); else println (999);
L2173:
        LD    A,7
L2174:
        XOR   A,28
L2175:
        SUB   A,27
L2176:
        JP    NZ,L2546
L2177:
        LD    A,183
L2178:
        CALL  writeLineA
L2179:
        JP    L2550
L2180:
        LD    HL,999
L2181:
        CALL  writeLineHL
L2182:
        ;;testBitwiseOperators.j(311)     //final var word/final var word
L2183:
        ;;testBitwiseOperators.j(312)     if (fw2 & fw1 == 0x0224) println (184); else println (999);
L2184:
        LD    HL,4660
L2185:
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
L2186:
        LD    DE,548
        OR    A
        SBC   HL,DE
L2187:
        JP    NZ,L2559
L2188:
        LD    A,184
L2189:
        CALL  writeLineA
L2190:
        JP    L2562
L2191:
        LD    HL,999
L2192:
        CALL  writeLineHL
L2193:
        ;;testBitwiseOperators.j(313)     if (fw2 | fw1 == 0x133C) println (185); else println (999);
L2194:
        LD    HL,4660
L2195:
        LD    DE,812
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2196:
        LD    DE,4924
        OR    A
        SBC   HL,DE
L2197:
        JP    NZ,L2571
L2198:
        LD    A,185
L2199:
        CALL  writeLineA
L2200:
        JP    L2574
L2201:
        LD    HL,999
L2202:
        CALL  writeLineHL
L2203:
        ;;testBitwiseOperators.j(314)     if (fw2 ^ fw1 == 0x1118) println (186); else println (999);
L2204:
        LD    HL,4660
L2205:
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
L2206:
        LD    DE,4376
        OR    A
        SBC   HL,DE
L2207:
        JP    NZ,L2583
L2208:
        LD    A,186
L2209:
        CALL  writeLineA
L2210:
        JP    L2587
L2211:
        LD    HL,999
L2212:
        CALL  writeLineHL
L2213:
        ;;testBitwiseOperators.j(315)     //final var byte/final var word
L2214:
        ;;testBitwiseOperators.j(316)     if (fb1 & fw2 == 0x0014) println (187); else println (999);
L2215:
        LD    A,28
L2216:
        LD    L,A
        LD    H,0
L2217:
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
L2218:
        LD    A,20
L2219:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2220:
        JP    NZ,L2598
L2221:
        LD    A,187
L2222:
        CALL  writeLineA
L2223:
        JP    L2601
L2224:
        LD    HL,999
L2225:
        CALL  writeLineHL
L2226:
        ;;testBitwiseOperators.j(317)     if (fb1 | fw2 == 0x123C) println (188); else println (999);
L2227:
        LD    A,28
L2228:
        LD    L,A
        LD    H,0
L2229:
        LD    DE,4660
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2230:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2231:
        JP    NZ,L2611
L2232:
        LD    A,188
L2233:
        CALL  writeLineA
L2234:
        JP    L2614
L2235:
        LD    HL,999
L2236:
        CALL  writeLineHL
L2237:
        ;;testBitwiseOperators.j(318)     if (fb1 ^ fw2 == 0x1228) println (189); else println (999);
L2238:
        LD    A,28
L2239:
        LD    L,A
        LD    H,0
L2240:
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
L2241:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2242:
        JP    NZ,L2624
L2243:
        LD    A,189
L2244:
        CALL  writeLineA
L2245:
        JP    L2628
L2246:
        LD    HL,999
L2247:
        CALL  writeLineHL
L2248:
        ;;testBitwiseOperators.j(319)     //final var word/final var byte
L2249:
        ;;testBitwiseOperators.j(320)     if (fw2 & fb1 == 0x0014) println (190); else println (999);
L2250:
        LD    HL,4660
L2251:
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
L2252:
        LD    A,20
L2253:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L2254:
        JP    NZ,L2638
L2255:
        LD    A,190
L2256:
        CALL  writeLineA
L2257:
        JP    L2641
L2258:
        LD    HL,999
L2259:
        CALL  writeLineHL
L2260:
        ;;testBitwiseOperators.j(321)     if (fw2 | fb1 == 0x123C) println (191); else println (999);
L2261:
        LD    HL,4660
L2262:
        LD    DE,28
        LD    B,A
        LD    A,H
        OR    A,D
        LD    H,A
        LD    A,L
        OR    A,E
        LD    L,A
        LD    A,B
L2263:
        LD    DE,4668
        OR    A
        SBC   HL,DE
L2264:
        JP    NZ,L2650
L2265:
        LD    A,191
L2266:
        CALL  writeLineA
L2267:
        JP    L2653
L2268:
        LD    HL,999
L2269:
        CALL  writeLineHL
L2270:
        ;;testBitwiseOperators.j(322)     if (fw2 ^ fb1 == 0x1228) println (192); else println (999);
L2271:
        LD    HL,4660
L2272:
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
L2273:
        LD    DE,4648
        OR    A
        SBC   HL,DE
L2274:
        JP    NZ,L2662
L2275:
        LD    A,192
L2276:
        CALL  writeLineA
L2277:
        JP    L2666
L2278:
        LD    HL,999
L2279:
        CALL  writeLineHL
L2280:
        ;;testBitwiseOperators.j(323)   
L2281:
        ;;testBitwiseOperators.j(324)     println("Klaar");
L2282:
        LD    HL,L2289
L2283:
        CALL  writeLineStr
L2284:
        ;;testBitwiseOperators.j(325)   }
L2285:
        LD    SP,IX
L2286:
        POP   IX
L2287:
        return
L2288:
        ;;testBitwiseOperators.j(326) }
L2289:
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
