
riscv_test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010054 <main>:
void delay();
void hdmi_clean(uint32_t color);
void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color);

int main()
{
   10054:	fa010113          	addi	sp,sp,-96
   10058:	04112e23          	sw	ra,92(sp)
   1005c:	04812c23          	sw	s0,88(sp)
   10060:	06010413          	addi	s0,sp,96
    int a[6], b[6] = {5, 2, 7, 3, 8, 1};
   10064:	000107b7          	lui	a5,0x10
   10068:	4fc7a503          	lw	a0,1276(a5) # 104fc <hdmi_block+0xa4>
   1006c:	4fc78713          	addi	a4,a5,1276
   10070:	00472583          	lw	a1,4(a4)
   10074:	4fc78713          	addi	a4,a5,1276
   10078:	00872603          	lw	a2,8(a4)
   1007c:	4fc78713          	addi	a4,a5,1276
   10080:	00c72683          	lw	a3,12(a4)
   10084:	4fc78713          	addi	a4,a5,1276
   10088:	01072703          	lw	a4,16(a4)
   1008c:	4fc78793          	addi	a5,a5,1276
   10090:	0147a783          	lw	a5,20(a5)
   10094:	faa42423          	sw	a0,-88(s0)
   10098:	fab42623          	sw	a1,-84(s0)
   1009c:	fac42823          	sw	a2,-80(s0)
   100a0:	fad42a23          	sw	a3,-76(s0)
   100a4:	fae42c23          	sw	a4,-72(s0)
   100a8:	faf42e23          	sw	a5,-68(s0)
    int temp = 0;
   100ac:	fc042c23          	sw	zero,-40(s0)
    hdmi_clean(MAGENTA);
   100b0:	000107b7          	lui	a5,0x10
   100b4:	81f78513          	addi	a0,a5,-2017 # f81f <main-0x835>
   100b8:	314000ef          	jal	ra,103cc <hdmi_clean>
    for (int i = 0; i < 6; i++)
   100bc:	fe042623          	sw	zero,-20(s0)
   100c0:	0380006f          	j	100f8 <main+0xa4>
    {
        a[i] = b[i];
   100c4:	fec42783          	lw	a5,-20(s0)
   100c8:	00279793          	slli	a5,a5,0x2
   100cc:	ff040713          	addi	a4,s0,-16
   100d0:	00f707b3          	add	a5,a4,a5
   100d4:	fb87a703          	lw	a4,-72(a5)
   100d8:	fec42783          	lw	a5,-20(s0)
   100dc:	00279793          	slli	a5,a5,0x2
   100e0:	ff040693          	addi	a3,s0,-16
   100e4:	00f687b3          	add	a5,a3,a5
   100e8:	fce7a823          	sw	a4,-48(a5)
    for (int i = 0; i < 6; i++)
   100ec:	fec42783          	lw	a5,-20(s0)
   100f0:	00178793          	addi	a5,a5,1
   100f4:	fef42623          	sw	a5,-20(s0)
   100f8:	fec42703          	lw	a4,-20(s0)
   100fc:	00500793          	li	a5,5
   10100:	fce7d2e3          	bge	a5,a4,100c4 <main+0x70>
    }
    for (int j = 0; j < 6 - 1; j++)
   10104:	fe042423          	sw	zero,-24(s0)
   10108:	2240006f          	j	1032c <main+0x2d8>
    {
        for (int i = 0; i < 6 - 1 - j; i++)
   1010c:	fe042223          	sw	zero,-28(s0)
   10110:	1fc0006f          	j	1030c <main+0x2b8>
        {
            if (a[i] > a[i + 1])
   10114:	fe442783          	lw	a5,-28(s0)
   10118:	00279793          	slli	a5,a5,0x2
   1011c:	ff040713          	addi	a4,s0,-16
   10120:	00f707b3          	add	a5,a4,a5
   10124:	fd07a703          	lw	a4,-48(a5)
   10128:	fe442783          	lw	a5,-28(s0)
   1012c:	00178793          	addi	a5,a5,1
   10130:	00279793          	slli	a5,a5,0x2
   10134:	ff040693          	addi	a3,s0,-16
   10138:	00f687b3          	add	a5,a3,a5
   1013c:	fd07a783          	lw	a5,-48(a5)
   10140:	1ce7d063          	bge	a5,a4,10300 <main+0x2ac>
            {
                temp = a[i];
   10144:	fe442783          	lw	a5,-28(s0)
   10148:	00279793          	slli	a5,a5,0x2
   1014c:	ff040713          	addi	a4,s0,-16
   10150:	00f707b3          	add	a5,a4,a5
   10154:	fd07a783          	lw	a5,-48(a5)
   10158:	fcf42c23          	sw	a5,-40(s0)
                a[i] = a[i + 1];
   1015c:	fe442783          	lw	a5,-28(s0)
   10160:	00178793          	addi	a5,a5,1
   10164:	00279793          	slli	a5,a5,0x2
   10168:	ff040713          	addi	a4,s0,-16
   1016c:	00f707b3          	add	a5,a4,a5
   10170:	fd07a703          	lw	a4,-48(a5)
   10174:	fe442783          	lw	a5,-28(s0)
   10178:	00279793          	slli	a5,a5,0x2
   1017c:	ff040693          	addi	a3,s0,-16
   10180:	00f687b3          	add	a5,a3,a5
   10184:	fce7a823          	sw	a4,-48(a5)
                a[i + 1] = temp;
   10188:	fe442783          	lw	a5,-28(s0)
   1018c:	00178793          	addi	a5,a5,1
   10190:	00279793          	slli	a5,a5,0x2
   10194:	ff040713          	addi	a4,s0,-16
   10198:	00f707b3          	add	a5,a4,a5
   1019c:	fd842703          	lw	a4,-40(s0)
   101a0:	fce7a823          	sw	a4,-48(a5)
                for (int k = 0; k < 6; k++)
   101a4:	fe042023          	sw	zero,-32(s0)
   101a8:	1480006f          	j	102f0 <main+0x29c>
                {
                    for (int k2 = 0; k2 < 10; k2++)
   101ac:	fc042e23          	sw	zero,-36(s0)
   101b0:	1280006f          	j	102d8 <main+0x284>
                    {
                        if (a[k] <= k2)
   101b4:	fe042783          	lw	a5,-32(s0)
   101b8:	00279793          	slli	a5,a5,0x2
   101bc:	ff040713          	addi	a4,s0,-16
   101c0:	00f707b3          	add	a5,a4,a5
   101c4:	fd07a783          	lw	a5,-48(a5)
   101c8:	fdc42703          	lw	a4,-36(s0)
   101cc:	08f74263          	blt	a4,a5,10250 <main+0x1fc>
                        {
                            hdmi_block(k2 * 10 + 10, k * 10 + 10, k2 * 10 + 19, k * 10 + 19, RED);
   101d0:	fdc42783          	lw	a5,-36(s0)
   101d4:	00178713          	addi	a4,a5,1
   101d8:	00070793          	mv	a5,a4
   101dc:	00279793          	slli	a5,a5,0x2
   101e0:	00e787b3          	add	a5,a5,a4
   101e4:	00179793          	slli	a5,a5,0x1
   101e8:	00078513          	mv	a0,a5
   101ec:	fe042783          	lw	a5,-32(s0)
   101f0:	00178713          	addi	a4,a5,1
   101f4:	00070793          	mv	a5,a4
   101f8:	00279793          	slli	a5,a5,0x2
   101fc:	00e787b3          	add	a5,a5,a4
   10200:	00179793          	slli	a5,a5,0x1
   10204:	00078593          	mv	a1,a5
   10208:	fdc42703          	lw	a4,-36(s0)
   1020c:	00070793          	mv	a5,a4
   10210:	00279793          	slli	a5,a5,0x2
   10214:	00e787b3          	add	a5,a5,a4
   10218:	00179793          	slli	a5,a5,0x1
   1021c:	01378793          	addi	a5,a5,19
   10220:	00078613          	mv	a2,a5
   10224:	fe042703          	lw	a4,-32(s0)
   10228:	00070793          	mv	a5,a4
   1022c:	00279793          	slli	a5,a5,0x2
   10230:	00e787b3          	add	a5,a5,a4
   10234:	00179793          	slli	a5,a5,0x1
   10238:	01378793          	addi	a5,a5,19
   1023c:	00078693          	mv	a3,a5
   10240:	000107b7          	lui	a5,0x10
   10244:	80078713          	addi	a4,a5,-2048 # f800 <main-0x854>
   10248:	210000ef          	jal	ra,10458 <hdmi_block>
   1024c:	0800006f          	j	102cc <main+0x278>
                        }
                        else
                        {
                            hdmi_block(k2 * 10 + 10, k * 10 + 10, k2 * 10 + 19, k * 10 + 19, CYAN);
   10250:	fdc42783          	lw	a5,-36(s0)
   10254:	00178713          	addi	a4,a5,1
   10258:	00070793          	mv	a5,a4
   1025c:	00279793          	slli	a5,a5,0x2
   10260:	00e787b3          	add	a5,a5,a4
   10264:	00179793          	slli	a5,a5,0x1
   10268:	00078513          	mv	a0,a5
   1026c:	fe042783          	lw	a5,-32(s0)
   10270:	00178713          	addi	a4,a5,1
   10274:	00070793          	mv	a5,a4
   10278:	00279793          	slli	a5,a5,0x2
   1027c:	00e787b3          	add	a5,a5,a4
   10280:	00179793          	slli	a5,a5,0x1
   10284:	00078593          	mv	a1,a5
   10288:	fdc42703          	lw	a4,-36(s0)
   1028c:	00070793          	mv	a5,a4
   10290:	00279793          	slli	a5,a5,0x2
   10294:	00e787b3          	add	a5,a5,a4
   10298:	00179793          	slli	a5,a5,0x1
   1029c:	01378793          	addi	a5,a5,19
   102a0:	00078613          	mv	a2,a5
   102a4:	fe042703          	lw	a4,-32(s0)
   102a8:	00070793          	mv	a5,a4
   102ac:	00279793          	slli	a5,a5,0x2
   102b0:	00e787b3          	add	a5,a5,a4
   102b4:	00179793          	slli	a5,a5,0x1
   102b8:	01378793          	addi	a5,a5,19
   102bc:	00078693          	mv	a3,a5
   102c0:	000087b7          	lui	a5,0x8
   102c4:	fff78713          	addi	a4,a5,-1 # 7fff <main-0x8055>
   102c8:	190000ef          	jal	ra,10458 <hdmi_block>
                    for (int k2 = 0; k2 < 10; k2++)
   102cc:	fdc42783          	lw	a5,-36(s0)
   102d0:	00178793          	addi	a5,a5,1
   102d4:	fcf42e23          	sw	a5,-36(s0)
   102d8:	fdc42703          	lw	a4,-36(s0)
   102dc:	00900793          	li	a5,9
   102e0:	ece7dae3          	bge	a5,a4,101b4 <main+0x160>
                for (int k = 0; k < 6; k++)
   102e4:	fe042783          	lw	a5,-32(s0)
   102e8:	00178793          	addi	a5,a5,1
   102ec:	fef42023          	sw	a5,-32(s0)
   102f0:	fe042703          	lw	a4,-32(s0)
   102f4:	00500793          	li	a5,5
   102f8:	eae7dae3          	bge	a5,a4,101ac <main+0x158>
                        }
                    }
                }
                delay();
   102fc:	054000ef          	jal	ra,10350 <delay>
        for (int i = 0; i < 6 - 1 - j; i++)
   10300:	fe442783          	lw	a5,-28(s0)
   10304:	00178793          	addi	a5,a5,1
   10308:	fef42223          	sw	a5,-28(s0)
   1030c:	00500713          	li	a4,5
   10310:	fe842783          	lw	a5,-24(s0)
   10314:	40f707b3          	sub	a5,a4,a5
   10318:	fe442703          	lw	a4,-28(s0)
   1031c:	def74ce3          	blt	a4,a5,10114 <main+0xc0>
    for (int j = 0; j < 6 - 1; j++)
   10320:	fe842783          	lw	a5,-24(s0)
   10324:	00178793          	addi	a5,a5,1
   10328:	fef42423          	sw	a5,-24(s0)
   1032c:	fe842703          	lw	a4,-24(s0)
   10330:	00400793          	li	a5,4
   10334:	dce7dce3          	bge	a5,a4,1010c <main+0xb8>
            }
        }
    }
    return 0;
   10338:	00000793          	li	a5,0
}
   1033c:	00078513          	mv	a0,a5
   10340:	05c12083          	lw	ra,92(sp)
   10344:	05812403          	lw	s0,88(sp)
   10348:	06010113          	addi	sp,sp,96
   1034c:	00008067          	ret

