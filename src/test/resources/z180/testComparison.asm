SOC     equ 02000H        ;start of code, i.e.lowest external RAM address.
TOS     equ 0FD00H        ;top of stack, i.e. bottom of MONITOR user global data.
        .ORG  SOC
start:
        LD    SP,TOS
L0:
        CALL  L9
L1:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2:
        ;;testComparison.j(0) /*
L3:
        ;;testComparison.j(1)  * A small program in the miniJava language.
L4:
        ;;testComparison.j(2)  * Test comparison
L5:
        ;;testComparison.j(3)  */
L6:
        ;;testComparison.j(4) class TestComparison {
L7:
        ;class TestComparison []
L8:
        ;;testComparison.j(5)   private static word zero = 0;
L9:
        LD    A,0
L10:
        LD    (05000H),A
L11:
        ;;testComparison.j(6)   private static word one = 1;
L12:
        LD    A,1
L13:
        LD    (05002H),A
L14:
        ;;testComparison.j(7)   private static word three = 3;
L15:
        LD    A,3
L16:
        LD    (05004H),A
L17:
        ;;testComparison.j(8)   private static word four = 4;
L18:
        LD    A,4
L19:
        LD    (05006H),A
L20:
        ;;testComparison.j(9)   private static word five = 5;
L21:
        LD    A,5
L22:
        LD    (05008H),A
L23:
        ;;testComparison.j(10)   private static word twelve = 12;
L24:
        LD    A,12
L25:
        LD    (0500AH),A
L26:
        ;;testComparison.j(11)   private static byte byteOne = 1;
L27:
        LD    A,1
L28:
        LD    (0500CH),A
L29:
        ;;testComparison.j(12)   private static byte byteSix = 262;
L30:
        LD    HL,262
L31:
        LD    (0500DH),HL
L32:
        JP    L36
L33:
        ;;testComparison.j(13)   private static byte b;
L34:
        ;;testComparison.j(14)   
L35:
        ;;testComparison.j(15)   public static void main() {
L36:
        ;method TestComparison.main [public, static] void ()
L37:
        PUSH  IX
L38:
        LD    IX,0x0000
        ADD   IX,SP
L39:
        DEC   SP
        DEC   SP
        DEC   SP
        DEC   SP
L40:
        ;;testComparison.j(16)     //stack level 1
L41:
        ;;testComparison.j(17)     //byte-byte
L42:
        ;;testComparison.j(18)     if (4 == 12/(1+2)) println(0);
L43:
        LD    A,12
L44:
        PUSH  AF
        LD    A,1
L45:
        ADD   A,2
L46:
        LD    C,A
        POP   AF
        CALL  div8
L47:
        SUB   A,4
L48:
        JP    NZ,L52
L49:
        LD    A,0
L50:
        CALL  writeLineA
L51:
        ;;testComparison.j(19)     if (4 == 4) println(1);
L52:
        LD    A,4
L53:
        SUB   A,4
L54:
        JP    NZ,L58
L55:
        LD    A,1
L56:
        CALL  writeLineA
L57:
        ;;testComparison.j(20)     if (3 != 12/(1+2)) println(2);
L58:
        LD    A,12
L59:
        PUSH  AF
        LD    A,1
L60:
        ADD   A,2
L61:
        LD    C,A
        POP   AF
        CALL  div8
L62:
        SUB   A,3
L63:
        JP    Z,L67
L64:
        LD    A,2
L65:
        CALL  writeLineA
L66:
        ;;testComparison.j(21)     if (3 != 4) println(3);
L67:
        LD    A,3
L68:
        SUB   A,4
L69:
        JP    Z,L73
L70:
        LD    A,3
L71:
        CALL  writeLineA
L72:
        ;;testComparison.j(22)     if (3 < 12/(1+2)) println(4);
L73:
        LD    A,12
L74:
        PUSH  AF
        LD    A,1
L75:
        ADD   A,2
L76:
        LD    C,A
        POP   AF
        CALL  div8
L77:
        SUB   A,3
L78:
        JP    C,L82
        JP    Z,L82
L79:
        LD    A,4
L80:
        CALL  writeLineA
L81:
        ;;testComparison.j(23)     if (3 < 4) println(5);
L82:
        LD    A,3
L83:
        SUB   A,4
L84:
        JP    NC,L88
L85:
        LD    A,5
L86:
        CALL  writeLineA
L87:
        ;;testComparison.j(24)     if (5 > 12/(1+2)) println(6);
L88:
        LD    A,12
L89:
        PUSH  AF
        LD    A,1
L90:
        ADD   A,2
L91:
        LD    C,A
        POP   AF
        CALL  div8
L92:
        SUB   A,5
L93:
        JP    NC,L97
L94:
        LD    A,6
L95:
        CALL  writeLineA
L96:
        ;;testComparison.j(25)     if (5 > 4) println(7);
L97:
        LD    A,5
L98:
        SUB   A,4
L99:
        JP    C,L103
        JP    Z,L103
L100:
        LD    A,7
L101:
        CALL  writeLineA
L102:
        ;;testComparison.j(26)     if (3 <= 12/(1+2)) println(8);
L103:
        LD    A,12
L104:
        PUSH  AF
        LD    A,1
L105:
        ADD   A,2
L106:
        LD    C,A
        POP   AF
        CALL  div8
L107:
        SUB   A,3
L108:
        JP    C,L112
L109:
        LD    A,8
L110:
        CALL  writeLineA
L111:
        ;;testComparison.j(27)     if (3 <= 4) println(9);
L112:
        LD    A,3
L113:
        SUB   A,4
L114:
        JR    Z,$+3
        JP    NC,L118
L115:
        LD    A,9
L116:
        CALL  writeLineA
L117:
        ;;testComparison.j(28)     if (4 <= 12/(1+2)) println(10);
L118:
        LD    A,12
L119:
        PUSH  AF
        LD    A,1
L120:
        ADD   A,2
L121:
        LD    C,A
        POP   AF
        CALL  div8
L122:
        SUB   A,4
L123:
        JP    C,L127
L124:
        LD    A,10
L125:
        CALL  writeLineA
L126:
        ;;testComparison.j(29)     if (4 <= 4) println(11);
L127:
        LD    A,4
L128:
        SUB   A,4
L129:
        JR    Z,$+3
        JP    NC,L133
L130:
        LD    A,11
L131:
        CALL  writeLineA
L132:
        ;;testComparison.j(30)     if (5 >= 12/(1+2)) println(12);
L133:
        LD    A,12
L134:
        PUSH  AF
        LD    A,1
L135:
        ADD   A,2
L136:
        LD    C,A
        POP   AF
        CALL  div8
L137:
        SUB   A,5
L138:
        JR    Z,$+3
        JP    NC,L142
L139:
        LD    A,12
L140:
        CALL  writeLineA
L141:
        ;;testComparison.j(31)     if (5 >= 4) println(13);
L142:
        LD    A,5
L143:
        SUB   A,4
L144:
        JP    C,L148
L145:
        LD    A,13
L146:
        CALL  writeLineA
L147:
        ;;testComparison.j(32)     if (4 >= 12/(1+2)) println(14);
L148:
        LD    A,12
L149:
        PUSH  AF
        LD    A,1
L150:
        ADD   A,2
L151:
        LD    C,A
        POP   AF
        CALL  div8
L152:
        SUB   A,4
L153:
        JR    Z,$+3
        JP    NC,L157
L154:
        LD    A,14
L155:
        CALL  writeLineA
L156:
        ;;testComparison.j(33)     if (4 >= 4) println(15);
L157:
        LD    A,4
L158:
        SUB   A,4
L159:
        JP    C,L165
L160:
        LD    A,15
L161:
        CALL  writeLineA
L162:
        ;;testComparison.j(34)     //stack level 1
L163:
        ;;testComparison.j(35)     //byte-integer
L164:
        ;;testComparison.j(36)     if (4 == twelve/(1+2)) println(16);
L165:
        LD    HL,(0500AH)
L166:
        LD    A,1
L167:
        ADD   A,2
L168:
        CALL  div16_8
L169:
        LD    A,4
L170:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L171:
        JP    NZ,L175
L172:
        LD    A,16
L173:
        CALL  writeLineA
L174:
        ;;testComparison.j(37)     if (4 == four) println(17);
L175:
        LD    HL,(05006H)
L176:
        LD    A,4
L177:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L178:
        JP    NZ,L182
L179:
        LD    A,17
L180:
        CALL  writeLineA
L181:
        ;;testComparison.j(38)     if (3 != twelve/(1+2)) println(18);
L182:
        LD    HL,(0500AH)
L183:
        LD    A,1
L184:
        ADD   A,2
L185:
        CALL  div16_8
L186:
        LD    A,3
L187:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L188:
        JP    Z,L192
L189:
        LD    A,18
L190:
        CALL  writeLineA
L191:
        ;;testComparison.j(39)     if (3 != four) println(19);
L192:
        LD    HL,(05006H)
L193:
        LD    A,3
L194:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L195:
        JP    Z,L199
L196:
        LD    A,19
L197:
        CALL  writeLineA
L198:
        ;;testComparison.j(40)     if (3 < twelve/(1+2)) println(20);
L199:
        LD    HL,(0500AH)
L200:
        LD    A,1
L201:
        ADD   A,2
L202:
        CALL  div16_8
L203:
        LD    A,3
L204:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L205:
        JP    NC,L209
L206:
        LD    A,20
L207:
        CALL  writeLineA
L208:
        ;;testComparison.j(41)     if (3 < four) println(21);
L209:
        LD    HL,(05006H)
L210:
        LD    A,3
L211:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L212:
        JP    NC,L216
L213:
        LD    A,21
L214:
        CALL  writeLineA
L215:
        ;;testComparison.j(42)     if (5 > twelve/(1+2)) println(22);
L216:
        LD    HL,(0500AH)
L217:
        LD    A,1
L218:
        ADD   A,2
L219:
        CALL  div16_8
L220:
        LD    A,5
L221:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L222:
        JP    C,L226
        JP    Z,L226
L223:
        LD    A,22
L224:
        CALL  writeLineA
L225:
        ;;testComparison.j(43)     if (5 > four) println(23);
L226:
        LD    HL,(05006H)
L227:
        LD    A,5
L228:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L229:
        JP    C,L233
        JP    Z,L233
L230:
        LD    A,23
L231:
        CALL  writeLineA
L232:
        ;;testComparison.j(44)     if (3 <= twelve/(1+2)) println(24);
L233:
        LD    HL,(0500AH)
L234:
        LD    A,1
L235:
        ADD   A,2
L236:
        CALL  div16_8
L237:
        LD    A,3
L238:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L239:
        JR    Z,$+3
        JP    NC,L243
L240:
        LD    A,24
L241:
        CALL  writeLineA
L242:
        ;;testComparison.j(45)     if (3 <= four) println(25);
L243:
        LD    HL,(05006H)
L244:
        LD    A,3
L245:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L246:
        JR    Z,$+3
        JP    NC,L250
L247:
        LD    A,25
L248:
        CALL  writeLineA
L249:
        ;;testComparison.j(46)     if (4 <= twelve/(1+2)) println(26);
L250:
        LD    HL,(0500AH)
L251:
        LD    A,1
L252:
        ADD   A,2
L253:
        CALL  div16_8
L254:
        LD    A,4
L255:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L256:
        JR    Z,$+3
        JP    NC,L260
L257:
        LD    A,26
L258:
        CALL  writeLineA
L259:
        ;;testComparison.j(47)     if (4 <= four) println(27);
L260:
        LD    HL,(05006H)
L261:
        LD    A,4
L262:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L263:
        JR    Z,$+3
        JP    NC,L267
L264:
        LD    A,27
L265:
        CALL  writeLineA
L266:
        ;;testComparison.j(48)     if (5 >= twelve/(1+2)) println(28);
L267:
        LD    HL,(0500AH)
L268:
        LD    A,1
L269:
        ADD   A,2
L270:
        CALL  div16_8
L271:
        LD    A,5
L272:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L273:
        JP    C,L277
L274:
        LD    A,28
L275:
        CALL  writeLineA
L276:
        ;;testComparison.j(49)     if (5 >= four) println(29);
L277:
        LD    HL,(05006H)
L278:
        LD    A,5
L279:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L280:
        JP    C,L284
L281:
        LD    A,29
L282:
        CALL  writeLineA
L283:
        ;;testComparison.j(50)     if (4 >= twelve/(1+2)) println(30);
L284:
        LD    HL,(0500AH)
L285:
        LD    A,1
L286:
        ADD   A,2
L287:
        CALL  div16_8
L288:
        LD    A,4
L289:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L290:
        JP    C,L294
L291:
        LD    A,30
L292:
        CALL  writeLineA
L293:
        ;;testComparison.j(51)     if (4 >= four) println(31);
L294:
        LD    HL,(05006H)
L295:
        LD    A,4
L296:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L297:
        JP    C,L303
L298:
        LD    A,31
L299:
        CALL  writeLineA
L300:
        ;;testComparison.j(52)     //stack level 1
L301:
        ;;testComparison.j(53)     //integer-byte
L302:
        ;;testComparison.j(54)     if (four == 12/(1+2)) println(32);
L303:
        LD    A,12
L304:
        PUSH  AF
        LD    A,1
L305:
        ADD   A,2
L306:
        LD    C,A
        POP   AF
        CALL  div8
L307:
        LD    HL,(05006H)
L308:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L309:
        JP    NZ,L313
L310:
        LD    A,32
L311:
        CALL  writeLineA
L312:
        ;;testComparison.j(55)     if (four == 4) println(33);
L313:
        LD    HL,(05006H)
L314:
        LD    A,4
L315:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L316:
        JP    NZ,L320
L317:
        LD    A,33
L318:
        CALL  writeLineA
L319:
        ;;testComparison.j(56)     if (three != 12/(1+2)) println(34);
L320:
        LD    A,12
L321:
        PUSH  AF
        LD    A,1
L322:
        ADD   A,2
L323:
        LD    C,A
        POP   AF
        CALL  div8
L324:
        LD    HL,(05004H)
L325:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L326:
        JP    Z,L330
L327:
        LD    A,34
L328:
        CALL  writeLineA
L329:
        ;;testComparison.j(57)     if (three != 4) println(35);
L330:
        LD    HL,(05004H)
L331:
        LD    A,4
L332:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L333:
        JP    Z,L337
L334:
        LD    A,35
L335:
        CALL  writeLineA
L336:
        ;;testComparison.j(58)     if (three < 12/(1+2)) println(36);
L337:
        LD    A,12
L338:
        PUSH  AF
        LD    A,1
L339:
        ADD   A,2
L340:
        LD    C,A
        POP   AF
        CALL  div8
L341:
        LD    HL,(05004H)
L342:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L343:
        JP    NC,L347
L344:
        LD    A,36
L345:
        CALL  writeLineA
L346:
        ;;testComparison.j(59)     if (three < 4) println(37);
L347:
        LD    HL,(05004H)
L348:
        LD    A,4
L349:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L350:
        JP    NC,L354
L351:
        LD    A,37
L352:
        CALL  writeLineA
L353:
        ;;testComparison.j(60)     if (five > 12/(1+2)) println(38);
L354:
        LD    A,12
L355:
        PUSH  AF
        LD    A,1
L356:
        ADD   A,2
L357:
        LD    C,A
        POP   AF
        CALL  div8
L358:
        LD    HL,(05008H)
L359:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L360:
        JP    C,L364
        JP    Z,L364
L361:
        LD    A,38
L362:
        CALL  writeLineA
L363:
        ;;testComparison.j(61)     if (five > 4) println(39);
L364:
        LD    HL,(05008H)
L365:
        LD    A,4
L366:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L367:
        JP    C,L371
        JP    Z,L371
L368:
        LD    A,39
L369:
        CALL  writeLineA
L370:
        ;;testComparison.j(62)     if (three <= 12/(1+2)) println(40);
L371:
        LD    A,12
L372:
        PUSH  AF
        LD    A,1
L373:
        ADD   A,2
L374:
        LD    C,A
        POP   AF
        CALL  div8
L375:
        LD    HL,(05004H)
L376:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L377:
        JR    Z,$+3
        JP    NC,L381
L378:
        LD    A,40
L379:
        CALL  writeLineA
L380:
        ;;testComparison.j(63)     if (three <= 4) println(41);
L381:
        LD    HL,(05004H)
L382:
        LD    A,4
L383:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L384:
        JR    Z,$+3
        JP    NC,L388
L385:
        LD    A,41
L386:
        CALL  writeLineA
L387:
        ;;testComparison.j(64)     if (four <= 12/(1+2)) println(42);
L388:
        LD    A,12
L389:
        PUSH  AF
        LD    A,1
L390:
        ADD   A,2
L391:
        LD    C,A
        POP   AF
        CALL  div8
L392:
        LD    HL,(05006H)
L393:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L394:
        JR    Z,$+3
        JP    NC,L398
L395:
        LD    A,42
L396:
        CALL  writeLineA
L397:
        ;;testComparison.j(65)     if (four <= 4) println(43);
L398:
        LD    HL,(05006H)
L399:
        LD    A,4
L400:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L401:
        JR    Z,$+3
        JP    NC,L405
L402:
        LD    A,43
L403:
        CALL  writeLineA
L404:
        ;;testComparison.j(66)     if (five >= 12/(1+2)) println(44);
L405:
        LD    A,12
L406:
        PUSH  AF
        LD    A,1
L407:
        ADD   A,2
L408:
        LD    C,A
        POP   AF
        CALL  div8
L409:
        LD    HL,(05008H)
L410:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L411:
        JP    C,L415
L412:
        LD    A,44
L413:
        CALL  writeLineA
L414:
        ;;testComparison.j(67)     if (five >= 4) println(45);
L415:
        LD    HL,(05008H)
L416:
        LD    A,4
L417:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L418:
        JP    C,L422
L419:
        LD    A,45
L420:
        CALL  writeLineA
L421:
        ;;testComparison.j(68)     if (four >= 12/(1+2)) println(46);
L422:
        LD    A,12
L423:
        PUSH  AF
        LD    A,1
L424:
        ADD   A,2
L425:
        LD    C,A
        POP   AF
        CALL  div8
L426:
        LD    HL,(05006H)
L427:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L428:
        JP    C,L432
L429:
        LD    A,46
L430:
        CALL  writeLineA
L431:
        ;;testComparison.j(69)     if (four >= 4) println(47);
L432:
        LD    HL,(05006H)
L433:
        LD    A,4
L434:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L435:
        JP    C,L441
L436:
        LD    A,47
L437:
        CALL  writeLineA
L438:
        ;;testComparison.j(70)     //stack level 1
L439:
        ;;testComparison.j(71)     //integer-integer
L440:
        ;;testComparison.j(72)     if (400 == 1200/(1+2)) println(48);
L441:
        LD    HL,1200
L442:
        LD    A,1
L443:
        ADD   A,2
L444:
        CALL  div16_8
L445:
        LD    DE,400
        OR    A
        SBC   HL,DE
L446:
        JP    NZ,L450
L447:
        LD    A,48
L448:
        CALL  writeLineA
L449:
        ;;testComparison.j(73)     if (400 == 400) println(49);
L450:
        LD    HL,400
L451:
        LD    DE,400
        OR    A
        SBC   HL,DE
L452:
        JP    NZ,L456
L453:
        LD    A,49
L454:
        CALL  writeLineA
L455:
        ;;testComparison.j(74)     if (300 != 1200/(1+2)) println(50);
L456:
        LD    HL,1200
L457:
        LD    A,1
L458:
        ADD   A,2
L459:
        CALL  div16_8
L460:
        LD    DE,300
        OR    A
        SBC   HL,DE
L461:
        JP    Z,L465
L462:
        LD    A,50
L463:
        CALL  writeLineA
L464:
        ;;testComparison.j(75)     if (300 != 400) println(51);
L465:
        LD    HL,300
L466:
        LD    DE,400
        OR    A
        SBC   HL,DE
L467:
        JP    Z,L471
L468:
        LD    A,51
L469:
        CALL  writeLineA
L470:
        ;;testComparison.j(76)     if (300 < 1200/(1+2)) println(52);
L471:
        LD    HL,1200
L472:
        LD    A,1
L473:
        ADD   A,2
L474:
        CALL  div16_8
L475:
        LD    DE,300
        OR    A
        SBC   HL,DE
L476:
        JP    C,L480
        JP    Z,L480
L477:
        LD    A,52
L478:
        CALL  writeLineA
L479:
        ;;testComparison.j(77)     if (300 < 400) println(53);
L480:
        LD    HL,300
L481:
        LD    DE,400
        OR    A
        SBC   HL,DE
L482:
        JP    NC,L486
L483:
        LD    A,53
L484:
        CALL  writeLineA
L485:
        ;;testComparison.j(78)     if (500 > 1200/(1+2)) println(54);
L486:
        LD    HL,1200
L487:
        LD    A,1
L488:
        ADD   A,2
L489:
        CALL  div16_8
L490:
        LD    DE,500
        OR    A
        SBC   HL,DE
L491:
        JP    NC,L495
L492:
        LD    A,54
L493:
        CALL  writeLineA
L494:
        ;;testComparison.j(79)     if (500 > 400) println(55);
L495:
        LD    HL,500
L496:
        LD    DE,400
        OR    A
        SBC   HL,DE
L497:
        JP    C,L501
        JP    Z,L501
L498:
        LD    A,55
L499:
        CALL  writeLineA
L500:
        ;;testComparison.j(80)     if (300 <= 1200/(1+2)) println(56);
L501:
        LD    HL,1200
L502:
        LD    A,1
L503:
        ADD   A,2
L504:
        CALL  div16_8
L505:
        LD    DE,300
        OR    A
        SBC   HL,DE
L506:
        JP    C,L510
L507:
        LD    A,56
L508:
        CALL  writeLineA
L509:
        ;;testComparison.j(81)     if (300 <= 400) println(57);
L510:
        LD    HL,300
L511:
        LD    DE,400
        OR    A
        SBC   HL,DE
L512:
        JR    Z,$+3
        JP    NC,L516
L513:
        LD    A,57
L514:
        CALL  writeLineA
L515:
        ;;testComparison.j(82)     if (400 <= 1200/(1+2)) println(58);
L516:
        LD    HL,1200
L517:
        LD    A,1
L518:
        ADD   A,2
L519:
        CALL  div16_8
L520:
        LD    DE,400
        OR    A
        SBC   HL,DE
L521:
        JP    C,L525
L522:
        LD    A,58
L523:
        CALL  writeLineA
L524:
        ;;testComparison.j(83)     if (400 <= 400) println(59);
L525:
        LD    HL,400
L526:
        LD    DE,400
        OR    A
        SBC   HL,DE
L527:
        JR    Z,$+3
        JP    NC,L531
L528:
        LD    A,59
L529:
        CALL  writeLineA
L530:
        ;;testComparison.j(84)     if (500 >= 1200/(1+2)) println(60);
L531:
        LD    HL,1200
L532:
        LD    A,1
L533:
        ADD   A,2
L534:
        CALL  div16_8
L535:
        LD    DE,500
        OR    A
        SBC   HL,DE
L536:
        JR    Z,$+3
        JP    NC,L540
L537:
        LD    A,60
L538:
        CALL  writeLineA
L539:
        ;;testComparison.j(85)     if (500 >= 400) println(61);
L540:
        LD    HL,500
L541:
        LD    DE,400
        OR    A
        SBC   HL,DE
L542:
        JP    C,L546
L543:
        LD    A,61
L544:
        CALL  writeLineA
L545:
        ;;testComparison.j(86)     if (400 >= 1200/(1+2)) println(62);
L546:
        LD    HL,1200
L547:
        LD    A,1
L548:
        ADD   A,2
L549:
        CALL  div16_8
L550:
        LD    DE,400
        OR    A
        SBC   HL,DE
L551:
        JR    Z,$+3
        JP    NC,L555
L552:
        LD    A,62
L553:
        CALL  writeLineA
L554:
        ;;testComparison.j(87)     if (400 >= 400) println(63);
L555:
        LD    HL,400
L556:
        LD    DE,400
        OR    A
        SBC   HL,DE
L557:
        JP    C,L563
L558:
        LD    A,63
L559:
        CALL  writeLineA
L560:
        ;;testComparison.j(88)   
L561:
        ;;testComparison.j(89)     //stack level 2
L562:
        ;;testComparison.j(90)     if (one+three == 12/(1+2)) println(64);
L563:
        LD    HL,(05002H)
L564:
        LD    DE,(05004H)
        ADD   HL,DE
L565:
        PUSH HL
L566:
        LD    A,12
L567:
        PUSH  AF
        LD    A,1
L568:
        ADD   A,2
L569:
        LD    C,A
        POP   AF
        CALL  div8
L570:
        POP  HL
L571:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L572:
        JP    NZ,L576
L573:
        LD    A,64
L574:
        CALL  writeLineA
L575:
        ;;testComparison.j(91)     if (one+four  != 12/(1+2)) println(65);
L576:
        LD    HL,(05002H)
L577:
        LD    DE,(05006H)
        ADD   HL,DE
L578:
        PUSH HL
L579:
        LD    A,12
L580:
        PUSH  AF
        LD    A,1
L581:
        ADD   A,2
L582:
        LD    C,A
        POP   AF
        CALL  div8
L583:
        POP  HL
L584:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L585:
        JP    Z,L589
L586:
        LD    A,65
L587:
        CALL  writeLineA
L588:
        ;;testComparison.j(92)     if (one+one < 12/(1+2)) println(66);
L589:
        LD    HL,(05002H)
L590:
        LD    DE,(05002H)
        ADD   HL,DE
L591:
        PUSH HL
L592:
        LD    A,12
L593:
        PUSH  AF
        LD    A,1
L594:
        ADD   A,2
L595:
        LD    C,A
        POP   AF
        CALL  div8
L596:
        POP  HL
L597:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L598:
        JP    NC,L602
L599:
        LD    A,66
L600:
        CALL  writeLineA
L601:
        ;;testComparison.j(93)     if (one+four > 12/(1+2)) println(67);
L602:
        LD    HL,(05002H)
L603:
        LD    DE,(05006H)
        ADD   HL,DE
L604:
        PUSH HL
L605:
        LD    A,12
L606:
        PUSH  AF
        LD    A,1
L607:
        ADD   A,2
L608:
        LD    C,A
        POP   AF
        CALL  div8
L609:
        POP  HL
L610:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L611:
        JP    C,L615
        JP    Z,L615
L612:
        LD    A,67
L613:
        CALL  writeLineA
L614:
        ;;testComparison.j(94)     if (one+one <= 12/(1+2)) println(68);
L615:
        LD    HL,(05002H)
L616:
        LD    DE,(05002H)
        ADD   HL,DE
L617:
        PUSH HL
L618:
        LD    A,12
L619:
        PUSH  AF
        LD    A,1
L620:
        ADD   A,2
L621:
        LD    C,A
        POP   AF
        CALL  div8
L622:
        POP  HL
L623:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L624:
        JR    Z,$+3
        JP    NC,L628
L625:
        LD    A,68
L626:
        CALL  writeLineA
L627:
        ;;testComparison.j(95)     if (one+three <= 12/(1+2)) println(69);
L628:
        LD    HL,(05002H)
L629:
        LD    DE,(05004H)
        ADD   HL,DE
L630:
        PUSH HL
L631:
        LD    A,12
L632:
        PUSH  AF
        LD    A,1
L633:
        ADD   A,2
L634:
        LD    C,A
        POP   AF
        CALL  div8
L635:
        POP  HL
L636:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L637:
        JR    Z,$+3
        JP    NC,L641
L638:
        LD    A,69
L639:
        CALL  writeLineA
L640:
        ;;testComparison.j(96)     if (one+three >= 12/(1+2)) println(70);
L641:
        LD    HL,(05002H)
L642:
        LD    DE,(05004H)
        ADD   HL,DE
L643:
        PUSH HL
L644:
        LD    A,12
L645:
        PUSH  AF
        LD    A,1
L646:
        ADD   A,2
L647:
        LD    C,A
        POP   AF
        CALL  div8
L648:
        POP  HL
L649:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L650:
        JP    C,L654
L651:
        LD    A,70
L652:
        CALL  writeLineA
L653:
        ;;testComparison.j(97)     if (one+four >= 12/(1+2)) println(71);
L654:
        LD    HL,(05002H)
L655:
        LD    DE,(05006H)
        ADD   HL,DE
L656:
        PUSH HL
L657:
        LD    A,12
L658:
        PUSH  AF
        LD    A,1
L659:
        ADD   A,2
L660:
        LD    C,A
        POP   AF
        CALL  div8
L661:
        POP  HL
L662:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L663:
        JP    C,L667
L664:
        LD    A,71
L665:
        CALL  writeLineA
L666:
        ;;testComparison.j(98)     if (one+three == twelve/(one+2)) println(72);
L667:
        LD    HL,(05002H)
L668:
        LD    DE,(05004H)
        ADD   HL,DE
L669:
        PUSH HL
L670:
        LD    HL,(0500AH)
L671:
        PUSH  HL
        LD    HL,(05002H)
L672:
        LD    DE,2
        ADD   HL,DE
L673:
        POP   DE
        EX    DE,HL
        CALL  div16
L674:
        POP   DE
        OR    A
        SBC   HL,DE
L675:
        JP    NZ,L679
L676:
        LD    A,72
L677:
        CALL  writeLineA
L678:
        ;;testComparison.j(99)     if (one+four  != twelve/(one+2)) println(73);
L679:
        LD    HL,(05002H)
L680:
        LD    DE,(05006H)
        ADD   HL,DE
L681:
        PUSH HL
L682:
        LD    HL,(0500AH)
L683:
        PUSH  HL
        LD    HL,(05002H)
L684:
        LD    DE,2
        ADD   HL,DE
L685:
        POP   DE
        EX    DE,HL
        CALL  div16
L686:
        POP   DE
        OR    A
        SBC   HL,DE
L687:
        JP    Z,L691
L688:
        LD    A,73
L689:
        CALL  writeLineA
L690:
        ;;testComparison.j(100)     if (one+one < twelve/(one+2)) println(74);
L691:
        LD    HL,(05002H)
L692:
        LD    DE,(05002H)
        ADD   HL,DE
L693:
        PUSH HL
L694:
        LD    HL,(0500AH)
L695:
        PUSH  HL
        LD    HL,(05002H)
L696:
        LD    DE,2
        ADD   HL,DE
L697:
        POP   DE
        EX    DE,HL
        CALL  div16
L698:
        POP   DE
        OR    A
        SBC   HL,DE
L699:
        JP    C,L703
        JP    Z,L703
L700:
        LD    A,74
L701:
        CALL  writeLineA
L702:
        ;;testComparison.j(101)     if (one+four > twelve/(one+2)) println(75);
L703:
        LD    HL,(05002H)
L704:
        LD    DE,(05006H)
        ADD   HL,DE
L705:
        PUSH HL
L706:
        LD    HL,(0500AH)
L707:
        PUSH  HL
        LD    HL,(05002H)
L708:
        LD    DE,2
        ADD   HL,DE
L709:
        POP   DE
        EX    DE,HL
        CALL  div16
L710:
        POP   DE
        OR    A
        SBC   HL,DE
L711:
        JP    NC,L715
L712:
        LD    A,75
L713:
        CALL  writeLineA
L714:
        ;;testComparison.j(102)     if (one+one <= twelve/(one+2)) println(76);
L715:
        LD    HL,(05002H)
L716:
        LD    DE,(05002H)
        ADD   HL,DE
L717:
        PUSH HL
L718:
        LD    HL,(0500AH)
L719:
        PUSH  HL
        LD    HL,(05002H)
L720:
        LD    DE,2
        ADD   HL,DE
L721:
        POP   DE
        EX    DE,HL
        CALL  div16
L722:
        POP   DE
        OR    A
        SBC   HL,DE
L723:
        JP    C,L727
L724:
        LD    A,76
L725:
        CALL  writeLineA
L726:
        ;;testComparison.j(103)     if (one+three <= twelve/(one+2)) println(77);
L727:
        LD    HL,(05002H)
L728:
        LD    DE,(05004H)
        ADD   HL,DE
L729:
        PUSH HL
L730:
        LD    HL,(0500AH)
L731:
        PUSH  HL
        LD    HL,(05002H)
L732:
        LD    DE,2
        ADD   HL,DE
L733:
        POP   DE
        EX    DE,HL
        CALL  div16
L734:
        POP   DE
        OR    A
        SBC   HL,DE
L735:
        JP    C,L739
L736:
        LD    A,77
L737:
        CALL  writeLineA
L738:
        ;;testComparison.j(104)     if (one+three >= twelve/(one+2)) println(78);
L739:
        LD    HL,(05002H)
L740:
        LD    DE,(05004H)
        ADD   HL,DE
L741:
        PUSH HL
L742:
        LD    HL,(0500AH)
L743:
        PUSH  HL
        LD    HL,(05002H)
L744:
        LD    DE,2
        ADD   HL,DE
L745:
        POP   DE
        EX    DE,HL
        CALL  div16
L746:
        POP   DE
        OR    A
        SBC   HL,DE
L747:
        JR    Z,$+3
        JP    NC,L751
L748:
        LD    A,78
L749:
        CALL  writeLineA
L750:
        ;;testComparison.j(105)     if (one+four >= twelve/(one+2)) println(79);
L751:
        LD    HL,(05002H)
L752:
        LD    DE,(05006H)
        ADD   HL,DE
L753:
        PUSH HL
L754:
        LD    HL,(0500AH)
L755:
        PUSH  HL
        LD    HL,(05002H)
L756:
        LD    DE,2
        ADD   HL,DE
L757:
        POP   DE
        EX    DE,HL
        CALL  div16
L758:
        POP   DE
        OR    A
        SBC   HL,DE
L759:
        JR    Z,$+3
        JP    NC,L763
L760:
        LD    A,79
L761:
        CALL  writeLineA
L762:
        ;;testComparison.j(106)     if (four == 12/(1+2)) println(80);
L763:
        LD    A,12
L764:
        PUSH  AF
        LD    A,1
L765:
        ADD   A,2
L766:
        LD    C,A
        POP   AF
        CALL  div8
L767:
        LD    HL,(05006H)
L768:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L769:
        JP    NZ,L773
L770:
        LD    A,80
L771:
        CALL  writeLineA
L772:
        ;;testComparison.j(107)     if (three != 12/(1+2)) println(81);
L773:
        LD    A,12
L774:
        PUSH  AF
        LD    A,1
L775:
        ADD   A,2
L776:
        LD    C,A
        POP   AF
        CALL  div8
L777:
        LD    HL,(05004H)
L778:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L779:
        JP    Z,L783
L780:
        LD    A,81
L781:
        CALL  writeLineA
L782:
        ;;testComparison.j(108)     if (three < 12/(1+2)) println(82);
L783:
        LD    A,12
L784:
        PUSH  AF
        LD    A,1
L785:
        ADD   A,2
L786:
        LD    C,A
        POP   AF
        CALL  div8
L787:
        LD    HL,(05004H)
L788:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L789:
        JP    NC,L793
L790:
        LD    A,82
L791:
        CALL  writeLineA
L792:
        ;;testComparison.j(109)     if (twelve > 12/(1+2)) println(83);
L793:
        LD    A,12
L794:
        PUSH  AF
        LD    A,1
L795:
        ADD   A,2
L796:
        LD    C,A
        POP   AF
        CALL  div8
L797:
        LD    HL,(0500AH)
L798:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L799:
        JP    C,L803
        JP    Z,L803
L800:
        LD    A,83
L801:
        CALL  writeLineA
L802:
        ;;testComparison.j(110)     if (four <= 12/(1+2)) println(84);
L803:
        LD    A,12
L804:
        PUSH  AF
        LD    A,1
L805:
        ADD   A,2
L806:
        LD    C,A
        POP   AF
        CALL  div8
L807:
        LD    HL,(05006H)
L808:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L809:
        JR    Z,$+3
        JP    NC,L813
L810:
        LD    A,84
L811:
        CALL  writeLineA
L812:
        ;;testComparison.j(111)     if (three <= 12/(1+2)) println(85);
L813:
        LD    A,12
L814:
        PUSH  AF
        LD    A,1
L815:
        ADD   A,2
L816:
        LD    C,A
        POP   AF
        CALL  div8
L817:
        LD    HL,(05004H)
L818:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L819:
        JR    Z,$+3
        JP    NC,L823
L820:
        LD    A,85
L821:
        CALL  writeLineA
L822:
        ;;testComparison.j(112)     if (four >= 12/(1+2)) println(86);
L823:
        LD    A,12
L824:
        PUSH  AF
        LD    A,1
L825:
        ADD   A,2
L826:
        LD    C,A
        POP   AF
        CALL  div8
L827:
        LD    HL,(05006H)
L828:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L829:
        JP    C,L833
L830:
        LD    A,86
L831:
        CALL  writeLineA
L832:
        ;;testComparison.j(113)     if (twelve >= 12/(1+2)) println(87);
L833:
        LD    A,12
L834:
        PUSH  AF
        LD    A,1
L835:
        ADD   A,2
L836:
        LD    C,A
        POP   AF
        CALL  div8
L837:
        LD    HL,(0500AH)
L838:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L839:
        JP    C,L843
L840:
        LD    A,87
L841:
        CALL  writeLineA
L842:
        ;;testComparison.j(114)     if (four == twelve/(one+2)) println(88);
L843:
        LD    HL,(0500AH)
L844:
        PUSH  HL
        LD    HL,(05002H)
L845:
        LD    DE,2
        ADD   HL,DE
L846:
        POP   DE
        EX    DE,HL
        CALL  div16
L847:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L848:
        JP    NZ,L852
L849:
        LD    A,88
L850:
        CALL  writeLineA
L851:
        ;;testComparison.j(115)     if (three != twelve/(one+2)) println(89);
L852:
        LD    HL,(0500AH)
L853:
        PUSH  HL
        LD    HL,(05002H)
L854:
        LD    DE,2
        ADD   HL,DE
L855:
        POP   DE
        EX    DE,HL
        CALL  div16
L856:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L857:
        JP    Z,L861
L858:
        LD    A,89
L859:
        CALL  writeLineA
L860:
        ;;testComparison.j(116)     if (three < twelve/(one+2)) println(90);
L861:
        LD    HL,(0500AH)
L862:
        PUSH  HL
        LD    HL,(05002H)
L863:
        LD    DE,2
        ADD   HL,DE
L864:
        POP   DE
        EX    DE,HL
        CALL  div16
L865:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L866:
        JP    C,L870
        JP    Z,L870
L867:
        LD    A,90
L868:
        CALL  writeLineA
L869:
        ;;testComparison.j(117)     if (twelve > twelve/(one+2)) println(91);
L870:
        LD    HL,(0500AH)
L871:
        PUSH  HL
        LD    HL,(05002H)
L872:
        LD    DE,2
        ADD   HL,DE
L873:
        POP   DE
        EX    DE,HL
        CALL  div16
L874:
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L875:
        JP    NC,L879
L876:
        LD    A,91
L877:
        CALL  writeLineA
L878:
        ;;testComparison.j(118)     if (four <= twelve/(one+2)) println(92);
L879:
        LD    HL,(0500AH)
L880:
        PUSH  HL
        LD    HL,(05002H)
L881:
        LD    DE,2
        ADD   HL,DE
L882:
        POP   DE
        EX    DE,HL
        CALL  div16
L883:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L884:
        JP    C,L888
L885:
        LD    A,92
L886:
        CALL  writeLineA
L887:
        ;;testComparison.j(119)     if (three <= twelve/(one+2)) println(93);
L888:
        LD    HL,(0500AH)
L889:
        PUSH  HL
        LD    HL,(05002H)
L890:
        LD    DE,2
        ADD   HL,DE
L891:
        POP   DE
        EX    DE,HL
        CALL  div16
L892:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L893:
        JP    C,L897
L894:
        LD    A,93
L895:
        CALL  writeLineA
L896:
        ;;testComparison.j(120)     if (four >= twelve/(one+2)) println(94);
L897:
        LD    HL,(0500AH)
L898:
        PUSH  HL
        LD    HL,(05002H)
L899:
        LD    DE,2
        ADD   HL,DE
L900:
        POP   DE
        EX    DE,HL
        CALL  div16
L901:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L902:
        JR    Z,$+3
        JP    NC,L906
L903:
        LD    A,94
L904:
        CALL  writeLineA
L905:
        ;;testComparison.j(121)     if (twelve >= twelve/(one+2)) println(95);
L906:
        LD    HL,(0500AH)
L907:
        PUSH  HL
        LD    HL,(05002H)
L908:
        LD    DE,2
        ADD   HL,DE
L909:
        POP   DE
        EX    DE,HL
        CALL  div16
L910:
        LD    DE,(0500AH)
        OR    A
        SBC   HL,DE
L911:
        JR    Z,$+3
        JP    NC,L915
L912:
        LD    A,95
L913:
        CALL  writeLineA
L914:
        ;;testComparison.j(122)     if (1+3 == 12/(1+2)) println(96);
L915:
        LD    A,1
L916:
        ADD   A,3
L917:
        PUSH AF
L918:
        LD    A,12
L919:
        PUSH  AF
        LD    A,1
L920:
        ADD   A,2
L921:
        LD    C,A
        POP   AF
        CALL  div8
L922:
        POP   BC
        SUB   A,B
L923:
        JP    NZ,L927
L924:
        LD    A,96
L925:
        CALL  writeLineA
L926:
        ;;testComparison.j(123)     if (1+2 != 12/(1+2)) println(97);
L927:
        LD    A,1
L928:
        ADD   A,2
L929:
        PUSH AF
L930:
        LD    A,12
L931:
        PUSH  AF
        LD    A,1
L932:
        ADD   A,2
L933:
        LD    C,A
        POP   AF
        CALL  div8
L934:
        POP   BC
        SUB   A,B
L935:
        JP    Z,L939
L936:
        LD    A,97
L937:
        CALL  writeLineA
L938:
        ;;testComparison.j(124)     if (1+2 < 12/(1+2)) println(98);
L939:
        LD    A,1
L940:
        ADD   A,2
L941:
        PUSH AF
L942:
        LD    A,12
L943:
        PUSH  AF
        LD    A,1
L944:
        ADD   A,2
L945:
        LD    C,A
        POP   AF
        CALL  div8
L946:
        POP   BC
        SUB   A,B
L947:
        JP    C,L951
        JP    Z,L951
L948:
        LD    A,98
L949:
        CALL  writeLineA
L950:
        ;;testComparison.j(125)     if (1+4 > 12/(1+2)) println(99);
L951:
        LD    A,1
L952:
        ADD   A,4
L953:
        PUSH AF
L954:
        LD    A,12
L955:
        PUSH  AF
        LD    A,1
L956:
        ADD   A,2
L957:
        LD    C,A
        POP   AF
        CALL  div8
L958:
        POP   BC
        SUB   A,B
L959:
        JP    NC,L963
L960:
        LD    A,99
L961:
        CALL  writeLineA
L962:
        ;;testComparison.j(126)     if (1+2 <= 12/(1+2)) println(100);
L963:
        LD    A,1
L964:
        ADD   A,2
L965:
        PUSH AF
L966:
        LD    A,12
L967:
        PUSH  AF
        LD    A,1
L968:
        ADD   A,2
L969:
        LD    C,A
        POP   AF
        CALL  div8
L970:
        POP   BC
        SUB   A,B
L971:
        JP    C,L975
L972:
        LD    A,100
L973:
        CALL  writeLineA
L974:
        ;;testComparison.j(127)     if (1+3 <= 12/(1+2)) println(101);
L975:
        LD    A,1
L976:
        ADD   A,3
L977:
        PUSH AF
L978:
        LD    A,12
L979:
        PUSH  AF
        LD    A,1
L980:
        ADD   A,2
L981:
        LD    C,A
        POP   AF
        CALL  div8
L982:
        POP   BC
        SUB   A,B
L983:
        JP    C,L987
L984:
        LD    A,101
L985:
        CALL  writeLineA
L986:
        ;;testComparison.j(128)     if (1+3 >= 12/(1+2)) println(102);
L987:
        LD    A,1
L988:
        ADD   A,3
L989:
        PUSH AF
L990:
        LD    A,12
L991:
        PUSH  AF
        LD    A,1
L992:
        ADD   A,2
L993:
        LD    C,A
        POP   AF
        CALL  div8
L994:
        POP   BC
        SUB   A,B
L995:
        JR    Z,$+3
        JP    NC,L999
L996:
        LD    A,102
L997:
        CALL  writeLineA
L998:
        ;;testComparison.j(129)     if (1+4 >= 12/(1+2)) println(103);
L999:
        LD    A,1
L1000:
        ADD   A,4
L1001:
        PUSH AF
L1002:
        LD    A,12
L1003:
        PUSH  AF
        LD    A,1
L1004:
        ADD   A,2
L1005:
        LD    C,A
        POP   AF
        CALL  div8
L1006:
        POP   BC
        SUB   A,B
L1007:
        JR    Z,$+3
        JP    NC,L1011
L1008:
        LD    A,103
L1009:
        CALL  writeLineA
L1010:
        ;;testComparison.j(130)     if (1+3 == twelve/(one+2)) println(104);
L1011:
        LD    A,1
L1012:
        ADD   A,3
L1013:
        PUSH AF
L1014:
        LD    HL,(0500AH)
L1015:
        PUSH  HL
        LD    HL,(05002H)
L1016:
        LD    DE,2
        ADD   HL,DE
L1017:
        POP   DE
        EX    DE,HL
        CALL  div16
L1018:
        POP  AF
L1019:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1020:
        JP    NZ,L1024
L1021:
        LD    A,104
L1022:
        CALL  writeLineA
L1023:
        ;;testComparison.j(131)     if (1+2 != twelve/(one+2)) println(105);
L1024:
        LD    A,1
L1025:
        ADD   A,2
L1026:
        PUSH AF
L1027:
        LD    HL,(0500AH)
L1028:
        PUSH  HL
        LD    HL,(05002H)
L1029:
        LD    DE,2
        ADD   HL,DE
L1030:
        POP   DE
        EX    DE,HL
        CALL  div16
L1031:
        POP  AF
L1032:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1033:
        JP    Z,L1037
L1034:
        LD    A,105
L1035:
        CALL  writeLineA
L1036:
        ;;testComparison.j(132)     if (1+2 < twelve/(one+2)) println(106);
L1037:
        LD    A,1
L1038:
        ADD   A,2
L1039:
        PUSH AF
L1040:
        LD    HL,(0500AH)
L1041:
        PUSH  HL
        LD    HL,(05002H)
L1042:
        LD    DE,2
        ADD   HL,DE
L1043:
        POP   DE
        EX    DE,HL
        CALL  div16
L1044:
        POP  AF
L1045:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1046:
        JP    NC,L1050
L1047:
        LD    A,106
L1048:
        CALL  writeLineA
L1049:
        ;;testComparison.j(133)     if (1+4 > twelve/(one+2)) println(107);
L1050:
        LD    A,1
L1051:
        ADD   A,4
L1052:
        PUSH AF
L1053:
        LD    HL,(0500AH)
L1054:
        PUSH  HL
        LD    HL,(05002H)
L1055:
        LD    DE,2
        ADD   HL,DE
L1056:
        POP   DE
        EX    DE,HL
        CALL  div16
L1057:
        POP  AF
L1058:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1059:
        JP    C,L1063
        JP    Z,L1063
L1060:
        LD    A,107
L1061:
        CALL  writeLineA
L1062:
        ;;testComparison.j(134)     if (1+2 <= twelve/(one+2)) println(108);
L1063:
        LD    A,1
L1064:
        ADD   A,2
L1065:
        PUSH AF
L1066:
        LD    HL,(0500AH)
L1067:
        PUSH  HL
        LD    HL,(05002H)
L1068:
        LD    DE,2
        ADD   HL,DE
L1069:
        POP   DE
        EX    DE,HL
        CALL  div16
L1070:
        POP  AF
L1071:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1072:
        JR    Z,$+3
        JP    NC,L1076
L1073:
        LD    A,108
L1074:
        CALL  writeLineA
L1075:
        ;;testComparison.j(135)     if (1+3 <= twelve/(one+2)) println(109);
L1076:
        LD    A,1
L1077:
        ADD   A,3
L1078:
        PUSH AF
L1079:
        LD    HL,(0500AH)
L1080:
        PUSH  HL
        LD    HL,(05002H)
L1081:
        LD    DE,2
        ADD   HL,DE
L1082:
        POP   DE
        EX    DE,HL
        CALL  div16
L1083:
        POP  AF
L1084:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1085:
        JR    Z,$+3
        JP    NC,L1089
L1086:
        LD    A,109
L1087:
        CALL  writeLineA
L1088:
        ;;testComparison.j(136)     if (1+3 >= twelve/(one+2)) println(110);
L1089:
        LD    A,1
L1090:
        ADD   A,3
L1091:
        PUSH AF
L1092:
        LD    HL,(0500AH)
L1093:
        PUSH  HL
        LD    HL,(05002H)
L1094:
        LD    DE,2
        ADD   HL,DE
L1095:
        POP   DE
        EX    DE,HL
        CALL  div16
L1096:
        POP  AF
L1097:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1098:
        JP    C,L1102
L1099:
        LD    A,110
L1100:
        CALL  writeLineA
L1101:
        ;;testComparison.j(137)     if (1+4 >= twelve/(one+2)) println(111);
L1102:
        LD    A,1
L1103:
        ADD   A,4
L1104:
        PUSH AF
L1105:
        LD    HL,(0500AH)
L1106:
        PUSH  HL
        LD    HL,(05002H)
L1107:
        LD    DE,2
        ADD   HL,DE
L1108:
        POP   DE
        EX    DE,HL
        CALL  div16
L1109:
        POP  AF
L1110:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1111:
        JP    C,L1115
L1112:
        LD    A,111
L1113:
        CALL  writeLineA
L1114:
        ;;testComparison.j(138)     if (4 == 12/(1+2)) println(112);
L1115:
        LD    A,12
L1116:
        PUSH  AF
        LD    A,1
L1117:
        ADD   A,2
L1118:
        LD    C,A
        POP   AF
        CALL  div8
L1119:
        SUB   A,4
L1120:
        JP    NZ,L1124
L1121:
        LD    A,112
L1122:
        CALL  writeLineA
L1123:
        ;;testComparison.j(139)     if (3 != 12/(1+2)) println(113);
L1124:
        LD    A,12
L1125:
        PUSH  AF
        LD    A,1
L1126:
        ADD   A,2
L1127:
        LD    C,A
        POP   AF
        CALL  div8
L1128:
        SUB   A,3
L1129:
        JP    Z,L1133
L1130:
        LD    A,113
L1131:
        CALL  writeLineA
L1132:
        ;;testComparison.j(140)     if (3 < 12/(1+2)) println(114);
L1133:
        LD    A,12
L1134:
        PUSH  AF
        LD    A,1
L1135:
        ADD   A,2
L1136:
        LD    C,A
        POP   AF
        CALL  div8
L1137:
        SUB   A,3
L1138:
        JP    C,L1142
        JP    Z,L1142
L1139:
        LD    A,114
L1140:
        CALL  writeLineA
L1141:
        ;;testComparison.j(141)     if (5 > 12/(1+2)) println(115);
L1142:
        LD    A,12
L1143:
        PUSH  AF
        LD    A,1
L1144:
        ADD   A,2
L1145:
        LD    C,A
        POP   AF
        CALL  div8
L1146:
        SUB   A,5
L1147:
        JP    NC,L1151
L1148:
        LD    A,115
L1149:
        CALL  writeLineA
L1150:
        ;;testComparison.j(142)     if (3 <= 12/(1+2)) println(116);
L1151:
        LD    A,12
L1152:
        PUSH  AF
        LD    A,1
L1153:
        ADD   A,2
L1154:
        LD    C,A
        POP   AF
        CALL  div8
L1155:
        SUB   A,3
L1156:
        JP    C,L1160
L1157:
        LD    A,116
L1158:
        CALL  writeLineA
L1159:
        ;;testComparison.j(143)     if (4 <= 12/(1+2)) println(117);
L1160:
        LD    A,12
L1161:
        PUSH  AF
        LD    A,1
L1162:
        ADD   A,2
L1163:
        LD    C,A
        POP   AF
        CALL  div8
L1164:
        SUB   A,4
L1165:
        JP    C,L1169
L1166:
        LD    A,117
L1167:
        CALL  writeLineA
L1168:
        ;;testComparison.j(144)     if (4 >= 12/(1+2)) println(118);
L1169:
        LD    A,12
L1170:
        PUSH  AF
        LD    A,1
L1171:
        ADD   A,2
L1172:
        LD    C,A
        POP   AF
        CALL  div8
L1173:
        SUB   A,4
L1174:
        JR    Z,$+3
        JP    NC,L1178
L1175:
        LD    A,118
L1176:
        CALL  writeLineA
L1177:
        ;;testComparison.j(145)     if (5 >= 12/(1+2)) println(119);
L1178:
        LD    A,12
L1179:
        PUSH  AF
        LD    A,1
L1180:
        ADD   A,2
L1181:
        LD    C,A
        POP   AF
        CALL  div8
L1182:
        SUB   A,5
L1183:
        JR    Z,$+3
        JP    NC,L1187
L1184:
        LD    A,119
L1185:
        CALL  writeLineA
L1186:
        ;;testComparison.j(146)     if (4 == twelve/(one+2)) println(120);
L1187:
        LD    HL,(0500AH)
L1188:
        PUSH  HL
        LD    HL,(05002H)
L1189:
        LD    DE,2
        ADD   HL,DE
L1190:
        POP   DE
        EX    DE,HL
        CALL  div16
L1191:
        LD    A,4
L1192:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1193:
        JP    NZ,L1197
L1194:
        LD    A,120
L1195:
        CALL  writeLineA
L1196:
        ;;testComparison.j(147)     if (3 != twelve/(one+2)) println(121);
L1197:
        LD    HL,(0500AH)
L1198:
        PUSH  HL
        LD    HL,(05002H)
L1199:
        LD    DE,2
        ADD   HL,DE
L1200:
        POP   DE
        EX    DE,HL
        CALL  div16
L1201:
        LD    A,3
L1202:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1203:
        JP    Z,L1207
L1204:
        LD    A,121
L1205:
        CALL  writeLineA
L1206:
        ;;testComparison.j(148)     if (2 < twelve/(one+2)) println(122);
L1207:
        LD    HL,(0500AH)
L1208:
        PUSH  HL
        LD    HL,(05002H)
L1209:
        LD    DE,2
        ADD   HL,DE
L1210:
        POP   DE
        EX    DE,HL
        CALL  div16
L1211:
        LD    A,2
L1212:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1213:
        JP    NC,L1217
L1214:
        LD    A,122
L1215:
        CALL  writeLineA
L1216:
        ;;testComparison.j(149)     if (5 > twelve/(one+2)) println(123);
L1217:
        LD    HL,(0500AH)
L1218:
        PUSH  HL
        LD    HL,(05002H)
L1219:
        LD    DE,2
        ADD   HL,DE
L1220:
        POP   DE
        EX    DE,HL
        CALL  div16
L1221:
        LD    A,5
L1222:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1223:
        JP    C,L1227
        JP    Z,L1227
L1224:
        LD    A,123
L1225:
        CALL  writeLineA
L1226:
        ;;testComparison.j(150)     if (3 <= twelve/(one+2)) println(124);
L1227:
        LD    HL,(0500AH)
L1228:
        PUSH  HL
        LD    HL,(05002H)
L1229:
        LD    DE,2
        ADD   HL,DE
L1230:
        POP   DE
        EX    DE,HL
        CALL  div16
L1231:
        LD    A,3
L1232:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1233:
        JR    Z,$+3
        JP    NC,L1237
L1234:
        LD    A,124
L1235:
        CALL  writeLineA
L1236:
        ;;testComparison.j(151)     if (4 <= twelve/(one+2)) println(125);
L1237:
        LD    HL,(0500AH)
L1238:
        PUSH  HL
        LD    HL,(05002H)
L1239:
        LD    DE,2
        ADD   HL,DE
L1240:
        POP   DE
        EX    DE,HL
        CALL  div16
L1241:
        LD    A,4
L1242:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1243:
        JR    Z,$+3
        JP    NC,L1247
L1244:
        LD    A,125
L1245:
        CALL  writeLineA
L1246:
        ;;testComparison.j(152)     if (4 >= twelve/(one+2)) println(126);
L1247:
        LD    HL,(0500AH)
L1248:
        PUSH  HL
        LD    HL,(05002H)
L1249:
        LD    DE,2
        ADD   HL,DE
L1250:
        POP   DE
        EX    DE,HL
        CALL  div16
L1251:
        LD    A,4
L1252:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1253:
        JP    C,L1257
L1254:
        LD    A,126
L1255:
        CALL  writeLineA
L1256:
        ;;testComparison.j(153)     if (5 >= twelve/(one+2)) println(127);
L1257:
        LD    HL,(0500AH)
L1258:
        PUSH  HL
        LD    HL,(05002H)
L1259:
        LD    DE,2
        ADD   HL,DE
L1260:
        POP   DE
        EX    DE,HL
        CALL  div16
L1261:
        LD    A,5
L1262:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1263:
        JP    C,L1267
L1264:
        LD    A,127
L1265:
        CALL  writeLineA
L1266:
        ;;testComparison.j(154)     if (four == 0 + 12/(1 + 2)) println(128);
L1267:
        LD    A,0
L1268:
        PUSH  AF
        LD    A,12
L1269:
        PUSH  AF
        LD    A,1
L1270:
        ADD   A,2
L1271:
        LD    C,A
        POP   AF
        CALL  div8
L1272:
        POP   BC
        ADD   A,B
L1273:
        LD    HL,(05006H)
L1274:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1275:
        JP    NZ,L1279
L1276:
        LD    A,128
L1277:
        CALL  writeLineA
L1278:
        ;;testComparison.j(155)     if (four == 0 + 12/(1 + 2)) println(129);
L1279:
        LD    A,0
L1280:
        PUSH  AF
        LD    A,12
L1281:
        PUSH  AF
        LD    A,1
L1282:
        ADD   A,2
L1283:
        LD    C,A
        POP   AF
        CALL  div8
L1284:
        POP   BC
        ADD   A,B
L1285:
        LD    HL,(05006H)
L1286:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1287:
        JP    NZ,L1291
L1288:
        LD    A,129
L1289:
        CALL  writeLineA
L1290:
        ;;testComparison.j(156)     if (four == 0 + 12/(byteOne + 2)) println(130);
L1291:
        LD    A,0
L1292:
        PUSH  AF
        LD    A,12
L1293:
        PUSH  AF
        LD    A,(0500CH)
L1294:
        ADD   A,2
L1295:
        LD    C,A
        POP   AF
        CALL  div8
L1296:
        POP   BC
        ADD   A,B
L1297:
        LD    HL,(05006H)
L1298:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L1299:
        JP    NZ,L1303
L1300:
        LD    A,130
L1301:
        CALL  writeLineA
L1302:
        ;;testComparison.j(157)     if (four == 0 + 12/(one + 2)) println(131);
L1303:
        LD    A,0
L1304:
        PUSH  AF
        LD    A,12
L1305:
        LD    HL,(05002H)
L1306:
        LD    DE,2
        ADD   HL,DE
L1307:
        EX    DE,HL
        CALL  div8_16
L1308:
        POP   DE
        LD    D,0
        ADD   HL,DE
L1309:
        LD    DE,(05006H)
        OR    A
        SBC   HL,DE
L1310:
        JP    NZ,L1314
L1311:
        LD    A,131
L1312:
        CALL  writeLineA
L1313:
        ;;testComparison.j(158)     if (4 == zero + twelve/(1+2)) println(132);
L1314:
        LD    HL,(05000H)
L1315:
        PUSH  HL
        LD    HL,(0500AH)
L1316:
        LD    A,1
L1317:
        ADD   A,2
L1318:
        CALL  div16_8
L1319:
        POP   DE
        ADD   HL,DE
L1320:
        LD    A,4
L1321:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L1322:
        JP    NZ,L1329
L1323:
        LD    A,132
L1324:
        CALL  writeLineA
L1325:
        ;;testComparison.j(159)   
L1326:
        ;;testComparison.j(160)     /************************/
L1327:
        ;;testComparison.j(161)     // global variable b used within if scope
L1328:
        ;;testComparison.j(162)     b = 133;
L1329:
        LD    A,133
L1330:
        LD    (0500EH),A
L1331:
        ;;testComparison.j(163)     if (b>132) {
L1332:
        LD    A,(0500EH)
L1333:
        SUB   A,132
L1334:
        JP    C,L1351
        JP    Z,L1351
L1335:
        ;;testComparison.j(164)       word j = 1001;
L1336:
        LD    HL,1001
L1337:
        LD    (IX - 2),L
        LD    (IX - 1),H
L1338:
        ;;testComparison.j(165)       byte c = b;
L1339:
        LD    A,(0500EH)
L1340:
        LD    (IX - 3),A
L1341:
        ;;testComparison.j(166)       byte d = c;
L1342:
        LD    A,(IX - 3)
L1343:
        LD    (IX - 4),A
L1344:
        ;;testComparison.j(167)       b--;
L1345:
        LD    HL,(0500EH)
        DEC   (HL)
L1346:
        ;;testComparison.j(168)       println (c);
L1347:
        LD    A,(IX - 3)
L1348:
        CALL  writeLineA
L1349:
        ;;testComparison.j(169)     } else {
L1350:
        JP    L1358
L1351:
        ;;testComparison.j(170)       println(999);
L1352:
        LD    HL,999
L1353:
        CALL  writeLineHL
L1354:
        ;;testComparison.j(171)     }
L1355:
        ;;testComparison.j(172)   
L1356:
        ;;testComparison.j(173)     /************************/
L1357:
        ;;testComparison.j(174)     println (134);
L1358:
        LD    A,134
L1359:
        CALL  writeLineA
L1360:
        ;;testComparison.j(175)     println("Klaar");
L1361:
        LD    HL,L1368
L1362:
        CALL  writeLineStr
L1363:
        ;;testComparison.j(176)   }
L1364:
        LD    SP,IX
L1365:
        POP   IX
L1366:
        return
L1367:
        ;;testComparison.j(177) }
L1368:
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
