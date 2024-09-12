SOC     equ 02000H        ;start of code, i.e.lowest external RAM address.
TOS     equ 0FD00H        ;top of stack, i.e. bottom of MONITOR user global data.
        .ORG  SOC
start:
        LD    SP,TOS
L0:
        CALL  L16
L1:
        JP    00171H      ;Jump to Zilog Z80183 Monitor.
L2:
        ;;testExpression.j(0) /*
L3:
        ;;testExpression.j(1)  * A small program in the miniJava language.
L4:
        ;;testExpression.j(2)  * Test 8-bit and 16-bit expressions.
L5:
        ;;testExpression.j(3)  */
L6:
        ;;testExpression.j(4) class TestExpression {
L7:
        ;class TestExpression []
L8:
        ;;testExpression.j(5)   private static byte b;
L9:
        ;;testExpression.j(6)   private static byte c;
L10:
        ;;testExpression.j(7)   private static word i;
L11:
        ;;testExpression.j(8)   private static word j;
L12:
        ;;testExpression.j(9)   private static byte byteHex;
L13:
        ;;testExpression.j(10)   private static word wordHex;
L14:
        ;;testExpression.j(11) 
L15:
        ;;testExpression.j(12)   public static void main() {
L16:
        ;method TestExpression.main [public, static] void ()
L17:
        PUSH  IX
L18:
        LD    IX,0x0000
        ADD   IX,SP
L19:
L20:
        ;;testExpression.j(13)     println(0);         // 0
L21:
        LD    A,0
L22:
        CALL  writeLineA
L23:
        ;;testExpression.j(14)     //LD    A,0
L24:
        ;;testExpression.j(15)     //CALL  writeA
L25:
        ;;testExpression.j(16)     //OK
L26:
        ;;testExpression.j(17)   
L27:
        ;;testExpression.j(18)     /*********************/
L28:
        ;;testExpression.j(19)     /* Single term 8-bit */
L29:
        ;;testExpression.j(20)     /*********************/
L30:
        ;;testExpression.j(21)     b = 1;
L31:
        LD    A,1
L32:
        LD    (05000H),A
L33:
        ;;testExpression.j(22)     c = 4;
L34:
        LD    A,4
L35:
        LD    (05001H),A
L36:
        ;;testExpression.j(23)     println(b);         // 1
L37:
        LD    A,(05000H)
L38:
        CALL  writeLineA
L39:
        ;;testExpression.j(24)     //LD    A,1
L40:
        ;;testExpression.j(25)     //LD    (04000H),A
L41:
        ;;testExpression.j(26)     //LD    A,(04000H)
L42:
        ;;testExpression.j(27)     //CALL  writeA
L43:
        ;;testExpression.j(28)     //OK
L44:
        ;;testExpression.j(29)   
L45:
        ;;testExpression.j(30)     /************************/
L46:
        ;;testExpression.j(31)     /* Dual term addition   */
L47:
        ;;testExpression.j(32)     /************************/
L48:
        ;;testExpression.j(33)     println(0 + 2);     // 2
L49:
        LD    A,0
L50:
        ADD   A,2
L51:
        CALL  writeLineA
L52:
        ;;testExpression.j(34)     println(b + 2);     // 3
L53:
        LD    A,(05000H)
L54:
        ADD   A,2
L55:
        CALL  writeLineA
L56:
        ;;testExpression.j(35)     println(3 + b);     // 4
L57:
        LD    A,3
L58:
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L59:
        CALL  writeLineA
L60:
        ;;testExpression.j(36)     println(b + c);     // 5
L61:
        LD    A,(05000H)
L62:
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L63:
        CALL  writeLineA
L64:
        ;;testExpression.j(37)   
L65:
        ;;testExpression.j(38)     c = 4 + 2;
L66:
        LD    A,4
L67:
        ADD   A,2
L68:
        LD    (05001H),A
L69:
        ;;testExpression.j(39)     println(c);         // 6
L70:
        LD    A,(05001H)
L71:
        CALL  writeLineA
L72:
        ;;testExpression.j(40)     c = b + 6;
L73:
        LD    A,(05000H)
L74:
        ADD   A,6
L75:
        LD    (05001H),A
L76:
        ;;testExpression.j(41)     println(c);         // 7
L77:
        LD    A,(05001H)
L78:
        CALL  writeLineA
L79:
        ;;testExpression.j(42)     c = 7 + b;
L80:
        LD    A,7
L81:
        LD    B,A
        LD    A,(05000H)
        ADD   A,B
L82:
        LD    (05001H),A
L83:
        ;;testExpression.j(43)     println(c);         // 8
L84:
        LD    A,(05001H)
L85:
        CALL  writeLineA
L86:
        ;;testExpression.j(44)     c = b + c;
L87:
        LD    A,(05000H)
L88:
        LD    B,A
        LD    A,(05001H)
        ADD   A,B
L89:
        LD    (05001H),A
L90:
        ;;testExpression.j(45)     println(c);         // 9
L91:
        LD    A,(05001H)
L92:
        CALL  writeLineA
L93:
        ;;testExpression.j(46)   
L94:
        ;;testExpression.j(47)   
L95:
        ;;testExpression.j(48)     i = 10;
L96:
        LD    A,10
L97:
        LD    (05002H),A
L98:
        ;;testExpression.j(49)     println(i);         // 10
L99:
        LD    HL,(05002H)
L100:
        CALL  writeLineHL
L101:
        ;;testExpression.j(50)     //LD    A,10
L102:
        ;;testExpression.j(51)     //LD    L,A
L103:
        ;;testExpression.j(52)     //LD    H,0
L104:
        ;;testExpression.j(53)     //LD    (04004H),HL
L105:
        ;;testExpression.j(54)     //OK
L106:
        ;;testExpression.j(55)     
L107:
        ;;testExpression.j(56)     println(i + 1);     // 11
L108:
        LD    HL,(05002H)
L109:
        LD    DE,1
        ADD   HL,DE
L110:
        CALL  writeLineHL
L111:
        ;;testExpression.j(57)     println(2 + i);     // 12
L112:
        LD    A,2
L113:
        LD    L,A
        LD    H,0
L114:
        LD    DE,(05002H)
        ADD   HL,DE
L115:
        CALL  writeLineHL
L116:
        ;;testExpression.j(58)     b = 3;
L117:
        LD    A,3
L118:
        LD    (05000H),A
L119:
        ;;testExpression.j(59)     println(i + b);     // 13
L120:
        LD    HL,(05002H)
L121:
        LD    DE,(05000H)
        ADD   HL,DE
L122:
        CALL  writeLineHL
L123:
        ;;testExpression.j(60)     b++; //4
L124:
        LD    HL,(05000H)
        INC   (HL)
L125:
        ;;testExpression.j(61)     println(b + i);     // 14
L126:
        LD    A,(05000H)
L127:
        LD    L,A
        LD    H,0
L128:
        LD    DE,(05002H)
        ADD   HL,DE
L129:
        CALL  writeLineHL
L130:
        ;;testExpression.j(62)   
L131:
        ;;testExpression.j(63)     j = i + 5;    // 15
L132:
        LD    HL,(05002H)
L133:
        LD    DE,5
        ADD   HL,DE
L134:
        LD    (05004H),HL
L135:
        ;;testExpression.j(64)     println(j);
L136:
        LD    HL,(05004H)
L137:
        CALL  writeLineHL
L138:
        ;;testExpression.j(65)     j = 6 + i;        // 16
L139:
        LD    A,6
L140:
        LD    L,A
        LD    H,0
L141:
        LD    DE,(05002H)
        ADD   HL,DE
L142:
        LD    (05004H),HL
L143:
        ;;testExpression.j(66)     println(j);
L144:
        LD    HL,(05004H)
L145:
        CALL  writeLineHL
L146:
        ;;testExpression.j(67)     j = 7;
L147:
        LD    A,7
L148:
        LD    (05004H),A
L149:
        ;;testExpression.j(68)     j = i + j;        // 17
L150:
        LD    HL,(05002H)
L151:
        LD    DE,(05004H)
        ADD   HL,DE
L152:
        LD    (05004H),HL
L153:
        ;;testExpression.j(69)     println(j);
L154:
        LD    HL,(05004H)
L155:
        CALL  writeLineHL
L156:
        ;;testExpression.j(70)   
L157:
        ;;testExpression.j(71)     /*************************/
L158:
        ;;testExpression.j(72)     /* Dual term subtraction */
L159:
        ;;testExpression.j(73)     /*************************/
L160:
        ;;testExpression.j(74)     b = 33;
L161:
        LD    A,33
L162:
        LD    (05000H),A
L163:
        ;;testExpression.j(75)     c = 12;
L164:
        LD    A,12
L165:
        LD    (05001H),A
L166:
        ;;testExpression.j(76)     println(19 - 1);    // 18
L167:
        LD    A,19
L168:
        SUB   A,1
L169:
        CALL  writeLineA
L170:
        ;;testExpression.j(77)     println(b - 14);    // 19
L171:
        LD    A,(05000H)
L172:
        SUB   A,14
L173:
        CALL  writeLineA
L174:
        ;;testExpression.j(78)     println(53 - b);    // 20
L175:
        LD    A,53
L176:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L177:
        CALL  writeLineA
L178:
        ;;testExpression.j(79)     println(b - c);     // 21
L179:
        LD    A,(05000H)
L180:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L181:
        CALL  writeLineA
L182:
        ;;testExpression.j(80)   
L183:
        ;;testExpression.j(81)     c = 24 - 2;
L184:
        LD    A,24
L185:
        SUB   A,2
L186:
        LD    (05001H),A
L187:
        ;;testExpression.j(82)     println(c);         // 22
L188:
        LD    A,(05001H)
L189:
        CALL  writeLineA
L190:
        ;;testExpression.j(83)     c = b - 10;
L191:
        LD    A,(05000H)
L192:
        SUB   A,10
L193:
        LD    (05001H),A
L194:
        ;;testExpression.j(84)     println(c);         // 23
L195:
        LD    A,(05001H)
L196:
        CALL  writeLineA
L197:
        ;;testExpression.j(85)     c = 57 - b;
L198:
        LD    A,57
L199:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L200:
        LD    (05001H),A
L201:
        ;;testExpression.j(86)     println(c);         // 24
L202:
        LD    A,(05001H)
L203:
        CALL  writeLineA
L204:
        ;;testExpression.j(87)     c = 8;
L205:
        LD    A,8
L206:
        LD    (05001H),A
L207:
        ;;testExpression.j(88)     c = b - c;
L208:
        LD    A,(05000H)
L209:
        LD    B,A
        LD    A,(05001H)
        SUB   A,B
L210:
        LD    (05001H),A
L211:
        ;;testExpression.j(89)     println(c);         // 25
L212:
        LD    A,(05001H)
L213:
        CALL  writeLineA
L214:
        ;;testExpression.j(90)   
L215:
        ;;testExpression.j(91)     i = 40;
L216:
        LD    A,40
L217:
        LD    (05002H),A
L218:
        ;;testExpression.j(92)     println(i - 14);    // 26
L219:
        LD    HL,(05002H)
L220:
        LD    DE,14
        OR    A
        SBC   HL,DE
L221:
        CALL  writeLineHL
L222:
        ;;testExpression.j(93)     println(67 - i);    // 27
L223:
        LD    A,67
L224:
        LD    L,A
        LD    H,0
L225:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L226:
        CALL  writeLineHL
L227:
        ;;testExpression.j(94)     b = 12;
L228:
        LD    A,12
L229:
        LD    (05000H),A
L230:
        ;;testExpression.j(95)     println(i - b);     // 28
L231:
        LD    HL,(05002H)
L232:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L233:
        CALL  writeLineHL
L234:
        ;;testExpression.j(96)     b = 69;
L235:
        LD    A,69
L236:
        LD    (05000H),A
L237:
        ;;testExpression.j(97)     println(b - i);     // 29
L238:
        LD    A,(05000H)
L239:
        LD    L,A
        LD    H,0
L240:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L241:
        CALL  writeLineHL
L242:
        ;;testExpression.j(98)   
L243:
        ;;testExpression.j(99)     j = i - 10;
L244:
        LD    HL,(05002H)
L245:
        LD    DE,10
        OR    A
        SBC   HL,DE
L246:
        LD    (05004H),HL
L247:
        ;;testExpression.j(100)     println(j);         // 30
L248:
        LD    HL,(05004H)
L249:
        CALL  writeLineHL
L250:
        ;;testExpression.j(101)     j = 71 - i;
L251:
        LD    A,71
L252:
        LD    L,A
        LD    H,0
L253:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L254:
        LD    (05004H),HL
L255:
        ;;testExpression.j(102)     println(j);         // 31
L256:
        LD    HL,(05004H)
L257:
        CALL  writeLineHL
L258:
        ;;testExpression.j(103)     j = 8;
L259:
        LD    A,8
L260:
        LD    (05004H),A
L261:
        ;;testExpression.j(104)     j = i - j;
L262:
        LD    HL,(05002H)
L263:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L264:
        LD    (05004H),HL
L265:
        ;;testExpression.j(105)     println(j);         // 32
L266:
        LD    HL,(05004H)
L267:
        CALL  writeLineHL
L268:
        ;;testExpression.j(106)     
L269:
        ;;testExpression.j(107)     /****************************/
L270:
        ;;testExpression.j(108)     /* Dual term multiplication */
L271:
        ;;testExpression.j(109)     /****************************/
L272:
        ;;testExpression.j(110)     println(3 * 11);    // 33
L273:
        LD    A,3
L274:
        LD    B,A
        LD    C,11
        MLT   BC
        LD    A,C
L275:
        CALL  writeLineA
L276:
        ;;testExpression.j(111)     b = 17;
L277:
        LD    A,17
L278:
        LD    (05000H),A
L279:
        ;;testExpression.j(112)     println(b * 2);     // 34
L280:
        LD    A,(05000H)
L281:
        LD    B,A
        LD    C,2
        MLT   BC
        LD    A,C
L282:
        CALL  writeLineA
L283:
        ;;testExpression.j(113)     b = 7;
L284:
        LD    A,7
L285:
        LD    (05000H),A
L286:
        ;;testExpression.j(114)     println(5 * b);     // 35
L287:
        LD    A,5
L288:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L289:
        CALL  writeLineA
L290:
        ;;testExpression.j(115)     b = 2;
L291:
        LD    A,2
L292:
        LD    (05000H),A
L293:
        ;;testExpression.j(116)     c = 18;
L294:
        LD    A,18
L295:
        LD    (05001H),A
L296:
        ;;testExpression.j(117)     println(b * c);     // 36
L297:
        LD    A,(05000H)
L298:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L299:
        CALL  writeLineA
L300:
        ;;testExpression.j(118)     
L301:
        ;;testExpression.j(119)     c = 37 * 1;
L302:
        LD    A,37
L303:
        LD    B,A
        LD    C,1
        MLT   BC
        LD    A,C
L304:
        LD    (05001H),A
L305:
        ;;testExpression.j(120)     println(c);         // 37
L306:
        LD    A,(05001H)
L307:
        CALL  writeLineA
L308:
        ;;testExpression.j(121)     b = 2;
L309:
        LD    A,2
L310:
        LD    (05000H),A
L311:
        ;;testExpression.j(122)     c = b * 19;
L312:
        LD    A,(05000H)
L313:
        LD    B,A
        LD    C,19
        MLT   BC
        LD    A,C
L314:
        LD    (05001H),A
L315:
        ;;testExpression.j(123)     println(c);         // 38
L316:
        LD    A,(05001H)
L317:
        CALL  writeLineA
L318:
        ;;testExpression.j(124)     b = 3;
L319:
        LD    A,3
L320:
        LD    (05000H),A
L321:
        ;;testExpression.j(125)     c = 13 * b;
L322:
        LD    A,13
L323:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        MLT   BC
        LD    A,C
L324:
        LD    (05001H),A
L325:
        ;;testExpression.j(126)     println(c);         // 39
L326:
        LD    A,(05001H)
L327:
        CALL  writeLineA
L328:
        ;;testExpression.j(127)     b = 5;
L329:
        LD    A,5
L330:
        LD    (05000H),A
L331:
        ;;testExpression.j(128)     c = 8;
L332:
        LD    A,8
L333:
        LD    (05001H),A
L334:
        ;;testExpression.j(129)     c = b * c;
L335:
        LD    A,(05000H)
L336:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        MLT   BC
        LD    A,C
L337:
        LD    (05001H),A
L338:
        ;;testExpression.j(130)     println(c);         // 40
L339:
        LD    A,(05001H)
L340:
        CALL  writeLineA
L341:
        ;;testExpression.j(131)   
L342:
        ;;testExpression.j(132)     /**********************/
L343:
        ;;testExpression.j(133)     /* Dual term division */
L344:
        ;;testExpression.j(134)     /**********************/
L345:
        ;;testExpression.j(135)     println(123 / 3);   // 41
L346:
        LD    A,123
L347:
        LD    C,3
        CALL  div8
L348:
        CALL  writeLineA
L349:
        ;;testExpression.j(136)     b = 126;
L350:
        LD    A,126
L351:
        LD    (05000H),A
L352:
        ;;testExpression.j(137)     println(b / 3);     // 42
L353:
        LD    A,(05000H)
L354:
        LD    C,3
        CALL  div8
L355:
        CALL  writeLineA
L356:
        ;;testExpression.j(138)     b = 3;
L357:
        LD    A,3
L358:
        LD    (05000H),A
L359:
        ;;testExpression.j(139)     println(129 / b);   // 43
L360:
        LD    A,129
L361:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        LD    A,B
        CALL  div8
L362:
        CALL  writeLineA
L363:
        ;;testExpression.j(140)     b = 132;
L364:
        LD    A,132
L365:
        LD    (05000H),A
L366:
        ;;testExpression.j(141)     c = 3;
L367:
        LD    A,3
L368:
        LD    (05001H),A
L369:
        ;;testExpression.j(142)     println(b / c);     // 44
L370:
        LD    A,(05000H)
L371:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        LD    A,B
        CALL  div8
L372:
        CALL  writeLineA
L373:
        ;;testExpression.j(143)     
L374:
        ;;testExpression.j(144)     c = 135 / 3;
L375:
        LD    A,135
L376:
        LD    C,3
        CALL  div8
L377:
        LD    (05001H),A
L378:
        ;;testExpression.j(145)     println(c);         // 45
L379:
        LD    A,(05001H)
L380:
        CALL  writeLineA
L381:
        ;;testExpression.j(146)     b = 138;
L382:
        LD    A,138
L383:
        LD    (05000H),A
L384:
        ;;testExpression.j(147)     c = b / 3;
L385:
        LD    A,(05000H)
L386:
        LD    C,3
        CALL  div8
L387:
        LD    (05001H),A
L388:
        ;;testExpression.j(148)     println(c);         // 46
L389:
        LD    A,(05001H)
L390:
        CALL  writeLineA
L391:
        ;;testExpression.j(149)     b = 3;
L392:
        LD    A,3
L393:
        LD    (05000H),A
L394:
        ;;testExpression.j(150)     c = 141 / b;
L395:
        LD    A,141
L396:
        LD    B,A
        LD    A,(05000H)
        LD    C,A
        LD    A,B
        CALL  div8
L397:
        LD    (05001H),A
L398:
        ;;testExpression.j(151)     println(c);         // 47
L399:
        LD    A,(05001H)
L400:
        CALL  writeLineA
L401:
        ;;testExpression.j(152)     b = 144;
L402:
        LD    A,144
L403:
        LD    (05000H),A
L404:
        ;;testExpression.j(153)     c = 3;
L405:
        LD    A,3
L406:
        LD    (05001H),A
L407:
        ;;testExpression.j(154)     c = b / c;
L408:
        LD    A,(05000H)
L409:
        LD    B,A
        LD    A,(05001H)
        LD    C,A
        LD    A,B
        CALL  div8
L410:
        LD    (05001H),A
L411:
        ;;testExpression.j(155)     println(c);         // 48
L412:
        LD    A,(05001H)
L413:
        CALL  writeLineA
L414:
        ;;testExpression.j(156)   
L415:
        ;;testExpression.j(157)     /*************************/
L416:
        ;;testExpression.j(158)     /* possible loss of data */
L417:
        ;;testExpression.j(159)     /*************************/
L418:
        ;;testExpression.j(160)     println("Nu komen 251 en 252");
L419:
        LD    HL,L909
L420:
        CALL  writeLineStr
L421:
        ;;testExpression.j(161)     b = 507;
L422:
        LD    HL,507
L423:
        LD    (05000H),HL
L424:
        ;;testExpression.j(162)     println(b);         // 251
L425:
        LD    A,(05000H)
L426:
        CALL  writeLineA
L427:
        ;;testExpression.j(163)     i = 508;
L428:
        LD    HL,508
L429:
        LD    (05002H),HL
L430:
        ;;testExpression.j(164)     b = i;
L431:
        LD    HL,(05002H)
L432:
        LD    (05000H),HL
L433:
        ;;testExpression.j(165)     println(b);         // 252
L434:
        LD    A,(05000H)
L435:
        CALL  writeLineA
L436:
        ;;testExpression.j(166)   
L437:
        ;;testExpression.j(167)     println("Nu komen -253 en -254");
L438:
        LD    HL,L910
L439:
        CALL  writeLineStr
L440:
        ;;testExpression.j(168)     b = b - 505;
L441:
        LD    A,(05000H)
L442:
        LD    L,A
        LD    H,0
L443:
        LD    DE,505
        OR    A
        SBC   HL,DE
L444:
        LD    (05000H),HL
L445:
        ;;testExpression.j(169)     println(b);         // 252 - 505 = -253
L446:
        LD    A,(05000H)
L447:
        CALL  writeLineA
L448:
        ;;testExpression.j(170)     i = i + 5;
L449:
        LD    HL,(05002H)
L450:
        LD    DE,5
        ADD   HL,DE
L451:
        LD    (05002H),HL
L452:
        ;;testExpression.j(171)     b = b - i;
L453:
        LD    A,(05000H)
L454:
        LD    L,A
        LD    H,0
L455:
        LD    DE,(05002H)
        OR    A
        SBC   HL,DE
L456:
        LD    (05000H),HL
L457:
        ;;testExpression.j(172)     println(b);         // -233 - 11 = -254
L458:
        LD    A,(05000H)
L459:
        CALL  writeLineA
L460:
        ;;testExpression.j(173)     
L461:
        ;;testExpression.j(174)     println("Nu komen 255 en 256");
L462:
        LD    HL,L911
L463:
        CALL  writeLineStr
L464:
        ;;testExpression.j(175)     b = 255;
L465:
        LD    A,255
L466:
        LD    (05000H),A
L467:
        ;;testExpression.j(176)     println(b);         // 255
L468:
        LD    A,(05000H)
L469:
        CALL  writeLineA
L470:
        ;;testExpression.j(177)     //LD    A,255
L471:
        ;;testExpression.j(178)     //LD    (04001H),A
L472:
        ;;testExpression.j(179)     //LD    A,(04001H)
L473:
        ;;testExpression.j(180)     //CALL  writeA
L474:
        ;;testExpression.j(181)     //OK
L475:
        ;;testExpression.j(182)   
L476:
        ;;testExpression.j(183)     /**********************/
L477:
        ;;testExpression.j(184)     /* Single term 16-bit */
L478:
        ;;testExpression.j(185)     /**********************/
L479:
        ;;testExpression.j(186)     i = 256;
L480:
        LD    HL,256
L481:
        LD    (05002H),HL
L482:
        ;;testExpression.j(187)     println(i);         // 256
L483:
        LD    HL,(05002H)
L484:
        CALL  writeLineHL
L485:
        ;;testExpression.j(188)     //LD    HL,256
L486:
        ;;testExpression.j(189)     //LD    (04006H),HL
L487:
        ;;testExpression.j(190)     //LD    HL,(04006H)
L488:
        ;;testExpression.j(191)     //CALL  writeHL
L489:
        ;;testExpression.j(192)     //OK
L490:
        ;;testExpression.j(193)   
L491:
        ;;testExpression.j(194)     println("Nu komen 1000..1047");
L492:
        LD    HL,L912
L493:
        CALL  writeLineStr
L494:
        ;;testExpression.j(195)     println(1000);      // 1000
L495:
        LD    HL,1000
L496:
        CALL  writeLineHL
L497:
        ;;testExpression.j(196)     j = 1001;
L498:
        LD    HL,1001
L499:
        LD    (05004H),HL
L500:
        ;;testExpression.j(197)     println(j);         // 1001
L501:
        LD    HL,(05004H)
L502:
        CALL  writeLineHL
L503:
        ;;testExpression.j(198)   
L504:
        ;;testExpression.j(199)     /************************/
L505:
        ;;testExpression.j(200)     /* Dual term addition   */
L506:
        ;;testExpression.j(201)     /************************/
L507:
        ;;testExpression.j(202)     println(1000 + 2);  // 1002
L508:
        LD    HL,1000
L509:
        LD    DE,2
        ADD   HL,DE
L510:
        CALL  writeLineHL
L511:
        ;;testExpression.j(203)     println(3 + 1000);  // 1003
L512:
        LD    A,3
L513:
        LD    L,A
        LD    H,0
L514:
        LD    DE,1000
        ADD   HL,DE
L515:
        CALL  writeLineHL
L516:
        ;;testExpression.j(204)     println(500 + 504); // 1004
L517:
        LD    HL,500
L518:
        LD    DE,504
        ADD   HL,DE
L519:
        CALL  writeLineHL
L520:
        ;;testExpression.j(205)     i = 1000 + 5;
L521:
        LD    HL,1000
L522:
        LD    DE,5
        ADD   HL,DE
L523:
        LD    (05002H),HL
L524:
        ;;testExpression.j(206)     println(i);         // 1005
L525:
        LD    HL,(05002H)
L526:
        CALL  writeLineHL
L527:
        ;;testExpression.j(207)     i = 6 + 1000;
L528:
        LD    A,6
L529:
        LD    L,A
        LD    H,0
L530:
        LD    DE,1000
        ADD   HL,DE
L531:
        LD    (05002H),HL
L532:
        ;;testExpression.j(208)     println(i);         // 1006
L533:
        LD    HL,(05002H)
L534:
        CALL  writeLineHL
L535:
        ;;testExpression.j(209)     i = 500 + 507;
L536:
        LD    HL,500
L537:
        LD    DE,507
        ADD   HL,DE
L538:
        LD    (05002H),HL
L539:
        ;;testExpression.j(210)     println(i);         // 1007
L540:
        LD    HL,(05002H)
L541:
        CALL  writeLineHL
L542:
        ;;testExpression.j(211)     
L543:
        ;;testExpression.j(212)     j = 1000;
L544:
        LD    HL,1000
L545:
        LD    (05004H),HL
L546:
        ;;testExpression.j(213)     b = 10;
L547:
        LD    A,10
L548:
        LD    (05000H),A
L549:
        ;;testExpression.j(214)     i = 514;
L550:
        LD    HL,514
L551:
        LD    (05002H),HL
L552:
        ;;testExpression.j(215)     println(j + 8);     // 1008
L553:
        LD    HL,(05004H)
L554:
        LD    DE,8
        ADD   HL,DE
L555:
        CALL  writeLineHL
L556:
        ;;testExpression.j(216)     println(9 + j);     // 1009
L557:
        LD    A,9
L558:
        LD    L,A
        LD    H,0
L559:
        LD    DE,(05004H)
        ADD   HL,DE
L560:
        CALL  writeLineHL
L561:
        ;;testExpression.j(217)     println(j + b);     // 1010
L562:
        LD    HL,(05004H)
L563:
        LD    DE,(05000H)
        ADD   HL,DE
L564:
        CALL  writeLineHL
L565:
        ;;testExpression.j(218)     b++;
L566:
        LD    HL,(05000H)
        INC   (HL)
L567:
        ;;testExpression.j(219)     println(b + j);     // 1011
L568:
        LD    A,(05000H)
L569:
        LD    L,A
        LD    H,0
L570:
        LD    DE,(05004H)
        ADD   HL,DE
L571:
        CALL  writeLineHL
L572:
        ;;testExpression.j(220)     j = 500;
L573:
        LD    HL,500
L574:
        LD    (05004H),HL
L575:
        ;;testExpression.j(221)     println(j + 512);   // 1012
L576:
        LD    HL,(05004H)
L577:
        LD    DE,512
        ADD   HL,DE
L578:
        CALL  writeLineHL
L579:
        ;;testExpression.j(222)     println(513 + j);   // 1013
L580:
        LD    HL,513
L581:
        LD    DE,(05004H)
        ADD   HL,DE
L582:
        CALL  writeLineHL
L583:
        ;;testExpression.j(223)     println(i + j);     // 1014
L584:
        LD    HL,(05002H)
L585:
        LD    DE,(05004H)
        ADD   HL,DE
L586:
        CALL  writeLineHL
L587:
        ;;testExpression.j(224)     
L588:
        ;;testExpression.j(225)     j = 1000;
L589:
        LD    HL,1000
L590:
        LD    (05004H),HL
L591:
        ;;testExpression.j(226)     b = 17;
L592:
        LD    A,17
L593:
        LD    (05000H),A
L594:
        ;;testExpression.j(227)     i = j + 15;
L595:
        LD    HL,(05004H)
L596:
        LD    DE,15
        ADD   HL,DE
L597:
        LD    (05002H),HL
L598:
        ;;testExpression.j(228)     println(i);         // 1015
L599:
        LD    HL,(05002H)
L600:
        CALL  writeLineHL
L601:
        ;;testExpression.j(229)     i = 16 + j;
L602:
        LD    A,16
L603:
        LD    L,A
        LD    H,0
L604:
        LD    DE,(05004H)
        ADD   HL,DE
L605:
        LD    (05002H),HL
L606:
        ;;testExpression.j(230)     println(i);         // 1016
L607:
        LD    HL,(05002H)
L608:
        CALL  writeLineHL
L609:
        ;;testExpression.j(231)     i = j + b;
L610:
        LD    HL,(05004H)
L611:
        LD    DE,(05000H)
        ADD   HL,DE
L612:
        LD    (05002H),HL
L613:
        ;;testExpression.j(232)     println(i);         // 1017
L614:
        LD    HL,(05002H)
L615:
        CALL  writeLineHL
L616:
        ;;testExpression.j(233)     b++;
L617:
        LD    HL,(05000H)
        INC   (HL)
L618:
        ;;testExpression.j(234)     i = b + j;
L619:
        LD    A,(05000H)
L620:
        LD    L,A
        LD    H,0
L621:
        LD    DE,(05004H)
        ADD   HL,DE
L622:
        LD    (05002H),HL
L623:
        ;;testExpression.j(235)     println(i);         // 1018
L624:
        LD    HL,(05002H)
L625:
        CALL  writeLineHL
L626:
        ;;testExpression.j(236)     j = 500;
L627:
        LD    HL,500
L628:
        LD    (05004H),HL
L629:
        ;;testExpression.j(237)     i = j + 519;
L630:
        LD    HL,(05004H)
L631:
        LD    DE,519
        ADD   HL,DE
L632:
        LD    (05002H),HL
L633:
        ;;testExpression.j(238)     println(i);         // 1019
L634:
        LD    HL,(05002H)
L635:
        CALL  writeLineHL
L636:
        ;;testExpression.j(239)     i = 520 + j;
L637:
        LD    HL,520
L638:
        LD    DE,(05004H)
        ADD   HL,DE
L639:
        LD    (05002H),HL
L640:
        ;;testExpression.j(240)     println(i);         // 1020
L641:
        LD    HL,(05002H)
L642:
        CALL  writeLineHL
L643:
        ;;testExpression.j(241)     i = 521;
L644:
        LD    HL,521
L645:
        LD    (05002H),HL
L646:
        ;;testExpression.j(242)     i = i + j;
L647:
        LD    HL,(05002H)
L648:
        LD    DE,(05004H)
        ADD   HL,DE
L649:
        LD    (05002H),HL
L650:
        ;;testExpression.j(243)     println(i);         // 1021
L651:
        LD    HL,(05002H)
L652:
        CALL  writeLineHL
L653:
        ;;testExpression.j(244)     
L654:
        ;;testExpression.j(245)     /*************************/
L655:
        ;;testExpression.j(246)     /* Dual term subtraction */
L656:
        ;;testExpression.j(247)     /*************************/
L657:
        ;;testExpression.j(248)     println(1024 - 2);  // 1022
L658:
        LD    HL,1024
L659:
        LD    DE,2
        OR    A
        SBC   HL,DE
L660:
        CALL  writeLineHL
L661:
        ;;testExpression.j(249)     println(1523 - 500);// 1023
L662:
        LD    HL,1523
L663:
        LD    DE,500
        OR    A
        SBC   HL,DE
L664:
        CALL  writeLineHL
L665:
        ;;testExpression.j(250)     i = 1030 - 6;
L666:
        LD    HL,1030
L667:
        LD    DE,6
        OR    A
        SBC   HL,DE
L668:
        LD    (05002H),HL
L669:
        ;;testExpression.j(251)     println(i);         // 1024
L670:
        LD    HL,(05002H)
L671:
        CALL  writeLineHL
L672:
        ;;testExpression.j(252)     i = 1525 - 500;
L673:
        LD    HL,1525
L674:
        LD    DE,500
        OR    A
        SBC   HL,DE
L675:
        LD    (05002H),HL
L676:
        ;;testExpression.j(253)     println(i);         // 1025
L677:
        LD    HL,(05002H)
L678:
        CALL  writeLineHL
L679:
        ;;testExpression.j(254)     
L680:
        ;;testExpression.j(255)     j = 1040;
L681:
        LD    HL,1040
L682:
        LD    (05004H),HL
L683:
        ;;testExpression.j(256)     b = 13;
L684:
        LD    A,13
L685:
        LD    (05000H),A
L686:
        ;;testExpression.j(257)     i = 3030;
L687:
        LD    HL,3030
L688:
        LD    (05002H),HL
L689:
        ;;testExpression.j(258)     println(j - 14);    // 1026
L690:
        LD    HL,(05004H)
L691:
        LD    DE,14
        OR    A
        SBC   HL,DE
L692:
        CALL  writeLineHL
L693:
        ;;testExpression.j(259)     println(j - b);     // 1027
L694:
        LD    HL,(05004H)
L695:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L696:
        CALL  writeLineHL
L697:
        ;;testExpression.j(260)     j = 2000;
L698:
        LD    HL,2000
L699:
        LD    (05004H),HL
L700:
        ;;testExpression.j(261)     println(j - 972);   // 1028
L701:
        LD    HL,(05004H)
L702:
        LD    DE,972
        OR    A
        SBC   HL,DE
L703:
        CALL  writeLineHL
L704:
        ;;testExpression.j(262)     println(3029 - j);  // 1029
L705:
        LD    HL,3029
L706:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L707:
        CALL  writeLineHL
L708:
        ;;testExpression.j(263)     println(i - j);     // 1030
L709:
        LD    HL,(05002H)
L710:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L711:
        CALL  writeLineHL
L712:
        ;;testExpression.j(264)     
L713:
        ;;testExpression.j(265)     j = 1050;
L714:
        LD    HL,1050
L715:
        LD    (05004H),HL
L716:
        ;;testExpression.j(266)     b = 18;
L717:
        LD    A,18
L718:
        LD    (05000H),A
L719:
        ;;testExpression.j(267)     i = j - 19;
L720:
        LD    HL,(05004H)
L721:
        LD    DE,19
        OR    A
        SBC   HL,DE
L722:
        LD    (05002H),HL
L723:
        ;;testExpression.j(268)     println(i);         // 1031
L724:
        LD    HL,(05002H)
L725:
        CALL  writeLineHL
L726:
        ;;testExpression.j(269)     i = j - b;
L727:
        LD    HL,(05004H)
L728:
        LD    DE,(05000H)
        OR    A
        SBC   HL,DE
L729:
        LD    (05002H),HL
L730:
        ;;testExpression.j(270)     println(i);         // 1032
L731:
        LD    HL,(05002H)
L732:
        CALL  writeLineHL
L733:
        ;;testExpression.j(271)     j = 2000;
L734:
        LD    HL,2000
L735:
        LD    (05004H),HL
L736:
        ;;testExpression.j(272)     i = j - 967;
L737:
        LD    HL,(05004H)
L738:
        LD    DE,967
        OR    A
        SBC   HL,DE
L739:
        LD    (05002H),HL
L740:
        ;;testExpression.j(273)     println(i);         // 1033
L741:
        LD    HL,(05002H)
L742:
        CALL  writeLineHL
L743:
        ;;testExpression.j(274)     i = 3034 - j;
L744:
        LD    HL,3034
L745:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L746:
        LD    (05002H),HL
L747:
        ;;testExpression.j(275)     println(i);         // 1034
L748:
        LD    HL,(05002H)
L749:
        CALL  writeLineHL
L750:
        ;;testExpression.j(276)     i = 3035;
L751:
        LD    HL,3035
L752:
        LD    (05002H),HL
L753:
        ;;testExpression.j(277)     i = i - j;
L754:
        LD    HL,(05002H)
L755:
        LD    DE,(05004H)
        OR    A
        SBC   HL,DE
L756:
        LD    (05002H),HL
L757:
        ;;testExpression.j(278)     println(i);         // 1035
L758:
        LD    HL,(05002H)
L759:
        CALL  writeLineHL
L760:
        ;;testExpression.j(279)     
L761:
        ;;testExpression.j(280)     /****************************/
L762:
        ;;testExpression.j(281)     /* Dual term multiplication */
L763:
        ;;testExpression.j(282)     /****************************/
L764:
        ;;testExpression.j(283)     println(518 * 2);   // 1036
L765:
        LD    HL,518
L766:
        LD    DE,2
        CALL  mul16
L767:
        CALL  writeLineHL
L768:
        ;;testExpression.j(284)     println(1 * 1037);  // 1037
L769:
        LD    A,1
L770:
        LD    L,A
        LD    H,0
L771:
        LD    DE,1037
        CALL  mul16
L772:
        CALL  writeLineHL
L773:
        ;;testExpression.j(285)     println(500 * 504 - 54354); // 1038 = 55392 - 54354
L774:
        LD    HL,500
L775:
        LD    DE,504
        CALL  mul16
L776:
        LD    DE,54354
        OR    A
        SBC   HL,DE
L777:
        CALL  writeLineHL
L778:
        ;;testExpression.j(286)   
L779:
        ;;testExpression.j(287)     i = 1039 * 1;
L780:
        LD    HL,1039
L781:
        LD    DE,1
        CALL  mul16
L782:
        LD    (05002H),HL
L783:
        ;;testExpression.j(288)     println(i);         // 1039
L784:
        LD    HL,(05002H)
L785:
        CALL  writeLineHL
L786:
        ;;testExpression.j(289)     i = 2 * 520;
L787:
        LD    A,2
L788:
        LD    L,A
        LD    H,0
L789:
        LD    DE,520
        CALL  mul16
L790:
        LD    (05002H),HL
L791:
        ;;testExpression.j(290)     println(i);         // 1040
L792:
        LD    HL,(05002H)
L793:
        CALL  writeLineHL
L794:
        ;;testExpression.j(291)   
L795:
        ;;testExpression.j(292)     i = 1041;
L796:
        LD    HL,1041
L797:
        LD    (05002H),HL
L798:
        ;;testExpression.j(293)     println(i * 1);     // 1041
L799:
        LD    HL,(05002H)
L800:
        LD    DE,1
        CALL  mul16
L801:
        CALL  writeLineHL
L802:
        ;;testExpression.j(294)     i = 521;
L803:
        LD    HL,521
L804:
        LD    (05002H),HL
L805:
        ;;testExpression.j(295)     println(2 * i);     // 1042
L806:
        LD    A,2
L807:
        LD    L,A
        LD    H,0
L808:
        LD    DE,(05002H)
        CALL  mul16
L809:
        CALL  writeLineHL
L810:
        ;;testExpression.j(296)   
L811:
        ;;testExpression.j(297)     i = 1043;
L812:
        LD    HL,1043
L813:
        LD    (05002H),HL
L814:
        ;;testExpression.j(298)     i = i * 1;
L815:
        LD    HL,(05002H)
L816:
        LD    DE,1
        CALL  mul16
L817:
        LD    (05002H),HL
L818:
        ;;testExpression.j(299)     println(i);         // 1043
L819:
        LD    HL,(05002H)
L820:
        CALL  writeLineHL
L821:
        ;;testExpression.j(300)     i = 522;
L822:
        LD    HL,522
L823:
        LD    (05002H),HL
L824:
        ;;testExpression.j(301)     i = 2 * i;
L825:
        LD    A,2
L826:
        LD    L,A
        LD    H,0
L827:
        LD    DE,(05002H)
        CALL  mul16
L828:
        LD    (05002H),HL
L829:
        ;;testExpression.j(302)     println(i);         // 1044
L830:
        LD    HL,(05002H)
L831:
        CALL  writeLineHL
L832:
        ;;testExpression.j(303)   
L833:
        ;;testExpression.j(304)     i = 500 * 504 - 54347; // 1045 = 55392 - 54347
L834:
        LD    HL,500
L835:
        LD    DE,504
        CALL  mul16
L836:
        LD    DE,54347
        OR    A
        SBC   HL,DE
L837:
        LD    (05002H),HL
L838:
        ;;testExpression.j(305)     println(i);         // 1045
L839:
        LD    HL,(05002H)
L840:
        CALL  writeLineHL
L841:
        ;;testExpression.j(306)     i = 500;
L842:
        LD    HL,500
L843:
        LD    (05002H),HL
L844:
        ;;testExpression.j(307)     i = i * 504 - 54346;
L845:
        LD    HL,(05002H)
L846:
        LD    DE,504
        CALL  mul16
L847:
        LD    DE,54346
        OR    A
        SBC   HL,DE
L848:
        LD    (05002H),HL
L849:
        ;;testExpression.j(308)     println(i);         // 1046
L850:
        LD    HL,(05002H)
L851:
        CALL  writeLineHL
L852:
        ;;testExpression.j(309)     i = 504;
L853:
        LD    HL,504
L854:
        LD    (05002H),HL
L855:
        ;;testExpression.j(310)     i = 500 * i - 54345;
L856:
        LD    HL,500
L857:
        LD    DE,(05002H)
        CALL  mul16
L858:
        LD    DE,54345
        OR    A
        SBC   HL,DE
L859:
        LD    (05002H),HL
L860:
        ;;testExpression.j(311)     println(i);         // 1047
L861:
        LD    HL,(05002H)
L862:
        CALL  writeLineHL
L863:
        ;;testExpression.j(312)     
L864:
        ;;testExpression.j(313)     /************/
L865:
        ;;testExpression.j(314)     /* Overflow */
L866:
        ;;testExpression.j(315)     /************/
L867:
        ;;testExpression.j(316)     println("Nu komen 24.764 en 25.064");
L868:
        LD    HL,L913
L869:
        CALL  writeLineStr
L870:
        ;;testExpression.j(317)     println(300 * 301); // 90.300 % 65536 = 24.764
L871:
        LD    HL,300
L872:
        LD    DE,301
        CALL  mul16
L873:
        CALL  writeLineHL
L874:
        ;;testExpression.j(318)     i = 300 * 302;
L875:
        LD    HL,300
L876:
        LD    DE,302
        CALL  mul16
L877:
        LD    (05002H),HL
L878:
        ;;testExpression.j(319)     println(i);         // 90.600 % 65536 = 25.064
L879:
        LD    HL,(05002H)
L880:
        CALL  writeLineHL
L881:
        ;;testExpression.j(320)   
L882:
        ;;testExpression.j(321)     /***************************/
L883:
        ;;testExpression.j(322)     /* hex noatation constants */
L884:
        ;;testExpression.j(323)     /***************************/
L885:
        ;;testExpression.j(324)     println("hex notation constants");
L886:
        LD    HL,L914
L887:
        CALL  writeLineStr
L888:
        ;;testExpression.j(325)     byteHex = 0x41;
L889:
        LD    A,65
L890:
        LD    (05006H),A
L891:
        ;;testExpression.j(326)     println(byteHex);
L892:
        LD    A,(05006H)
L893:
        CALL  writeLineA
L894:
        ;;testExpression.j(327)     wordHex = 0x042A;
L895:
        LD    HL,1066
L896:
        LD    (05007H),HL
L897:
        ;;testExpression.j(328)     println(wordHex);
L898:
        LD    HL,(05007H)
L899:
        CALL  writeLineHL
L900:
        ;;testExpression.j(329)   
L901:
        ;;testExpression.j(330)     println("Klaar");
L902:
        LD    HL,L915
L903:
        CALL  writeLineStr
L904:
        ;;testExpression.j(331)   }
L905:
        LD    SP,IX
L906:
        POP   IX
L907:
        return
L908:
        ;;testExpression.j(332) }
L909:
        .ASCIZ  "Nu komen 251 en 252"
L910:
        .ASCIZ  "Nu komen -253 en -254"
L911:
        .ASCIZ  "Nu komen 255 en 256"
L912:
        .ASCIZ  "Nu komen 1000..1047"
L913:
        .ASCIZ  "Nu komen 24.764 en 25.064"
L914:
        .ASCIZ  "hex notation constants"
L915:
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