00010350 <delay>:

void delay()
{
   10350:	fe010113          	addi	sp,sp,-32
   10354:	00812e23          	sw	s0,28(sp)
   10358:	02010413          	addi	s0,sp,32
    int i, j, k;
    for (i = 0; i < 5; i++)
   1035c:	fe042623          	sw	zero,-20(s0)
   10360:	0500006f          	j	103b0 <delay+0x60>
        for (j = 0; j < 1000; j++)
   10364:	fe042423          	sw	zero,-24(s0)
   10368:	0300006f          	j	10398 <delay+0x48>
            for (k = 0; k < 1000; k++)
   1036c:	fe042223          	sw	zero,-28(s0)
   10370:	0100006f          	j	10380 <delay+0x30>
   10374:	fe442783          	lw	a5,-28(s0)
   10378:	00178793          	addi	a5,a5,1
   1037c:	fef42223          	sw	a5,-28(s0)
   10380:	fe442703          	lw	a4,-28(s0)
   10384:	3e700793          	li	a5,999
   10388:	fee7d6e3          	bge	a5,a4,10374 <delay+0x24>
        for (j = 0; j < 1000; j++)
   1038c:	fe842783          	lw	a5,-24(s0)
   10390:	00178793          	addi	a5,a5,1
   10394:	fef42423          	sw	a5,-24(s0)
   10398:	fe842703          	lw	a4,-24(s0)
   1039c:	3e700793          	li	a5,999
   103a0:	fce7d6e3          	bge	a5,a4,1036c <delay+0x1c>
    for (i = 0; i < 5; i++)
   103a4:	fec42783          	lw	a5,-20(s0)
   103a8:	00178793          	addi	a5,a5,1
   103ac:	fef42623          	sw	a5,-20(s0)
   103b0:	fec42703          	lw	a4,-20(s0)
   103b4:	00400793          	li	a5,4
   103b8:	fae7d6e3          	bge	a5,a4,10364 <delay+0x14>
                ;
}
   103bc:	00000013          	nop
   103c0:	01c12403          	lw	s0,28(sp)
   103c4:	02010113          	addi	sp,sp,32
   103c8:	00008067          	ret

