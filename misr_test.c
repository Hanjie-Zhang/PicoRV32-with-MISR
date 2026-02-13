#include <stdint.h>
#define CSR_MISR_DATA 0xFC0
#define CSR_MISR_CTRL 0xFC1
#define ADDR_PUTC     0x10000000 
#define ADDR_EXIT     0x20000000 

void write_csr(uint32_t addr, uint32_t val) {
    if (addr == CSR_MISR_CTRL) {
        asm volatile ("csrw 0xFC1, %0" :: "r"(val));
    }
}

uint32_t read_csr(uint32_t addr) {
    uint32_t val;
    if (addr == CSR_MISR_DATA) {
        asm volatile ("csrr %0, 0xFC0" : "=r"(val));
    } else if (addr == CSR_MISR_CTRL) {
        asm volatile ("csrr %0, 0xFC1" : "=r"(val));
    }
    return val;
}

void main() {
    volatile uint32_t *exit_reg = (uint32_t*)ADDR_EXIT;

    volatile uint32_t a = 10;
    volatile uint32_t b = 20;
    volatile uint32_t c = 0;
    uint32_t sig1, sig2;

    write_csr(CSR_MISR_CTRL, 2);
    write_csr(CSR_MISR_CTRL, 1);

    c = a + b;   // 30
    c = c + a;   // 40
    c = c - b;   // 20
     
    sig1 = read_csr(CSR_MISR_DATA);
    write_csr(CSR_MISR_CTRL, 0);
    c = c + 1;
    sig2 = read_csr(CSR_MISR_DATA);
    *exit_reg = 123456789;
    asm volatile (".word 0xFFFFFFFF");
    while(1) {
        asm volatile ("nop");
    }
}
