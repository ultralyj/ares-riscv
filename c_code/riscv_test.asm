
riscv_test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010054 <main>:
void hdmi_clean(uint32_t color);
void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color);
void printbar(int *arr, int color, int color2, int changedbar);

int main()
{
   10054:	f6010113          	addi	sp,sp,-160
   10058:	08112e23          	sw	ra,156(sp)
   1005c:	08812c23          	sw	s0,152(sp)
   10060:	0a010413          	addi	s0,sp,160
    int a[14];
    const int b[14] = {5, 2, 7, 3, 1, 1, 9, 3, 4, 5, 2, 6, 8};
   10064:	f6042623          	sw	zero,-148(s0)
   10068:	f6042823          	sw	zero,-144(s0)
   1006c:	f6042a23          	sw	zero,-140(s0)
   10070:	f6042c23          	sw	zero,-136(s0)
   10074:	f6042e23          	sw	zero,-132(s0)
   10078:	f8042023          	sw	zero,-128(s0)
   1007c:	f8042223          	sw	zero,-124(s0)
   10080:	f8042423          	sw	zero,-120(s0)
   10084:	f8042623          	sw	zero,-116(s0)
   10088:	f8042823          	sw	zero,-112(s0)
   1008c:	f8042a23          	sw	zero,-108(s0)
   10090:	f8042c23          	sw	zero,-104(s0)
   10094:	f8042e23          	sw	zero,-100(s0)
   10098:	fa042023          	sw	zero,-96(s0)
   1009c:	00500793          	li	a5,5
   100a0:	f6f42623          	sw	a5,-148(s0)
   100a4:	00200793          	li	a5,2
   100a8:	f6f42823          	sw	a5,-144(s0)
   100ac:	00700793          	li	a5,7
   100b0:	f6f42a23          	sw	a5,-140(s0)
   100b4:	00300793          	li	a5,3
   100b8:	f6f42c23          	sw	a5,-136(s0)
   100bc:	00100793          	li	a5,1
   100c0:	f6f42e23          	sw	a5,-132(s0)
   100c4:	00100793          	li	a5,1
   100c8:	f8f42023          	sw	a5,-128(s0)
   100cc:	00900793          	li	a5,9
   100d0:	f8f42223          	sw	a5,-124(s0)
   100d4:	00300793          	li	a5,3
   100d8:	f8f42423          	sw	a5,-120(s0)
   100dc:	00400793          	li	a5,4
   100e0:	f8f42623          	sw	a5,-116(s0)
   100e4:	00500793          	li	a5,5
   100e8:	f8f42823          	sw	a5,-112(s0)
   100ec:	00200793          	li	a5,2
   100f0:	f8f42a23          	sw	a5,-108(s0)
   100f4:	00600793          	li	a5,6
   100f8:	f8f42c23          	sw	a5,-104(s0)
   100fc:	00800793          	li	a5,8
   10100:	f8f42e23          	sw	a5,-100(s0)
    //int n = 6;
    int temp = 0;
   10104:	fc042e23          	sw	zero,-36(s0)
    hdmi_clean(WHITE);
   10108:	000107b7          	lui	a5,0x10
   1010c:	fff78513          	addi	a0,a5,-1 # ffff <main-0x55>
   10110:	420000ef          	jal	ra,10530 <hdmi_clean>
    for (int i = 0; i < 14; i++)
   10114:	fe042623          	sw	zero,-20(s0)
   10118:	0380006f          	j	10150 <main+0xfc>
    {
        a[i] = b[i];
   1011c:	fec42783          	lw	a5,-20(s0)
   10120:	00279793          	slli	a5,a5,0x2
   10124:	ff040713          	addi	a4,s0,-16
   10128:	00f707b3          	add	a5,a4,a5
   1012c:	f7c7a703          	lw	a4,-132(a5)
   10130:	fec42783          	lw	a5,-20(s0)
   10134:	00279793          	slli	a5,a5,0x2
   10138:	ff040693          	addi	a3,s0,-16
   1013c:	00f687b3          	add	a5,a3,a5
   10140:	fae7aa23          	sw	a4,-76(a5)
    for (int i = 0; i < 14; i++)
   10144:	fec42783          	lw	a5,-20(s0)
   10148:	00178793          	addi	a5,a5,1
   1014c:	fef42623          	sw	a5,-20(s0)
   10150:	fec42703          	lw	a4,-20(s0)
   10154:	00d00793          	li	a5,13
   10158:	fce7d2e3          	bge	a5,a4,1011c <main+0xc8>
    }
    for (int j = 0; j < 14 - 1; j++)
   1015c:	fe042423          	sw	zero,-24(s0)
   10160:	0e00006f          	j	10240 <main+0x1ec>
    {
        for (int i = 0; i < 14 - 1 - j; i++)
   10164:	fe042223          	sw	zero,-28(s0)
   10168:	0b80006f          	j	10220 <main+0x1cc>
        {
            if (a[i] > a[i + 1])
   1016c:	fe442783          	lw	a5,-28(s0)
   10170:	00279793          	slli	a5,a5,0x2
   10174:	ff040713          	addi	a4,s0,-16
   10178:	00f707b3          	add	a5,a4,a5
   1017c:	fb47a703          	lw	a4,-76(a5)
   10180:	fe442783          	lw	a5,-28(s0)
   10184:	00178793          	addi	a5,a5,1
   10188:	00279793          	slli	a5,a5,0x2
   1018c:	ff040693          	addi	a3,s0,-16
   10190:	00f687b3          	add	a5,a3,a5
   10194:	fb47a783          	lw	a5,-76(a5)
   10198:	06e7de63          	bge	a5,a4,10214 <main+0x1c0>
            {
                temp = a[i];
   1019c:	fe442783          	lw	a5,-28(s0)
   101a0:	00279793          	slli	a5,a5,0x2
   101a4:	ff040713          	addi	a4,s0,-16
   101a8:	00f707b3          	add	a5,a4,a5
   101ac:	fb47a783          	lw	a5,-76(a5)
   101b0:	fcf42e23          	sw	a5,-36(s0)
                a[i] = a[i + 1];
   101b4:	fe442783          	lw	a5,-28(s0)
   101b8:	00178793          	addi	a5,a5,1
   101bc:	00279793          	slli	a5,a5,0x2
   101c0:	ff040713          	addi	a4,s0,-16
   101c4:	00f707b3          	add	a5,a4,a5
   101c8:	fb47a703          	lw	a4,-76(a5)
   101cc:	fe442783          	lw	a5,-28(s0)
   101d0:	00279793          	slli	a5,a5,0x2
   101d4:	ff040693          	addi	a3,s0,-16
   101d8:	00f687b3          	add	a5,a3,a5
   101dc:	fae7aa23          	sw	a4,-76(a5)
                a[i + 1] = temp;
   101e0:	fe442783          	lw	a5,-28(s0)
   101e4:	00178793          	addi	a5,a5,1
   101e8:	00279793          	slli	a5,a5,0x2
   101ec:	ff040713          	addi	a4,s0,-16
   101f0:	00f707b3          	add	a5,a4,a5
   101f4:	fdc42703          	lw	a4,-36(s0)
   101f8:	fae7aa23          	sw	a4,-76(a5)
                printbar(a, BLUE, BLACK, i);
   101fc:	fa440793          	addi	a5,s0,-92
   10200:	fe442683          	lw	a3,-28(s0)
   10204:	00000613          	li	a2,0
   10208:	01f00593          	li	a1,31
   1020c:	00078513          	mv	a0,a5
   10210:	08c000ef          	jal	ra,1029c <printbar>
        for (int i = 0; i < 14 - 1 - j; i++)
   10214:	fe442783          	lw	a5,-28(s0)
   10218:	00178793          	addi	a5,a5,1
   1021c:	fef42223          	sw	a5,-28(s0)
   10220:	00d00713          	li	a4,13
   10224:	fe842783          	lw	a5,-24(s0)
   10228:	40f707b3          	sub	a5,a4,a5
   1022c:	fe442703          	lw	a4,-28(s0)
   10230:	f2f74ee3          	blt	a4,a5,1016c <main+0x118>
    for (int j = 0; j < 14 - 1; j++)
   10234:	fe842783          	lw	a5,-24(s0)
   10238:	00178793          	addi	a5,a5,1
   1023c:	fef42423          	sw	a5,-24(s0)
   10240:	fe842703          	lw	a4,-24(s0)
   10244:	00c00793          	li	a5,12
   10248:	f0e7dee3          	bge	a5,a4,10164 <main+0x110>
            }
        }
    }
    for (int j = 0; j < 14 - 1; j++) 
   1024c:	fe042023          	sw	zero,-32(s0)
   10250:	0280006f          	j	10278 <main+0x224>
    {
        printbar(a, GREEN, BLACK, j);
   10254:	fa440793          	addi	a5,s0,-92
   10258:	fe042683          	lw	a3,-32(s0)
   1025c:	00000613          	li	a2,0
   10260:	7e000593          	li	a1,2016
   10264:	00078513          	mv	a0,a5
   10268:	034000ef          	jal	ra,1029c <printbar>
    for (int j = 0; j < 14 - 1; j++) 
   1026c:	fe042783          	lw	a5,-32(s0)
   10270:	00178793          	addi	a5,a5,1
   10274:	fef42023          	sw	a5,-32(s0)
   10278:	fe042703          	lw	a4,-32(s0)
   1027c:	00c00793          	li	a5,12
   10280:	fce7dae3          	bge	a5,a4,10254 <main+0x200>
    }
    return 0;
   10284:	00000793          	li	a5,0
}
   10288:	00078513          	mv	a0,a5
   1028c:	09c12083          	lw	ra,156(sp)
   10290:	09812403          	lw	s0,152(sp)
   10294:	0a010113          	addi	sp,sp,160
   10298:	00008067          	ret