000103cc <hdmi_clean>:

void hdmi_clean(uint32_t color)
{
   103cc:	fd010113          	addi	sp,sp,-48
   103d0:	02812623          	sw	s0,44(sp)
   103d4:	03010413          	addi	s0,sp,48
   103d8:	fca42e23          	sw	a0,-36(s0)
    int i, j;
    uint32_t *hdmi_addr = HDMI0_Base;
   103dc:	010007b7          	lui	a5,0x1000
   103e0:	fef42223          	sw	a5,-28(s0)
    for (i = 0; i < 90; i++)
   103e4:	fe042623          	sw	zero,-20(s0)
   103e8:	0540006f          	j	1043c <hdmi_clean+0x70>
    {
        for (j = 0; j < 160; j++)
   103ec:	fe042423          	sw	zero,-24(s0)
   103f0:	0340006f          	j	10424 <hdmi_clean+0x58>
        {
            hdmi_addr[i * 256 + j] = (uint32_t)color;
   103f4:	fec42783          	lw	a5,-20(s0)
   103f8:	00879713          	slli	a4,a5,0x8
   103fc:	fe842783          	lw	a5,-24(s0)
   10400:	00f707b3          	add	a5,a4,a5
   10404:	00279793          	slli	a5,a5,0x2
   10408:	fe442703          	lw	a4,-28(s0)
   1040c:	00f707b3          	add	a5,a4,a5
   10410:	fdc42703          	lw	a4,-36(s0)
   10414:	00e7a023          	sw	a4,0(a5) # 1000000 <__global_pointer$+0xfee2ec>
        for (j = 0; j < 160; j++)
   10418:	fe842783          	lw	a5,-24(s0)
   1041c:	00178793          	addi	a5,a5,1
   10420:	fef42423          	sw	a5,-24(s0)
   10424:	fe842703          	lw	a4,-24(s0)
   10428:	09f00793          	li	a5,159
   1042c:	fce7d4e3          	bge	a5,a4,103f4 <hdmi_clean+0x28>
    for (i = 0; i < 90; i++)
   10430:	fec42783          	lw	a5,-20(s0)
   10434:	00178793          	addi	a5,a5,1
   10438:	fef42623          	sw	a5,-20(s0)
   1043c:	fec42703          	lw	a4,-20(s0)
   10440:	05900793          	li	a5,89
   10444:	fae7d4e3          	bge	a5,a4,103ec <hdmi_clean+0x20>
        }
    }
}
   10448:	00000013          	nop
   1044c:	02c12403          	lw	s0,44(sp)
   10450:	03010113          	addi	sp,sp,48
   10454:	00008067          	ret

