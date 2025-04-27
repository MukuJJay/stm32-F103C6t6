#include<stdint.h>

int main(void){
	__asm("SVC #25");

	uint32_t data;
	__asm volatile("MOV %0,r0" : "=r"(data) :: "r0");

	for(;;);
}

__attribute__ ((naked)) void SVC_Handler(void){
	__asm("MRS R0, MSP");
	__asm("B SVC_Handler_c");
}

void SVC_Handler_c (uint32_t* pBaseStackFrame){
	uint8_t* pReturnAddress = (uint8_t*) pBaseStackFrame[6];

	pReturnAddress -= 2;

	uint8_t svc_number = *pReturnAddress;

	svc_number += 4;

	pBaseStackFrame[0] = svc_number;

}
