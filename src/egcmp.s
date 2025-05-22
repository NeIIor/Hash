section .text
global egcmp

egcmp:
    vmovups ymm0, yword [rdi]
    vmovups ymm1, yword [rsi]

    vpcmpeqb ymm0, ymm0, ymm1
    vpmovmskb eax, ymm0
    not eax
    ret