0001029c <printbar>:

void printbar(int *arr, int color, int color2, int changedbar)
{
   1029c:	fd010113          	addi	sp,sp,-48
   102a0:	02112623          	sw	ra,44(sp)
   102a4:	02812423          	sw	s0,40(sp)
   102a8:	03010413          	addi	s0,sp,48
   102ac:	fca42e23          	sw	a0,-36(s0)
   102b0:	fcb42c23          	sw	a1,-40(s0)
   102b4:	fcc42a23          	sw	a2,-44(s0)
   102b8:	fcd42823          	sw	a3,-48(s0)
    for (int k = 0; k < 14; k++)
   102bc:	fe042623          	sw	zero,-20(s0)
   102c0:	1d00006f          	j	10490 <printbar+0x1f4>
    {
        for (int k2 = 0; k2 < 10; k2++)
   102c4:	fe042423          	sw	zero,-24(s0)
   102c8:	1b00006f          	j	10478 <printbar+0x1dc>
        {
            if (arr[k] <= k2)
   102cc:	fec42783          	lw	a5,-20(s0)
   102d0:	00279793          	slli	a5,a5,0x2
   102d4:	fdc42703          	lw	a4,-36(s0)
   102d8:	00f707b3          	add	a5,a4,a5
   102dc:	0007a783          	lw	a5,0(a5)
   102e0:	fe842703          	lw	a4,-24(s0)
   102e4:	10f74663          	blt	a4,a5,103f0 <printbar+0x154>
            {
                if (k != changedbar)
   102e8:	fec42703          	lw	a4,-20(s0)
   102ec:	fd042783          	lw	a5,-48(s0)
   102f0:	08f70263          	beq	a4,a5,10374 <printbar+0xd8>
                {
                    hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, color);
   102f4:	fe842783          	lw	a5,-24(s0)
   102f8:	00178713          	addi	a4,a5,1
   102fc:	00070793          	mv	a5,a4
   10300:	00279793          	slli	a5,a5,0x2
   10304:	00e787b3          	add	a5,a5,a4
   10308:	00179793          	slli	a5,a5,0x1
   1030c:	00078513          	mv	a0,a5
   10310:	fec42783          	lw	a5,-20(s0)
   10314:	00178713          	addi	a4,a5,1
   10318:	00070793          	mv	a5,a4
   1031c:	00279793          	slli	a5,a5,0x2
   10320:	00e787b3          	add	a5,a5,a4
   10324:	00179793          	slli	a5,a5,0x1
   10328:	00078593          	mv	a1,a5
   1032c:	fe842703          	lw	a4,-24(s0)
   10330:	00070793          	mv	a5,a4
   10334:	00279793          	slli	a5,a5,0x2
   10338:	00e787b3          	add	a5,a5,a4
   1033c:	00179793          	slli	a5,a5,0x1
   10340:	01378793          	addi	a5,a5,19
   10344:	00078613          	mv	a2,a5
   10348:	fec42703          	lw	a4,-20(s0)
   1034c:	00070793          	mv	a5,a4
   10350:	00279793          	slli	a5,a5,0x2
   10354:	00e787b3          	add	a5,a5,a4
   10358:	00179793          	slli	a5,a5,0x1
   1035c:	01378793          	addi	a5,a5,19
   10360:	00078693          	mv	a3,a5
   10364:	fd842783          	lw	a5,-40(s0)
   10368:	00078713          	mv	a4,a5
   1036c:	250000ef          	jal	ra,105bc <hdmi_block>
   10370:	0fc0006f          	j	1046c <printbar+0x1d0>
                }
                else
                {
                    hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, GREEN);
   10374:	fe842783          	lw	a5,-24(s0)
   10378:	00178713          	addi	a4,a5,1
   1037c:	00070793          	mv	a5,a4
   10380:	00279793          	slli	a5,a5,0x2
   10384:	00e787b3          	add	a5,a5,a4
   10388:	00179793          	slli	a5,a5,0x1
   1038c:	00078513          	mv	a0,a5
   10390:	fec42783          	lw	a5,-20(s0)
   10394:	00178713          	addi	a4,a5,1
   10398:	00070793          	mv	a5,a4
   1039c:	00279793          	slli	a5,a5,0x2
   103a0:	00e787b3          	add	a5,a5,a4
   103a4:	00179793          	slli	a5,a5,0x1
   103a8:	00078593          	mv	a1,a5
   103ac:	fe842703          	lw	a4,-24(s0)
   103b0:	00070793          	mv	a5,a4
   103b4:	00279793          	slli	a5,a5,0x2
   103b8:	00e787b3          	add	a5,a5,a4
   103bc:	00179793          	slli	a5,a5,0x1
   103c0:	01378793          	addi	a5,a5,19
   103c4:	00078613          	mv	a2,a5
   103c8:	fec42703          	lw	a4,-20(s0)
   103cc:	00070793          	mv	a5,a4
   103d0:	00279793          	slli	a5,a5,0x2
   103d4:	00e787b3          	add	a5,a5,a4
   103d8:	00179793          	slli	a5,a5,0x1
   103dc:	01378793          	addi	a5,a5,19
   103e0:	7e000713          	li	a4,2016
   103e4:	00078693          	mv	a3,a5
   103e8:	1d4000ef          	jal	ra,105bc <hdmi_block>
   103ec:	0800006f          	j	1046c <printbar+0x1d0>
                }
            }
            else
            {
                hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, color2);
   103f0:	fe842783          	lw	a5,-24(s0)
   103f4:	00178713          	addi	a4,a5,1
   103f8:	00070793          	mv	a5,a4
   103fc:	00279793          	slli	a5,a5,0x2
   10400:	00e787b3          	add	a5,a5,a4
   10404:	00179793          	slli	a5,a5,0x1
   10408:	00078513          	mv	a0,a5
   1040c:	fec42783          	lw	a5,-20(s0)
   10410:	00178713          	addi	a4,a5,1
   10414:	00070793          	mv	a5,a4
   10418:	00279793          	slli	a5,a5,0x2
   1041c:	00e787b3          	add	a5,a5,a4
   10420:	00179793          	slli	a5,a5,0x1
   10424:	00078593          	mv	a1,a5
   10428:	fe842703          	lw	a4,-24(s0)
   1042c:	00070793          	mv	a5,a4
   10430:	00279793          	slli	a5,a5,0x2
   10434:	00e787b3          	add	a5,a5,a4
   10438:	00179793          	slli	a5,a5,0x1
   1043c:	01378793          	addi	a5,a5,19
   10440:	00078613          	mv	a2,a5
   10444:	fec42703          	lw	a4,-20(s0)
   10448:	00070793          	mv	a5,a4
   1044c:	00279793          	slli	a5,a5,0x2
   10450:	00e787b3          	add	a5,a5,a4
   10454:	00179793          	slli	a5,a5,0x1
   10458:	01378793          	addi	a5,a5,19
   1045c:	00078693          	mv	a3,a5
   10460:	fd442783          	lw	a5,-44(s0)
   10464:	00078713          	mv	a4,a5
   10468:	154000ef          	jal	ra,105bc <hdmi_block>
        for (int k2 = 0; k2 < 10; k2++)
   1046c:	fe842783          	lw	a5,-24(s0)
   10470:	00178793          	addi	a5,a5,1
   10474:	fef42423          	sw	a5,-24(s0)
   10478:	fe842703          	lw	a4,-24(s0)
   1047c:	00900793          	li	a5,9
   10480:	e4e7d6e3          	bge	a5,a4,102cc <printbar+0x30>
    for (int k = 0; k < 14; k++)
   10484:	fec42783          	lw	a5,-20(s0)
   10488:	00178793          	addi	a5,a5,1
   1048c:	fef42623          	sw	a5,-20(s0)
   10490:	fec42703          	lw	a4,-20(s0)
   10494:	00d00793          	li	a5,13
   10498:	e2e7d6e3          	bge	a5,a4,102c4 <printbar+0x28>
            }
        }
    }
    delay();
   1049c:	018000ef          	jal	ra,104b4 <delay>
}
   104a0:	00000013          	nop
   104a4:	02c12083          	lw	ra,44(sp)
   104a8:	02812403          	lw	s0,40(sp)
   104ac:	03010113          	addi	sp,sp,48
   104b0:	00008067          	ret

