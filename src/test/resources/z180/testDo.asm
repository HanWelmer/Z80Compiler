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
        ;;testDo.j(0) /* Program to test generated Z80 assembler code */
L3:
        ;;testDo.j(1) class TestDo {
L4:
        ;class TestDo []
L5:
        ;;testDo.j(2)   private static byte b = 1;
L6:
        LD    A,1
L7:
        LD    (05000H),A
L8:
        ;;testDo.j(3)   private static word i = 12;
L9:
        LD    A,12
L10:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L11:
        ;;testDo.j(4)   private static word p = 12;
L12:
        LD    A,12
L13:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L14:
        JP    L17
L15:
        ;;testDo.j(5) 
L16:
        ;;testDo.j(6)   public static void main() {
L17:
        ;method TestDo.main [public, static] void ()
L18:
        PUSH  IX
L19:
        LD    IX,0x0000
        ADD   IX,SP
L20:
        DEC   SP
        DEC   SP
        DEC   SP
        DEC   SP
L21:
        ;;testDo.j(7)     println(0);
L22:
        LD    A,0
L23:
        CALL  writeLineA
L24:
        ;;testDo.j(8)   
L25:
        ;;testDo.j(9)     /************************/
L26:
        ;;testDo.j(10)     // global variable within do scope
L27:
        ;;testDo.j(11)     println (b);
L28:
        LD    A,(05000H)
L29:
        CALL  writeLineA
L30:
        ;;testDo.j(12)     b++;
L31:
        LD    HL,05000H
        INC   (HL)
L32:
        ;;testDo.j(13)     do {
L33:
        ;;testDo.j(14)       word j = 1001;
L34:
        LD    HL,1001
L35:
        LD    (IX - 2),L
        LD    (IX - 1),H
L36:
        ;;testDo.j(15)       byte c = b;
L37:
        LD    A,(05000H)
L38:
        LD    (IX - 3),A
L39:
        ;;testDo.j(16)       byte d = c;
L40:
        LD    A,(IX - 3)
L41:
        LD    (IX - 4),A
L42:
        ;;testDo.j(17)       b++;
L43:
        LD    HL,05000H
        INC   (HL)
L44:
        ;;testDo.j(18)       println (c);
L45:
        LD    A,(IX - 3)
L46:
        CALL  writeLineA
L47:
        ;;testDo.j(19)     } while (b<2);
L48:
        LD    A,(05000H)
L49:
        SUB   A,2
L50:
        JP    C,L33
L51:
        ;;testDo.j(20)   
L52:
        ;;testDo.j(21)     /************************/
L53:
        ;;testDo.j(22)     // constant - constant
L54:
        ;;testDo.j(23)     // not relevant
L55:
        ;;testDo.j(24)   
L56:
        ;;testDo.j(25)     /************************/
L57:
        ;;testDo.j(26)     // constant - acc
L58:
        ;;testDo.j(27)     // byte - byte
L59:
        ;;testDo.j(28)     do { println (b); b++; } while (103 == b+100);
L60:
        LD    A,(05000H)
L61:
        CALL  writeLineA
L62:
        LD    HL,05000H
        INC   (HL)
L63:
        LD    A,(05000H)
L64:
        ADD   A,100
L65:
        SUB   A,103
L66:
        JP    Z,L60
L67:
        ;;testDo.j(29)     do { println (b); b++; } while (106 != b+100);
L68:
        LD    A,(05000H)
L69:
        CALL  writeLineA
L70:
        LD    HL,05000H
        INC   (HL)
L71:
        LD    A,(05000H)
L72:
        ADD   A,100
L73:
        SUB   A,106
L74:
        JP    NZ,L68
L75:
        ;;testDo.j(30)     do { println (b); b++; } while (108 >  b+100);
L76:
        LD    A,(05000H)
L77:
        CALL  writeLineA
L78:
        LD    HL,05000H
        INC   (HL)
L79:
        LD    A,(05000H)
L80:
        ADD   A,100
L81:
        SUB   A,108
L82:
        JP    C,L76
L83:
        ;;testDo.j(31)     do { println (b); b++; } while (109 >= b+100);
L84:
        LD    A,(05000H)
L85:
        CALL  writeLineA
L86:
        LD    HL,05000H
        INC   (HL)
L87:
        LD    A,(05000H)
L88:
        ADD   A,100
L89:
        SUB   A,109
L90:
        JP    C,L84
        JP    Z,L84
L91:
        ;;testDo.j(32)     p=10;
L92:
        LD    A,10
L93:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L94:
        ;;testDo.j(33)     do { println (p); p++; b--; } while (108 <  b+100);
L95:
        LD    HL,(05003H)
L96:
        CALL  writeLineHL
L97:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L98:
        LD    HL,05000H
        DEC   (HL)
L99:
        LD    A,(05000H)
L100:
        ADD   A,100
L101:
        SUB   A,108
L102:
        JR    Z,$+3
        JP    NC,L95
L103:
        ;;testDo.j(34)     do { println (p); p++; b--; } while (107 <= b+100);
L104:
        LD    HL,(05003H)
L105:
        CALL  writeLineHL
L106:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L107:
        LD    HL,05000H
        DEC   (HL)
L108:
        LD    A,(05000H)
L109:
        ADD   A,100
L110:
        SUB   A,107
L111:
        JP    C,L104
        JP    Z,L104
L112:
        ;;testDo.j(35)   
L113:
        ;;testDo.j(36)     // constant - acc
L114:
        ;;testDo.j(37)     // byte - integer
L115:
        ;;testDo.j(38)     i=14;
L116:
        LD    A,14
L117:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L118:
        ;;testDo.j(39)     do { println (i); i++; } while (15 == i+0);
L119:
        LD    HL,(05001H)
L120:
        CALL  writeLineHL
L121:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L122:
        LD    HL,(05001H)
L123:
        LD    DE,0
        ADD   HL,DE
L124:
        LD    A,15
L125:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L126:
        JP    Z,L119
L127:
        ;;testDo.j(40)     do { println (i); i++; } while (18 != i+0);
L128:
        LD    HL,(05001H)
L129:
        CALL  writeLineHL
L130:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L131:
        LD    HL,(05001H)
L132:
        LD    DE,0
        ADD   HL,DE
L133:
        LD    A,18
L134:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L135:
        JP    NZ,L128
L136:
        ;;testDo.j(41)     do { println (i); i++; } while (20 >  i+0);
L137:
        LD    HL,(05001H)
L138:
        CALL  writeLineHL
L139:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L140:
        LD    HL,(05001H)
L141:
        LD    DE,0
        ADD   HL,DE
L142:
        LD    A,20
L143:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L144:
        JR    Z,$+3
        JP    NC,L137
L145:
        ;;testDo.j(42)     do { println (i); i++; } while (21 >= i+0);
L146:
        LD    HL,(05001H)
L147:
        CALL  writeLineHL
L148:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L149:
        LD    HL,(05001H)
L150:
        LD    DE,0
        ADD   HL,DE
L151:
        LD    A,21
L152:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L153:
        JP    C,L146
        JP    Z,L146
L154:
        ;;testDo.j(43)     p=22;
L155:
        LD    A,22
L156:
        LD    L,A
        LD    H,0
        LD    (05003H),HL
L157:
        ;;testDo.j(44)     do { println (p); p++; i--; } while (20 <  i+0);
L158:
        LD    HL,(05003H)
L159:
        CALL  writeLineHL
L160:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L161:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L162:
        LD    HL,(05001H)
L163:
        LD    DE,0
        ADD   HL,DE
L164:
        LD    A,20
L165:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L166:
        JP    C,L158
L167:
        ;;testDo.j(45)     do { println (p); p++; i--; } while (19 <= i+0);
L168:
        LD    HL,(05003H)
L169:
        CALL  writeLineHL
L170:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L171:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L172:
        LD    HL,(05001H)
L173:
        LD    DE,0
        ADD   HL,DE
L174:
        LD    A,19
L175:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L176:
        JP    C,L168
        JP    Z,L168
L177:
        ;;testDo.j(46)   
L178:
        ;;testDo.j(47)     // constant - acc
L179:
        ;;testDo.j(48)     // integer - byte
L180:
        ;;testDo.j(49)     // not relevant
L181:
        ;;testDo.j(50)   
L182:
        ;;testDo.j(51)     // constant - acc
L183:
        ;;testDo.j(52)     // integer - integer
L184:
        ;;testDo.j(53)     i=p;
L185:
        LD    HL,(05003H)
L186:
        LD    (05001H),HL
L187:
        ;;testDo.j(54)     do { println (i); i++; } while (1027 == i+1000);
L188:
        LD    HL,(05001H)
L189:
        CALL  writeLineHL
L190:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L191:
        LD    HL,(05001H)
L192:
        LD    DE,1000
        ADD   HL,DE
L193:
        LD    DE,1027
        OR    A
        SBC   HL,DE
L194:
        JP    Z,L188
L195:
        ;;testDo.j(55)     do { println (i); i++; } while (1029 != i+1000);
L196:
        LD    HL,(05001H)
L197:
        CALL  writeLineHL
L198:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L199:
        LD    HL,(05001H)
L200:
        LD    DE,1000
        ADD   HL,DE
L201:
        LD    DE,1029
        OR    A
        SBC   HL,DE
L202:
        JP    NZ,L196
L203:
        ;;testDo.j(56)     do { println (i); i++; } while (1031 >  i+1000);
L204:
        LD    HL,(05001H)
L205:
        CALL  writeLineHL
L206:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L207:
        LD    HL,(05001H)
L208:
        LD    DE,1000
        ADD   HL,DE
L209:
        LD    DE,1031
        OR    A
        SBC   HL,DE
L210:
        JP    C,L204
L211:
        ;;testDo.j(57)     do { println (i); i++; } while (1032 >= i+1000);
L212:
        LD    HL,(05001H)
L213:
        CALL  writeLineHL
L214:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L215:
        LD    HL,(05001H)
L216:
        LD    DE,1000
        ADD   HL,DE
L217:
        LD    DE,1032
        OR    A
        SBC   HL,DE
L218:
        JP    C,L212
        JP    Z,L212
L219:
        ;;testDo.j(58)     p=i;
L220:
        LD    HL,(05001H)
L221:
        LD    (05003H),HL
L222:
        ;;testDo.j(59)     do { println (p); p++; i--; } while (1031 <  i+1000);
L223:
        LD    HL,(05003H)
L224:
        CALL  writeLineHL
L225:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L226:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L227:
        LD    HL,(05001H)
L228:
        LD    DE,1000
        ADD   HL,DE
L229:
        LD    DE,1031
        OR    A
        SBC   HL,DE
L230:
        JR    Z,$+3
        JP    NC,L223
L231:
        ;;testDo.j(60)     do { println (p); p++; i--; } while (1030 <= i+1000);
L232:
        LD    HL,(05003H)
L233:
        CALL  writeLineHL
L234:
        LD    HL,(05003H)
        INC   HL
        LD    (05003H),HL
L235:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L236:
        LD    HL,(05001H)
L237:
        LD    DE,1000
        ADD   HL,DE
L238:
        LD    DE,1030
        OR    A
        SBC   HL,DE
L239:
        JP    C,L232
        JP    Z,L232
L240:
        ;;testDo.j(61)   
L241:
        ;;testDo.j(62)     /************************/
L242:
        ;;testDo.j(63)     // constant - var
L243:
        ;;testDo.j(64)     // byte - byte
L244:
        ;;testDo.j(65)     b=37;
L245:
        LD    A,37
L246:
        LD    (05000H),A
L247:
        ;;testDo.j(66)     do { println (b); b++; } while (38 >= b);
L248:
        LD    A,(05000H)
L249:
        CALL  writeLineA
L250:
        LD    HL,05000H
        INC   (HL)
L251:
        LD    A,(05000H)
L252:
        SUB   A,38
L253:
        JP    C,L248
        JP    Z,L248
L254:
        ;;testDo.j(67)     // byte - integer
L255:
        ;;testDo.j(68)     i=39;
L256:
        LD    A,39
L257:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L258:
        ;;testDo.j(69)     do { println (i); i++; } while (40 >= i);
L259:
        LD    HL,(05001H)
L260:
        CALL  writeLineHL
L261:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L262:
        LD    HL,(05001H)
L263:
        LD    A,40
L264:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L265:
        JP    C,L259
        JP    Z,L259
L266:
        ;;testDo.j(70)     // integer - byte
L267:
        ;;testDo.j(71)     // not relevant
L268:
        ;;testDo.j(72)     // integer - integer
L269:
        ;;testDo.j(73)     i=1038;
L270:
        LD    HL,1038
L271:
        LD    (05001H),HL
L272:
        ;;testDo.j(74)     b=41;
L273:
        LD    A,41
L274:
        LD    (05000H),A
L275:
        ;;testDo.j(75)     do { println (b); b++; i--; } while (1037 <= i);
L276:
        LD    A,(05000H)
L277:
        CALL  writeLineA
L278:
        LD    HL,05000H
        INC   (HL)
L279:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L280:
        LD    HL,(05001H)
L281:
        LD    DE,1037
        OR    A
        SBC   HL,DE
L282:
        JP    C,L276
        JP    Z,L276
L283:
        ;;testDo.j(76)   
L284:
        ;;testDo.j(77)     /************************/
L285:
        ;;testDo.j(78)     // constant - stack8
L286:
        ;;testDo.j(79)     // byte - byte
L287:
        ;;testDo.j(80)     //TODO
L288:
        ;;testDo.j(81)     println(43);
L289:
        LD    A,43
L290:
        CALL  writeLineA
L291:
        ;;testDo.j(82)     // constant - stack8
L292:
        ;;testDo.j(83)     // byte - integer
L293:
        ;;testDo.j(84)     //TODO
L294:
        ;;testDo.j(85)     println(44);
L295:
        LD    A,44
L296:
        CALL  writeLineA
L297:
        ;;testDo.j(86)     // constant - stack8
L298:
        ;;testDo.j(87)     // integer - byte
L299:
        ;;testDo.j(88)     //TODO
L300:
        ;;testDo.j(89)     println(45);
L301:
        LD    A,45
L302:
        CALL  writeLineA
L303:
        ;;testDo.j(90)     // constant - stack88
L304:
        ;;testDo.j(91)     // integer - integer
L305:
        ;;testDo.j(92)     //TODO
L306:
        ;;testDo.j(93)     println(46);
L307:
        LD    A,46
L308:
        CALL  writeLineA
L309:
        ;;testDo.j(94)   
L310:
        ;;testDo.j(95)     /************************/
L311:
        ;;testDo.j(96)     // constant - stack16
L312:
        ;;testDo.j(97)     // byte - byte
L313:
        ;;testDo.j(98)     //TODO
L314:
        ;;testDo.j(99)     println(47);
L315:
        LD    A,47
L316:
        CALL  writeLineA
L317:
        ;;testDo.j(100)     // constant - stack16
L318:
        ;;testDo.j(101)     // byte - integer
L319:
        ;;testDo.j(102)     //TODO
L320:
        ;;testDo.j(103)     println(48);
L321:
        LD    A,48
L322:
        CALL  writeLineA
L323:
        ;;testDo.j(104)     // constant - stack16
L324:
        ;;testDo.j(105)     // integer - byte
L325:
        ;;testDo.j(106)     //TODO
L326:
        ;;testDo.j(107)     println(49);
L327:
        LD    A,49
L328:
        CALL  writeLineA
L329:
        ;;testDo.j(108)     // constant - stack16
L330:
        ;;testDo.j(109)     // integer - integer
L331:
        ;;testDo.j(110)     //TODO
L332:
        ;;testDo.j(111)     println(50);
L333:
        LD    A,50
L334:
        CALL  writeLineA
L335:
        ;;testDo.j(112)   
L336:
        ;;testDo.j(113)     /************************/
L337:
        ;;testDo.j(114)     // acc - constant
L338:
        ;;testDo.j(115)     // byte - byte
L339:
        ;;testDo.j(116)     b=51;
L340:
        LD    A,51
L341:
        LD    (05000H),A
L342:
        ;;testDo.j(117)     do { println (b); b++; } while (b+0 <= 52);
L343:
        LD    A,(05000H)
L344:
        CALL  writeLineA
L345:
        LD    HL,05000H
        INC   (HL)
L346:
        LD    A,(05000H)
L347:
        ADD   A,0
L348:
        SUB   A,52
L349:
        JP    C,L343
        JP    Z,L343
L350:
        ;;testDo.j(118)     // byte - integer
L351:
        ;;testDo.j(119)     //not relevant
L352:
        ;;testDo.j(120)     // integer - byte
L353:
        ;;testDo.j(121)     i=53;
L354:
        LD    A,53
L355:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L356:
        ;;testDo.j(122)     do { println (i); i++; } while (i+0 <= 54);
L357:
        LD    HL,(05001H)
L358:
        CALL  writeLineHL
L359:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L360:
        LD    HL,(05001H)
L361:
        LD    DE,0
        ADD   HL,DE
L362:
        LD    A,54
L363:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L364:
        JP    C,L357
        JP    Z,L357
L365:
        ;;testDo.j(123)   
L366:
        ;;testDo.j(124)     b=55;
L367:
        LD    A,55
L368:
        LD    (05000H),A
L369:
        ;;testDo.j(125)     i=1055;
L370:
        LD    HL,1055
L371:
        LD    (05001H),HL
L372:
        ;;testDo.j(126)     // integer - integer
L373:
        ;;testDo.j(127)     do { println (b); b++; i++; } while (i+0 <= 1056);
L374:
        LD    A,(05000H)
L375:
        CALL  writeLineA
L376:
        LD    HL,05000H
        INC   (HL)
L377:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L378:
        LD    HL,(05001H)
L379:
        LD    DE,0
        ADD   HL,DE
L380:
        LD    DE,1056
        OR    A
        SBC   HL,DE
L381:
        JP    C,L374
        JP    Z,L374
L382:
        ;;testDo.j(128)   
L383:
        ;;testDo.j(129)     /************************/
L384:
        ;;testDo.j(130)     // acc - acc
L385:
        ;;testDo.j(131)     // byte - byte
L386:
        ;;testDo.j(132)     b=57;
L387:
        LD    A,57
L388:
        LD    (05000H),A
L389:
        ;;testDo.j(133)     do { println (b); b++; } while (b+0 <= 58+0);
L390:
        LD    A,(05000H)
L391:
        CALL  writeLineA
L392:
        LD    HL,05000H
        INC   (HL)
L393:
        LD    A,(05000H)
L394:
        ADD   A,0
L395:
        PUSH AF
L396:
        LD    A,58
L397:
        ADD   A,0
L398:
        POP   BC
        SUB   A,B
L399:
        JP    C,L390
        JP    Z,L390
L400:
        ;;testDo.j(134)     // byte - integer
L401:
        ;;testDo.j(135)     i=61;
L402:
        LD    A,61
L403:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L404:
        ;;testDo.j(136)     do { println (b); b++; i--; } while (60+0 <= i+0);
L405:
        LD    A,(05000H)
L406:
        CALL  writeLineA
L407:
        LD    HL,05000H
        INC   (HL)
L408:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L409:
        LD    A,60
L410:
        ADD   A,0
L411:
        PUSH AF
L412:
        LD    HL,(05001H)
L413:
        LD    DE,0
        ADD   HL,DE
L414:
        POP  AF
L415:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L416:
        JP    C,L405
        JP    Z,L405
L417:
        ;;testDo.j(137)     // integer - byte
L418:
        ;;testDo.j(138)     i=61;
L419:
        LD    A,61
L420:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L421:
        ;;testDo.j(139)     b=62;
L422:
        LD    A,62
L423:
        LD    (05000H),A
L424:
        ;;testDo.j(140)     do { println (i); i++; } while (i+0 <= b+0);
L425:
        LD    HL,(05001H)
L426:
        CALL  writeLineHL
L427:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L428:
        LD    HL,(05001H)
L429:
        LD    DE,0
        ADD   HL,DE
L430:
        PUSH HL
L431:
        LD    A,(05000H)
L432:
        ADD   A,0
L433:
        POP  HL
L434:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L435:
        JP    C,L425
        JP    Z,L425
L436:
        ;;testDo.j(141)     // integer - integer
L437:
        ;;testDo.j(142)     b=63;
L438:
        LD    A,63
L439:
        LD    (05000H),A
L440:
        ;;testDo.j(143)     i=1063;
L441:
        LD    HL,1063
L442:
        LD    (05001H),HL
L443:
        ;;testDo.j(144)     do { println (b); b++; i--; } while (1000+62 <= i+0);
L444:
        LD    A,(05000H)
L445:
        CALL  writeLineA
L446:
        LD    HL,05000H
        INC   (HL)
L447:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L448:
        LD    HL,1000
L449:
        LD    DE,62
        ADD   HL,DE
L450:
        PUSH HL
L451:
        LD    HL,(05001H)
L452:
        LD    DE,0
        ADD   HL,DE
L453:
        POP   DE
        OR    A
        SBC   HL,DE
L454:
        JP    C,L444
        JP    Z,L444
L455:
        ;;testDo.j(145)   
L456:
        ;;testDo.j(146)     /************************/
L457:
        ;;testDo.j(147)     // acc - var
L458:
        ;;testDo.j(148)     // byte - byte
L459:
        ;;testDo.j(149)     b=65;
L460:
        LD    A,65
L461:
        LD    (05000H),A
L462:
        ;;testDo.j(150)     i=65;
L463:
        LD    A,65
L464:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L465:
        ;;testDo.j(151)     do { println (i); i++; b--; } while (64+0 <= b);
L466:
        LD    HL,(05001H)
L467:
        CALL  writeLineHL
L468:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L469:
        LD    HL,05000H
        DEC   (HL)
L470:
        LD    A,64
L471:
        ADD   A,0
L472:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L473:
        JP    C,L466
        JP    Z,L466
L474:
        ;;testDo.j(152)     // byte - integer
L475:
        ;;testDo.j(153)     b=67;
L476:
        LD    A,67
L477:
        LD    (05000H),A
L478:
        ;;testDo.j(154)     i=67;
L479:
        LD    A,67
L480:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L481:
        ;;testDo.j(155)     do { println (b); b++; i--; } while (66+0 <= i);
L482:
        LD    A,(05000H)
L483:
        CALL  writeLineA
L484:
        LD    HL,05000H
        INC   (HL)
L485:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L486:
        LD    A,66
L487:
        ADD   A,0
L488:
        LD    HL,(05001H)
L489:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L490:
        JP    C,L482
        JP    Z,L482
L491:
        ;;testDo.j(156)     // integer - byte
L492:
        ;;testDo.j(157)     i=69;
L493:
        LD    A,69
L494:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L495:
        ;;testDo.j(158)     b=69;
L496:
        LD    A,69
L497:
        LD    (05000H),A
L498:
        ;;testDo.j(159)     do { println (i); i++; b--; } while (1000+68 <= b);
L499:
        LD    HL,(05001H)
L500:
        CALL  writeLineHL
L501:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L502:
        LD    HL,05000H
        DEC   (HL)
L503:
        LD    HL,1000
L504:
        LD    DE,68
        ADD   HL,DE
L505:
        LD    A,(05000H)
L506:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L507:
        JP    C,L499
        JP    Z,L499
L508:
        ;;testDo.j(160)     // integer - integer
L509:
        ;;testDo.j(161)     i=1071;
L510:
        LD    HL,1071
L511:
        LD    (05001H),HL
L512:
        ;;testDo.j(162)     b=70;
L513:
        LD    A,70
L514:
        LD    (05000H),A
L515:
        ;;testDo.j(163)     do { println (b); b++; i--; } while (1000+70 <= i);
L516:
        LD    A,(05000H)
L517:
        CALL  writeLineA
L518:
        LD    HL,05000H
        INC   (HL)
L519:
        LD    HL,(05001H)
        DEC   HL
        LD    (05001H),HL
L520:
        LD    HL,1000
L521:
        LD    DE,70
        ADD   HL,DE
L522:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L523:
        JP    C,L516
        JP    Z,L516
L524:
        ;;testDo.j(164)   
L525:
        ;;testDo.j(165)     /************************/
L526:
        ;;testDo.j(166)     // acc - stack16
L527:
        ;;testDo.j(167)     // byte - byte
L528:
        ;;testDo.j(168)     //TODO
L529:
        ;;testDo.j(169)     println(72);
L530:
        LD    A,72
L531:
        CALL  writeLineA
L532:
        ;;testDo.j(170)     println(73);
L533:
        LD    A,73
L534:
        CALL  writeLineA
L535:
        ;;testDo.j(171)     // byte - integer
L536:
        ;;testDo.j(172)     //TODO
L537:
        ;;testDo.j(173)     println(74);
L538:
        LD    A,74
L539:
        CALL  writeLineA
L540:
        ;;testDo.j(174)     println(75);
L541:
        LD    A,75
L542:
        CALL  writeLineA
L543:
        ;;testDo.j(175)     // integer - byte
L544:
        ;;testDo.j(176)     //TODO
L545:
        ;;testDo.j(177)     println(76);
L546:
        LD    A,76
L547:
        CALL  writeLineA
L548:
        ;;testDo.j(178)     println(77);
L549:
        LD    A,77
L550:
        CALL  writeLineA
L551:
        ;;testDo.j(179)     // integer - integer
L552:
        ;;testDo.j(180)     //TODO
L553:
        ;;testDo.j(181)     println(78);
L554:
        LD    A,78
L555:
        CALL  writeLineA
L556:
        ;;testDo.j(182)     println(79);
L557:
        LD    A,79
L558:
        CALL  writeLineA
L559:
        ;;testDo.j(183)   
L560:
        ;;testDo.j(184)     /************************/
L561:
        ;;testDo.j(185)     // acc - stack8
L562:
        ;;testDo.j(186)     // byte - byte
L563:
        ;;testDo.j(187)     //TODO
L564:
        ;;testDo.j(188)     println(80);
L565:
        LD    A,80
L566:
        CALL  writeLineA
L567:
        ;;testDo.j(189)     println(81);
L568:
        LD    A,81
L569:
        CALL  writeLineA
L570:
        ;;testDo.j(190)     // byte - integer
L571:
        ;;testDo.j(191)     //TODO
L572:
        ;;testDo.j(192)     println(82);
L573:
        LD    A,82
L574:
        CALL  writeLineA
L575:
        ;;testDo.j(193)     println(83);
L576:
        LD    A,83
L577:
        CALL  writeLineA
L578:
        ;;testDo.j(194)     // integer - byte
L579:
        ;;testDo.j(195)     //TODO
L580:
        ;;testDo.j(196)     println(84);
L581:
        LD    A,84
L582:
        CALL  writeLineA
L583:
        ;;testDo.j(197)     println(85);
L584:
        LD    A,85
L585:
        CALL  writeLineA
L586:
        ;;testDo.j(198)     // integer - integer
L587:
        ;;testDo.j(199)     //TODO
L588:
        ;;testDo.j(200)     println(86);
L589:
        LD    A,86
L590:
        CALL  writeLineA
L591:
        ;;testDo.j(201)     println(87);
L592:
        LD    A,87
L593:
        CALL  writeLineA
L594:
        ;;testDo.j(202)   
L595:
        ;;testDo.j(203)     /************************/
L596:
        ;;testDo.j(204)     // var - constant
L597:
        ;;testDo.j(205)     // byte - byte
L598:
        ;;testDo.j(206)     b=88;
L599:
        LD    A,88
L600:
        LD    (05000H),A
L601:
        ;;testDo.j(207)     do { println (b); b++; } while (b <= 89);
L602:
        LD    A,(05000H)
L603:
        CALL  writeLineA
L604:
        LD    HL,05000H
        INC   (HL)
L605:
        LD    A,(05000H)
L606:
        SUB   A,89
L607:
        JP    C,L602
        JP    Z,L602
L608:
        ;;testDo.j(208)     // byte - integer
L609:
        ;;testDo.j(209)     //not relevant
L610:
        ;;testDo.j(210)     println(90);
L611:
        LD    A,90
L612:
        CALL  writeLineA
L613:
        ;;testDo.j(211)     println(91);
L614:
        LD    A,91
L615:
        CALL  writeLineA
L616:
        ;;testDo.j(212)     // integer - byte
L617:
        ;;testDo.j(213)     i=92;
L618:
        LD    A,92
L619:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L620:
        ;;testDo.j(214)     do { println (i); i++; } while (i <= 93);
L621:
        LD    HL,(05001H)
L622:
        CALL  writeLineHL
L623:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L624:
        LD    HL,(05001H)
L625:
        LD    A,93
L626:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L627:
        JP    C,L621
        JP    Z,L621
L628:
        ;;testDo.j(215)     // integer - integer
L629:
        ;;testDo.j(216)     i=1094;
L630:
        LD    HL,1094
L631:
        LD    (05001H),HL
L632:
        ;;testDo.j(217)     b=94;
L633:
        LD    A,94
L634:
        LD    (05000H),A
L635:
        ;;testDo.j(218)     do { println (b); b++; i++; } while (i <= 1095  );
L636:
        LD    A,(05000H)
L637:
        CALL  writeLineA
L638:
        LD    HL,05000H
        INC   (HL)
L639:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L640:
        LD    HL,(05001H)
L641:
        LD    DE,1095
        OR    A
        SBC   HL,DE
L642:
        JP    C,L636
        JP    Z,L636
L643:
        ;;testDo.j(219)   
L644:
        ;;testDo.j(220)     /************************/
L645:
        ;;testDo.j(221)     // var - acc
L646:
        ;;testDo.j(222)     // byte - byte
L647:
        ;;testDo.j(223)     do { println (b); b++; } while (b <= 97+0);
L648:
        LD    A,(05000H)
L649:
        CALL  writeLineA
L650:
        LD    HL,05000H
        INC   (HL)
L651:
        LD    A,97
L652:
        ADD   A,0
L653:
        LD    B,A
        LD    A,(05000H)
        SUB   A,B
L654:
        JP    C,L648
        JP    Z,L648
L655:
        ;;testDo.j(224)     // byte - integer
L656:
        ;;testDo.j(225)     //not relevant
L657:
        ;;testDo.j(226)     i=99;
L658:
        LD    A,99
L659:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L660:
        ;;testDo.j(227)     do { println (b); b++; } while (b <= i+0);
L661:
        LD    A,(05000H)
L662:
        CALL  writeLineA
L663:
        LD    HL,05000H
        INC   (HL)
L664:
        LD    HL,(05001H)
L665:
        LD    DE,0
        ADD   HL,DE
L666:
        LD    A,(05000H)
L667:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L668:
        JP    C,L661
        JP    Z,L661
L669:
        ;;testDo.j(228)     // integer - byte
L670:
        ;;testDo.j(229)     i=100;
L671:
        LD    A,100
L672:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L673:
        ;;testDo.j(230)     do { println (i); i++; } while (i <= 101+0);
L674:
        LD    HL,(05001H)
L675:
        CALL  writeLineHL
L676:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L677:
        LD    A,101
L678:
        ADD   A,0
L679:
        LD    HL,(05001H)
L680:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L681:
        JP    C,L674
        JP    Z,L674
L682:
        ;;testDo.j(231)     // integer - integer
L683:
        ;;testDo.j(232)     i=1102;
L684:
        LD    HL,1102
L685:
        LD    (05001H),HL
L686:
        ;;testDo.j(233)     b=102;
L687:
        LD    A,102
L688:
        LD    (05000H),A
L689:
        ;;testDo.j(234)     do { println (b); b++; i++; } while (i <= 1103+0);
L690:
        LD    A,(05000H)
L691:
        CALL  writeLineA
L692:
        LD    HL,05000H
        INC   (HL)
L693:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L694:
        LD    HL,1103
L695:
        LD    DE,0
        ADD   HL,DE
L696:
        LD    DE,(05001H)
        OR    A
        SBC   HL,DE
L697:
        JP    C,L690
        JP    Z,L690
L698:
        ;;testDo.j(235)   
L699:
        ;;testDo.j(236)     /************************/
L700:
        ;;testDo.j(237)     // var - var
L701:
        ;;testDo.j(238)     // byte - byte
L702:
        ;;testDo.j(239)     byte b2 = 105;
L703:
        LD    A,105
L704:
        LD    (IX - 1),A
L705:
        ;;testDo.j(240)     do { println (b); b++; } while (b <= b2);
L706:
        LD    A,(05000H)
L707:
        CALL  writeLineA
L708:
        LD    HL,05000H
        INC   (HL)
L709:
        LD    A,(05000H)
L710:
        SUB   A,(IX - 1)
L711:
        JP    C,L706
        JP    Z,L706
L712:
        ;;testDo.j(241)     // byte - integer
L713:
        ;;testDo.j(242)     i=107;
L714:
        LD    A,107
L715:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L716:
        ;;testDo.j(243)     do { println (b); b++; } while (b <= i);
L717:
        LD    A,(05000H)
L718:
        CALL  writeLineA
L719:
        LD    HL,05000H
        INC   (HL)
L720:
        LD    A,(05000H)
L721:
        LD    HL,(05001H)
L722:
        LD    E,A
        LD    D,0
        OR    A
        SBC   HL,DE
L723:
        JP    C,L717
        JP    Z,L717
L724:
        ;;testDo.j(244)     // integer - byte
L725:
        ;;testDo.j(245)     i=b;
L726:
        LD    A,(05000H)
L727:
        LD    L,A
        LD    H,0
        LD    (05001H),HL
L728:
        ;;testDo.j(246)     b=109;
L729:
        LD    A,109
L730:
        LD    (05000H),A
L731:
        ;;testDo.j(247)     do { println (i); i++; } while (i <= b);
L732:
        LD    HL,(05001H)
L733:
        CALL  writeLineHL
L734:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L735:
        LD    HL,(05001H)
L736:
        LD    A,(05000H)
L737:
        LD    E,A
        LD    D,0
        EX    DE,HL
        OR    A
        SBC   HL,DE
L738:
        JP    C,L732
        JP    Z,L732
L739:
        ;;testDo.j(248)     // integer - integer
L740:
        ;;testDo.j(249)     word i2 = 111;
L741:
        LD    A,111
L742:
        LD    (IX - 3),A
L743:
        ;;testDo.j(250)     do { println (i); i++; } while (i <= i2);
L744:
        LD    HL,(05001H)
L745:
        CALL  writeLineHL
L746:
        LD    HL,(05001H)
        INC   HL
        LD    (05001H),HL
L747:
        LD    HL,(05001H)
L748:
        LD    E,(IX - 3)
        LD    D,(IX - 2)
        OR    A
        SBC   HL,DE
L749:
        JP    C,L744
        JP    Z,L744
L750:
        ;;testDo.j(251)   
L751:
        ;;testDo.j(252)     /************************/
L752:
        ;;testDo.j(253)     // var - stack8
L753:
        ;;testDo.j(254)     // byte - byte
L754:
        ;;testDo.j(255)     // byte - integer
L755:
        ;;testDo.j(256)     // integer - byte
L756:
        ;;testDo.j(257)     // integer - integer
L757:
        ;;testDo.j(258)     //TODO
L758:
        ;;testDo.j(259)   
L759:
        ;;testDo.j(260)     /************************/
L760:
        ;;testDo.j(261)     // var - stack16
L761:
        ;;testDo.j(262)     // byte - byte
L762:
        ;;testDo.j(263)     // byte - integer
L763:
        ;;testDo.j(264)     // integer - byte
L764:
        ;;testDo.j(265)     // integer - integer
L765:
        ;;testDo.j(266)     //TODO
L766:
        ;;testDo.j(267)   
L767:
        ;;testDo.j(268)     /************************/
L768:
        ;;testDo.j(269)     // stack8 - constant
L769:
        ;;testDo.j(270)     // stack8 - acc
L770:
        ;;testDo.j(271)     // stack8 - var
L771:
        ;;testDo.j(272)     // stack8 - stack8
L772:
        ;;testDo.j(273)     // stack8 - stack16
L773:
        ;;testDo.j(274)     //TODO
L774:
        ;;testDo.j(275)   
L775:
        ;;testDo.j(276)     /************************/
L776:
        ;;testDo.j(277)     // stack16 - constant
L777:
        ;;testDo.j(278)     // stack16 - acc
L778:
        ;;testDo.j(279)     // stack16 - var
L779:
        ;;testDo.j(280)     // stack16 - stack8
L780:
        ;;testDo.j(281)     // stack16 - stack16
L781:
        ;;testDo.j(282)     //TODO
L782:
        ;;testDo.j(283)   
L783:
        ;;testDo.j(284)     println("Klaar");
L784:
        LD    HL,L791
L785:
        CALL  writeLineStr
L786:
        ;;testDo.j(285)   }
L787:
        LD    SP,IX
L788:
        POP   IX
L789:
        return
L790:
        ;;testDo.j(286) }
L791:
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
