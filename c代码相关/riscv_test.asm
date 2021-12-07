
riscv_test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010054 <main>:
int main()
{
   10054:	ff410113          	addi	sp,sp,-12
   10058:	00812423          	sw	s0,8(sp)
   1005c:	00c10413          	addi	s0,sp,12
    int i=0,ans=0;
   10060:	fe042c23          	sw	zero,-8(s0)
   10064:	fe042a23          	sw	zero,-12(s0)
    for(i=0;i<10;i++)
   10068:	fe042c23          	sw	zero,-8(s0)
   1006c:	0200006f          	j	1008c <main+0x38>
        ans+=i;
   10070:	ff442703          	lw	a4,-12(s0)
   10074:	ff842783          	lw	a5,-8(s0)
   10078:	00f707b3          	add	a5,a4,a5
   1007c:	fef42a23          	sw	a5,-12(s0)
    for(i=0;i<10;i++)
   10080:	ff842783          	lw	a5,-8(s0)
   10084:	00178793          	r	a5,a5,1
   10088:	fef42c23          	sw	a5,-8(s0)
   1008c:	ff842703          	lw	a4,-8(s0)
   10090:	00900793          	li	a5,9
   10094:	fce7dee3          	bge	a5,a4,10070 <main+0x1c>
    return 0;
   10098:	00000793          	li	a5,0
   1009c:	00078513          	mv	a0,a5
   100a0:	00812403          	lw	s0,8(sp)
   100a4:	00c10113          	addi	sp,sp,12
   100a8:	00008067          	ret