000104b4 <delay>:

void delay()
{
   104b4:	fe010113          	addi	sp,sp,-32
   104b8:	00812e23          	sw	s0,28(sp)
   104bc:	02010413          	addi	s0,sp,32
    int i, j, k;
    for (i = 0; i < 10; i++)
   104c0:	fe042623          	sw	zero,-20(s0)
   104c4:	0500006f          	j	10514 <delay+0x60>
        for (j = 0; j < 1000; j++)
   104c8:	fe042423          	sw	zero,-24(s0)
   104cc:	0300006f          	j	104fc <delay+0x48>
            for (k = 0; k < 1000; k++)
   104d0:	fe042223          	sw	zero,-28(s0)
   104d4:	0100006f          	j	104e4 <delay+0x30>
   104d8:	fe442783          	lw	a5,-28(s0)
   104dc:	00178793          	addi	a5,a5,1
   104e0:	fef42223          	sw	a5,-28(s0)
   104e4:	fe442703          	lw	a4,-28(s0)
   104e8:	3e700793          	li	a5,999
   104ec:	fee7d6e3          	bge	a5,a4,104d8 <delay+0x24>
        for (j = 0; j < 1000; j++)
   104f0:	fe842783          	lw	a5,-24(s0)
   104f4:	00178793          	addi	a5,a5,1
   104f8:	fef42423          	sw	a5,-24(s0)
   104fc:	fe842703          	lw	a4,-24(s0)
   10500:	3e700793          	li	a5,999
   10504:	fce7d6e3          	bge	a5,a4,104d0 <delay+0x1c>
    for (i = 0; i < 10; i++)
   10508:	fec42783          	lw	a5,-20(s0)
   1050c:	00178793          	addi	a5,a5,1
   10510:	fef42623          	sw	a5,-20(s0)
   10514:	fec42703          	lw	a4,-20(s0)
   10518:	00900793          	li	a5,9
   1051c:	fae7d6e3          	bge	a5,a4,104c8 <delay+0x14>
                ;
}
   10520:	00000013          	nop
   10524:	01c12403          	lw	s0,28(sp)
   10528:	02010113          	addi	sp,sp,32
   1052c:	00008067          	ret

