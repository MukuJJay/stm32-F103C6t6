#include <stdint.h>

/* SRAM Configuration (STM32F4‑series has 96 KiB total SRAM1) */
#define SRAM_START  0x20000000U
#define SRAM_SIZE   (64U * 1024U)
#define SRAM_END    (SRAM_START + SRAM_SIZE)

#define STACK_START SRAM_END

int main(void);
/* Cortex‑M4 core handlers */
void     Reset_Handler           (void);
void     NMI_Handler             (void) __attribute__((weak, alias("Default_Handler")));
void     HardFault_Handler       (void) __attribute__((weak, alias("Default_Handler")));
void     MemManage_Handler       (void) __attribute__((weak, alias("Default_Handler")));
void     BusFault_Handler        (void) __attribute__((weak, alias("Default_Handler")));
void     UsageFault_Handler      (void) __attribute__((weak, alias("Default_Handler")));
void     SVCall_Handler          (void) __attribute__((weak, alias("Default_Handler")));
void     DebugMonitor_Handler    (void) __attribute__((weak, alias("Default_Handler")));
void     PendSV_Handler          (void) __attribute__((weak, alias("Default_Handler")));
void     SysTick_Handler         (void) __attribute__((weak, alias("Default_Handler")));

/* STM32F401‑specific IRQ handlers */
void     WWDG_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     PVD_IRQHandler                 (void) __attribute__((weak, alias("Default_Handler")));              // EXTI16/PVD
void     TAMP_STAMP_IRQHandler          (void) __attribute__((weak, alias("Default_Handler")));              // EXTI21/TAMP_STAMP
void     RTC_WKUP_IRQHandler            (void) __attribute__((weak, alias("Default_Handler")));              // EXTI22/RTC_WKUP
void     FLASH_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     RCC_IRQHandler                 (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI0_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI1_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI2_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI3_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI4_IRQHandler               (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream0_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream1_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream2_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream3_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream4_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream5_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream6_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     ADC_IRQHandler                 (void) __attribute__((weak, alias("Default_Handler")));              // ADC1 global
void     EXTI9_5_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     TIM1_BRK_TIM9_IRQHandler       (void) __attribute__((weak, alias("Default_Handler")));
void     TIM1_UP_TIM10_IRQHandler       (void) __attribute__((weak, alias("Default_Handler")));
void     TIM1_TRG_COM_TIM11_IRQHandler  (void) __attribute__((weak, alias("Default_Handler")));
void     TIM1_CC_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     TIM2_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     TIM3_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     TIM4_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     I2C1_EV_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     I2C1_ER_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     I2C2_EV_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     I2C2_ER_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     SPI1_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     SPI2_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     USART1_IRQHandler              (void) __attribute__((weak, alias("Default_Handler")));
void     USART2_IRQHandler              (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI15_10_IRQHandler           (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI17_RTC_Alarm_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
void     EXTI18_OTG_FS_WKUP_IRQHandler  (void) __attribute__((weak, alias("Default_Handler")));
void     DMA1_Stream7_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     SDIO_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     TIM5_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     SPI3_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream0_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream1_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream2_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream3_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream4_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     OTG_FS_IRQHandler              (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream5_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream6_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     DMA2_Stream7_IRQHandler        (void) __attribute__((weak, alias("Default_Handler")));
void     USART6_IRQHandler              (void) __attribute__((weak, alias("Default_Handler")));
void     I2C3_EV_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     I2C3_ER_IRQHandler             (void) __attribute__((weak, alias("Default_Handler")));
void     FPU_IRQHandler                 (void) __attribute__((weak, alias("Default_Handler")));
void     SPI4_IRQHandler                (void) __attribute__((weak, alias("Default_Handler")));

extern uint32_t _etxt;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _sbss;
extern uint32_t _ebss;

/* Default infinite‑loop exception */
void Default_Handler(void)
{
    while (1) { }
}

/* Reset handler stub */
void Reset_Handler(void)
{
    //copy .data from flash to sram
    uint32_t size = &_edata - &_sdata;

    uint8_t* pSrc = (uint8_t*) &_etxt;
    uint8_t* pDst = (uint8_t*) &_sdata;

    for(int i = 0 ; i < size; i++){
        *pDst++ = *pSrc++;
    }

    //initializing the bss section
    size = &_ebss - &_sbss;
    pDst = (uint8_t*) &_sbss;
    for(int i = 0 ; i < size; i++){
        *pDst++ = 0;
    }

   main(); //calling the main function
}

/* The full vector table, in the exact order of RM0368 “Table 38” */

uint32_t vectors[] __attribute__((section(".isr_vector")))= {
    STACK_START,                             //  0: Initial SP value
    (uint32_t)Reset_Handler,                 //  1: Reset
    (uint32_t)NMI_Handler,                   //  2: NMI
    (uint32_t)HardFault_Handler,             //  3: HardFault
    (uint32_t)MemManage_Handler,             //  4: MemManage
    (uint32_t)BusFault_Handler,              //  5: BusFault
    (uint32_t)UsageFault_Handler,            //  6: UsageFault
    0, 0, 0, 0,                              //  7–10: Reserved
    (uint32_t)SVCall_Handler,                // 11: SVCall
    (uint32_t)DebugMonitor_Handler,          // 12: Debug Monitor
    0,                                       // 13: Reserved
    (uint32_t)PendSV_Handler,                // 14: PendSV
    (uint32_t)SysTick_Handler,               // 15: SysTick

    /* IRQs 0…91 */
    (uint32_t)WWDG_IRQHandler,               //  0: Window Watchdog
    (uint32_t)PVD_IRQHandler,                //  1: EXTI16/PVD
    (uint32_t)TAMP_STAMP_IRQHandler,         //  2: EXTI21/TAMP_STAMP
    (uint32_t)RTC_WKUP_IRQHandler,           //  3: EXTI22/RTC_WKUP
    (uint32_t)FLASH_IRQHandler,              //  4: Flash
    (uint32_t)RCC_IRQHandler,                //  5: RCC
    (uint32_t)EXTI0_IRQHandler,              //  6: EXTI0
    (uint32_t)EXTI1_IRQHandler,              //  7: EXTI1
    (uint32_t)EXTI2_IRQHandler,              //  8: EXTI2
    (uint32_t)EXTI3_IRQHandler,              //  9: EXTI3
    (uint32_t)EXTI4_IRQHandler,              // 10: EXTI4
    (uint32_t)DMA1_Stream0_IRQHandler,       // 11: DMA1 Stream 0
    (uint32_t)DMA1_Stream1_IRQHandler,       // 12: DMA1 Stream 1
    (uint32_t)DMA1_Stream2_IRQHandler,       // 13: DMA1 Stream 2
    (uint32_t)DMA1_Stream3_IRQHandler,       // 14: DMA1 Stream 3
    (uint32_t)DMA1_Stream4_IRQHandler,       // 15: DMA1 Stream 4
    (uint32_t)DMA1_Stream5_IRQHandler,       // 16: DMA1 Stream 5
    (uint32_t)DMA1_Stream6_IRQHandler,       // 17: DMA1 Stream 6
    (uint32_t)ADC_IRQHandler,                // 18: ADC1 global
    (uint32_t)EXTI9_5_IRQHandler,            // 19: EXTI [9:5]
    (uint32_t)TIM1_BRK_TIM9_IRQHandler,      // 20: TIM1_BRK/TIM9
    (uint32_t)TIM1_UP_TIM10_IRQHandler,      // 21: TIM1_UP/TIM10
    (uint32_t)TIM1_TRG_COM_TIM11_IRQHandler, // 22: TIM1_TRG_COM/TIM11
    (uint32_t)TIM1_CC_IRQHandler,            // 23: TIM1_CC
    (uint32_t)TIM2_IRQHandler,               // 24: TIM2
    (uint32_t)TIM3_IRQHandler,               // 25: TIM3
    (uint32_t)TIM4_IRQHandler,               // 26: TIM4
    (uint32_t)I2C1_EV_IRQHandler,            // 27: I2C1 event
    (uint32_t)I2C1_ER_IRQHandler,            // 28: I2C1 error
    (uint32_t)I2C2_EV_IRQHandler,            // 29: I2C2 event
    (uint32_t)I2C2_ER_IRQHandler,            // 30: I2C2 error
    (uint32_t)SPI1_IRQHandler,               // 31: SPI1
    (uint32_t)SPI2_IRQHandler,               // 32: SPI2
    (uint32_t)USART1_IRQHandler,             // 33: USART1
    (uint32_t)USART2_IRQHandler,             // 34: USART2
    (uint32_t)EXTI15_10_IRQHandler,          // 35: EXTI[15:10]
    (uint32_t)EXTI17_RTC_Alarm_IRQHandler,   // 36: EXTI17/RTC Alarm
    (uint32_t)EXTI18_OTG_FS_WKUP_IRQHandler, // 37: EXTI18/OTG‑FS Wakeup
    (uint32_t)DMA1_Stream7_IRQHandler,       // 38: DMA1 Stream 7
    (uint32_t)SDIO_IRQHandler,               // 39: SDIO
    (uint32_t)TIM5_IRQHandler,               // 40: TIM5
    (uint32_t)SPI3_IRQHandler,               // 41: SPI3
    (uint32_t)DMA2_Stream0_IRQHandler,       // 42: DMA2 Stream 0
    (uint32_t)DMA2_Stream1_IRQHandler,       // 43: DMA2 Stream 1
    (uint32_t)DMA2_Stream2_IRQHandler,       // 44: DMA2 Stream 2
    (uint32_t)DMA2_Stream3_IRQHandler,       // 45: DMA2 Stream 3
    (uint32_t)DMA2_Stream4_IRQHandler,       // 46: DMA2 Stream 4
    (uint32_t)OTG_FS_IRQHandler,             // 47: OTG‑FS global
    (uint32_t)DMA2_Stream5_IRQHandler,       // 48: DMA2 Stream 5
    (uint32_t)DMA2_Stream6_IRQHandler,       // 49: DMA2 Stream 6
    (uint32_t)DMA2_Stream7_IRQHandler,       // 50: DMA2 Stream 7
    (uint32_t)USART6_IRQHandler,             // 51: USART6
    (uint32_t)I2C3_EV_IRQHandler,            // 52: I2C3 event
    (uint32_t)I2C3_ER_IRQHandler,            // 53: I2C3 error
    (uint32_t)FPU_IRQHandler,                // 54: FPU
    (uint32_t)SPI4_IRQHandler                // 55: SPI4
    /* end of table — unused entries can be left out or padded to NVIC_NUM_VECTORS */
};
