#include <cstdio>
#include <cstdint>

int main()
{
    FILE *ifp = NULL, *ofp = NULL;
    /* 读取riscvgcc编译生成的bin文件 */
    ifp = fopen("riscv_test.bin", "rb");
    if (ifp == NULL)
    {
        printf("load .bin file failed\n");
        return 0;
    }
    /* 创建coe文件 */
    ofp = fopen("riscv_test.coe", "w+");
    /* 添加coe文件头 */
    fprintf(ofp, "MEMORY_INITIALIZATION_RADIX=16;\nMEMORY_INITIALIZATION_VECTOR=\n");

    /* 获得文件长度 */
    fseek(ifp, 0L, SEEK_END);
    int fileLen = ftell(ifp) / 4;
    fseek(ifp, 0L, SEEK_SET);

    /* 读取bin文件的内容并写入coe文件 */
    uint32_t *riscvInst = NULL;
    size_t i = 0;
    while (i++ < fileLen)
    {
        fread(&riscvInst, sizeof(riscvInst), 1, ifp);
        printf("%08x\n", riscvInst);
        if (i == fileLen)
            fprintf(ofp, "%08x;\n", riscvInst);
        else
            fprintf(ofp, "%08x,\n", riscvInst);
    }
    /* 保存文件 */
    fclose(ofp);
    fclose(ifp);
    return 0;
}