00010530 <hdmi_clean>:

void hdmi_clean(uint32_t color)
{
   10530:	fd010113          	addi	sp,sp,-48
   10534:	02812623          	sw	s0,44(sp)
   10538:	03010413          	addi	s0,sp,48
   1053c:	fca42e23          	sw	a0,-36(s0)
    int i, j;
    uint32_t *hdmi_addr = HDMI0_Base;
   10540:	010007b7          	lui	a5,0x1000
   10544:	fef42223          	sw	a5,-28(s0)
    for (i = 0; i < 90; i++)
   10548:	fe042623          	sw	zero,-20(s0)
   1054c:	0540006f          	j	105a0 <hdmi_clean+0x70>
    {
        for (j = 0; j < 160; j++)
   10550:	fe042423          	sw	zero,-24(s0)
   10554:	0340006f          	j	10588 <hdmi_clean+0x58>
        {
            hdmi_addr[i * 256 + j] = (uint32_t)color;
   10558:	fec42783          	lw	a5,-20(s0)
   1055c:	00879713          	slli	a4,a5,0x8
   10560:	fe842783          	lw	a5,-24(s0)
   10564:	00f707b3          	add	a5,a4,a5
   10568:	00279793          	slli	a5,a5,0x2
   1056c:	fe442703          	lw	a4,-28(s0)
   10570:	00f707b3          	add	a5,a4,a5
   10574:	fdc42703          	lw	a4,-36(s0)
   10578:	00e7a023          	sw	a4,0(a5) # 1000000 <__global_pointer$+0xfee1a0>
        for (j = 0; j < 160; j++)
   1057c:	fe842783          	lw	a5,-24(s0)
   10580:	00178793          	addi	a5,a5,1
   10584:	fef42423          	sw	a5,-24(s0)
   10588:	fe842703          	lw	a4,-24(s0)
   1058c:	09f00793          	li	a5,159
   10590:	fce7d4e3          	bge	a5,a4,10558 <hdmi_clean+0x28>
    for (i = 0; i < 90; i++)
   10594:	fec42783          	lw	a5,-20(s0)
   10598:	00178793          	addi	a5,a5,1
   1059c:	fef42623          	sw	a5,-20(s0)
   105a0:	fec42703          	lw	a4,-20(s0)
   105a4:	05900793          	li	a5,89
   105a8:	fae7d4e3          	bge	a5,a4,10550 <hdmi_clean+0x20>
        }
    }
}
   105ac:	00000013          	nop
   105b0:	02c12403          	lw	s0,44(sp)
   105b4:	03010113          	addi	sp,sp,48
   105b8:	00008067          	ret