00010458 <hdmi_block>:

void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color)
{
   10458:	fc010113          	addi	sp,sp,-64
   1045c:	02812e23          	sw	s0,60(sp)
   10460:	04010413          	addi	s0,sp,64
   10464:	fca42e23          	sw	a0,-36(s0)
   10468:	fcb42c23          	sw	a1,-40(s0)
   1046c:	fcc42a23          	sw	a2,-44(s0)
   10470:	fcd42823          	sw	a3,-48(s0)
   10474:	fce42623          	sw	a4,-52(s0)
    uint32_t *hdmi_addr = HDMI0_Base;
   10478:	010007b7          	lui	a5,0x1000
   1047c:	fef42223          	sw	a5,-28(s0)
    for (uint32_t i = x; i < x1; i++)
   10480:	fdc42783          	lw	a5,-36(s0)
   10484:	fef42623          	sw	a5,-20(s0)
   10488:	0580006f          	j	104e0 <hdmi_block+0x88>
        for (uint32_t j = y; j < y1; j++)
   1048c:	fd842783          	lw	a5,-40(s0)
   10490:	fef42423          	sw	a5,-24(s0)
   10494:	0340006f          	j	104c8 <hdmi_block+0x70>
            hdmi_addr[i * 256 + j] = (uint32_t)color;
   10498:	fec42783          	lw	a5,-20(s0)
   1049c:	00879713          	slli	a4,a5,0x8
   104a0:	fe842783          	lw	a5,-24(s0)
   104a4:	00f707b3          	add	a5,a4,a5
   104a8:	00279793          	slli	a5,a5,0x2
   104ac:	fe442703          	lw	a4,-28(s0)
   104b0:	00f707b3          	add	a5,a4,a5
   104b4:	fcc42703          	lw	a4,-52(s0)
   104b8:	00e7a023          	sw	a4,0(a5) # 1000000 <__global_pointer$+0xfee2ec>
        for (uint32_t j = y; j < y1; j++)
   104bc:	fe842783          	lw	a5,-24(s0)
   104c0:	00178793          	addi	a5,a5,1
   104c4:	fef42423          	sw	a5,-24(s0)
   104c8:	fe842703          	lw	a4,-24(s0)
   104cc:	fd042783          	lw	a5,-48(s0)
   104d0:	fcf764e3          	bltu	a4,a5,10498 <hdmi_block+0x40>
    for (uint32_t i = x; i < x1; i++)
   104d4:	fec42783          	lw	a5,-20(s0)
   104d8:	00178793          	addi	a5,a5,1
   104dc:	fef42623          	sw	a5,-20(s0)
   104e0:	fec42703          	lw	a4,-20(s0)
   104e4:	fd442783          	lw	a5,-44(s0)
   104e8:	faf762e3          	bltu	a4,a5,1048c <hdmi_block+0x34>
}
   104ec:	00000013          	nop
   104f0:	03c12403          	lw	s0,60(sp)
   104f4:	04010113          	addi	sp,sp,64
   104f8:	00008067          	ret
