#include <stdint.h>
#include <stdio.h>
#include "main.h"
#include "led.h"

void idle_task(void);
void task1_handler(void);
void task2_handler(void);
void task3_handler(void);
void task4_handler(void);

void systick_timer_init(uint32_t tick_hz);
__attribute__((naked)) void sched_stack_init(uint32_t top_of_stack_memory);
void task_stacks_init(void);
uint32_t get_psp_value(void);
__attribute__((naked)) void sp_to_psp(void);
void save_psp_value (uint32_t current_psp_value);
void update_next_task(void);

void enable_processor_faults(void);

void task_delay(uint32_t tick_count);
void update_global_tick_count(void);
void unblock_tasks();
void schedule(void);




uint32_t currentTask = 1;
uint32_t g_tick_count = 0;

typedef struct{
	uint32_t psp_value;
	volatile uint32_t block_count;
	volatile uint8_t state;
	void (*task_handler)(void);
}TCB_t;

volatile TCB_t userTasks[MAX_TASKS];

int main(void)
{
	enable_processor_faults();

	printf("This is an implementation of task scheduler.\n");

	sched_stack_init(SCHED_STACK_START);

	task_stacks_init();

	led_init_all();

	systick_timer_init(TICK_HZ);

	sp_to_psp();

	task1_handler();
//	schedule();
    /* Loop forever */
	for(;;);
}


void idle_task(void)
{
	while(1);
}

void task1_handler(void){
	while(1){
		led_on(LED1);
		task_delay(1000);
		led_off(LED1);
		task_delay(1000);
	}
}

void task2_handler(void){
	while(1){
		led_on(LED2);
		task_delay(500);
		led_off(LED2);
		task_delay(500);
	}
}

void task3_handler(void){
	while(1){
		led_on(LED3);
		task_delay(250);
		led_off(LED3);
		task_delay(250);
	}
}

void task4_handler(void){
	while(1){
		led_on(LED4);
		task_delay(125);
		led_off(LED4);
		task_delay(125);
	}
}

void enable_processor_faults(void)
{
	uint32_t *pSHCSR = (uint32_t*)0xE000ED24;

	*pSHCSR |= ( 1 << 16); //mem manage
	*pSHCSR |= ( 1 << 17); //bus fault
	*pSHCSR |= ( 1 << 18); //usage fault
}

void systick_timer_init(uint32_t tick_hz){
	uint32_t* pSYST_CSR= (uint32_t*) 0xE000E010;
	uint32_t* pSYST_RVR = (uint32_t*) 0xE000E014;

	uint32_t count = (SYSTICK_TIM_CLK / tick_hz) - 1;

	*pSYST_RVR &= ~(0x00FFFFFF); // clearing 0 to 23 bits
	*pSYST_RVR |= count; //load the count value

	*pSYST_CSR |= (1 << 1); // enabling SysTick exception request
	*pSYST_CSR |= (1 << 2); // using processor internal clock
	*pSYST_CSR |= (1 << 0); // enabling the counter

}

__attribute__((naked)) void sched_stack_init(uint32_t top_of_stack_memory){
	__asm volatile ("MSR MSP, R0");
	__asm volatile ("BX LR");
}

void task_stacks_init(void){

	for(uint8_t i = 0; i < MAX_TASKS; i++){
		userTasks[i].state = TASK_READY_STATE;
	}

	userTasks[0].psp_value = IDLE_STACK_START;
	userTasks[1].psp_value = T1_STACK_START;
	userTasks[2].psp_value = T2_STACK_START;
	userTasks[3].psp_value = T3_STACK_START;
	userTasks[4].psp_value = T4_STACK_START;

	userTasks[0].task_handler = idle_task;
	userTasks[1].task_handler = task1_handler;
	userTasks[2].task_handler = task2_handler;
	userTasks[3].task_handler = task3_handler;
	userTasks[4].task_handler = task4_handler;

	uint32_t *psp;

	for(int i = 0; i < MAX_TASKS; i++){
		psp = (uint32_t*) userTasks[i].psp_value;

		psp--; //XPSR
		*psp = DUMMY_XPSR;

		psp--; //PC
		*psp = (uint32_t) userTasks[i].task_handler;

		psp--; //LR
		*psp = 0xFFFFFFFD;

		for(int j = 0; j < 13; j++){
			psp--;
			*psp = 0;
		}

		userTasks[i].psp_value = (uint32_t)psp;
	}
}

__attribute__((naked)) void sp_to_psp(void){
	//getting the psp value
	__asm volatile ("PUSH {LR}");
	__asm volatile ("BL get_psp_value");
	__asm volatile ("MSR PSP, R0");
	__asm volatile ("POP {LR}");

	//switching to psp
	__asm volatile ("MRS R0, CONTROL");
	__asm volatile ("ORR R0, R0, #2");
	__asm volatile ("MSR CONTROL, R0");

	__asm volatile ("BX LR");

}

uint32_t get_psp_value(void){
	return userTasks[currentTask].psp_value;
}

void save_psp_value (uint32_t current_psp_value){
	userTasks[currentTask].psp_value = current_psp_value;
}

void update_next_task(void){
	int state = TASK_BLOCKED_STATE;

	for(int i = 0; i < MAX_TASKS; i++){
		currentTask++;
		currentTask %= MAX_TASKS;
		state = userTasks[currentTask].state;
		if((state == TASK_READY_STATE) && (currentTask != 0)){
			break;
		}
	}

	if(state != TASK_READY_STATE){
		currentTask = 0;
	}
}

__attribute__((naked)) void PendSV_Handler(void){
	//storing the current task context
	__asm volatile ("MRS R0, PSP");
	__asm volatile ("STMDB R0!, {R4-R11}");
	__asm volatile ("PUSH {LR}");
	__asm volatile ("BL save_psp_value");

	//switching to the next task
	__asm volatile ("BL update_next_task");
	__asm volatile ("BL get_psp_value");
	__asm volatile ("LDMIA R0!, {R4-R11}");
	__asm volatile ("MSR PSP, R0");
	__asm volatile ("POP {LR}");
	__asm volatile ("BX LR");
}


void schedule(void){
	//pending the pendSV
	uint32_t* pICSR = (uint32_t*) 0xE000ED04;
	*pICSR |= (1 << 28);
}

void task_delay(uint32_t tick_count){
	INTERRUPT_DISABLE();

	if(currentTask){
		userTasks[currentTask].block_count = g_tick_count + tick_count;
		userTasks[currentTask].state = TASK_BLOCKED_STATE;
		schedule();
	}

	INTERRUPT_ENABLE();
}

void update_global_tick_count(void){
	g_tick_count++;
}

void unblock_tasks(void)
{
	for(int i = 1 ; i < MAX_TASKS ; i++)
	{
		if(userTasks[i].state != TASK_READY_STATE)
		{
			if(g_tick_count >= userTasks[i].block_count)
			{
				userTasks[i].state = TASK_READY_STATE;
			}
		}

	}

}


void SysTick_Handler(void){
	update_global_tick_count();
	unblock_tasks();
	//pending the pendSV
	uint32_t* pICSR = (uint32_t*) 0xE000ED04;
	*pICSR |= (1 << 28);
}


//2. implement the fault handlers
void HardFault_Handler(void)
{
	while(1);
}


void MemManage_Handler(void)
{
	while(1);
}

void BusFault_Handler(void)
{
	while(1);
}