000105bc <hdmi_block>:

void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color)
{
   105bc:	fc010113          	addi	sp,sp,-64
   105c0:	02812e23          	sw	s0,60(sp)
   105c4:	04010413          	addi	s0,sp,64
   105c8:	fca42e23          	sw	a0,-36(s0)
   105cc:	fcb42c23          	sw	a1,-40(s0)
   105d0:	fcc42a23          	sw	a2,-44(s0)
   105d4:	fcd42823          	sw	a3,-48(s0)
   105d8:	fce42623          	sw	a4,-52(s0)
    uint32_t *hdmi_addr = HDMI0_Base;
   105dc:	010007b7          	lui	a5,0x1000
   105e0:	fef42223          	sw	a5,-28(s0)
    for (uint32_t i = x; i < x1; i++)
   105e4:	fdc42783          	lw	a5,-36(s0)
   105e8:	fef42623          	sw	a5,-20(s0)
   105ec:	0580006f          	j	10644 <hdmi_block+0x88>
        for (uint32_t j = y; j < y1; j++)
   105f0:	fd842783          	lw	a5,-40(s0)
   105f4:	fef42423          	sw	a5,-24(s0)
   105f8:	0340006f          	j	1062c <hdmi_block+0x70>
            hdmi_addr[i * 256 + j] = (uint32_t)color;
   105fc:	fec42783          	lw	a5,-20(s0)
   10600:	00879713          	slli	a4,a5,0x8
   10604:	fe842783          	lw	a5,-24(s0)
   10608:	00f707b3          	add	a5,a4,a5
   1060c:	00279793          	slli	a5,a5,0x2
   10610:	fe442703          	lw	a4,-28(s0)
   10614:	00f707b3          	add	a5,a4,a5
   10618:	fcc42703          	lw	a4,-52(s0)
   1061c:	00e7a023          	sw	a4,0(a5) # 1000000 <__global_pointer$+0xfee1a0>
        for (uint32_t j = y; j < y1; j++)
   10620:	fe842783          	lw	a5,-24(s0)
   10624:	00178793          	addi	a5,a5,1
   10628:	fef42423          	sw	a5,-24(s0)
   1062c:	fe842703          	lw	a4,-24(s0)
   10630:	fd042783          	lw	a5,-48(s0)
   10634:	fcf764e3          	bltu	a4,a5,105fc <hdmi_block+0x40>
    for (uint32_t i = x; i < x1; i++)
   10638:	fec42783          	lw	a5,-20(s0)
   1063c:	00178793          	addi	a5,a5,1
   10640:	fef42623          	sw	a5,-20(s0)
   10644:	fec42703          	lw	a4,-20(s0)
   10648:	fd442783          	lw	a5,-44(s0)
   1064c:	faf762e3          	bltu	a4,a5,105f0 <hdmi_block+0x34>
}
   10650:	00000013          	nop
   10654:	03c12403          	lw	s0,60(sp)
   10658:	04010113          	addi	sp,sp,64
   1065c:	00008067          	ret
