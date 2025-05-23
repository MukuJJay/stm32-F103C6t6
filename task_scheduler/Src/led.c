
#include<stdint.h>
#include "led.h"



void delay(uint32_t count)
{
  for(uint32_t i = 0 ; i < count ; i++);
}

void led_init_all(void)
{

	uint32_t *pRccApb2enr = (uint32_t*)0x40021018;
	uint32_t *pGpioBMode = (uint32_t*)0x40010800;

	*pRccApb2enr |= ( 1 << 2);

	*pGpioBMode &= ~(0xF << 4 * LED1);
	*pGpioBMode |= ( 0x1 << (4 * LED1));

	*pGpioBMode &= ~(0xF << 4 * LED2);
	*pGpioBMode |= ( 0x1 << (4 * LED2));

	*pGpioBMode &= ~(0xF << 4 * LED3);
	*pGpioBMode |= ( 0x1 << (4 * LED3));

	*pGpioBMode &= ~(0xF << 4 * LED4);
	*pGpioBMode |= ( 0x1 << (4 * LED4));


	uint32_t *pGpioB_odr = (uint32_t*) 0x4001080C;
	*pGpioB_odr &= ~((1 << LED1) | (1 << LED2) | (1 << LED3) | (1 << LED4));


}

void led_on(uint8_t led_no)
{
  uint32_t *pGpioB_BSRR = (uint32_t*)0x40010810;
  *pGpioB_BSRR |= ( 1 << led_no);

}

void led_off(uint8_t led_no)
{
	uint32_t *pGpioB_BSRR = (uint32_t*)0x40010810;
	*pGpioB_BSRR |= ( 1 << (16 + led_no));
}

