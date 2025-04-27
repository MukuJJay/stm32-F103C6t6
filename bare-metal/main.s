	.cpu cortex-m3
	.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.global	currentTask
	.bss
	.align	2
	.type	currentTask, %object
	.size	currentTask, 4
currentTask:
	.space	4
	.global	g_tick_count
	.align	2
	.type	g_tick_count, %object
	.size	g_tick_count, 4
g_tick_count:
	.space	4
	.global	userTasks
	.align	2
	.type	userTasks, %object
	.size	userTasks, 80
userTasks:
	.space	80
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	bl	enable_processor_faults
	ldr	r0, .L3
	bl	sched_stack_init
	bl	task_stacks_init
	bl	led_init_all
	mov	r0, #1000
	bl	systick_timer_init
	bl	sp_to_psp
	bl	schedule
.L2:
	b	.L2
.L4:
	.align	2
.L3:
	.word	536871936
	.size	main, .-main
	.align	1
	.global	idle_task
	.syntax unified
	.thumb
	.thumb_func
	.type	idle_task, %function
idle_task:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
.L6:
	b	.L6
	.size	idle_task, .-idle_task
	.align	1
	.global	task1_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task1_handler, %function
task1_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L8:
	movs	r0, #1
	bl	led_on
	mov	r0, #1000
	bl	task_delay
	movs	r0, #1
	bl	led_off
	mov	r0, #1000
	bl	task_delay
	b	.L8
	.size	task1_handler, .-task1_handler
	.align	1
	.global	task2_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task2_handler, %function
task2_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L10:
	movs	r0, #2
	bl	led_on
	mov	r0, #500
	bl	task_delay
	movs	r0, #2
	bl	led_off
	mov	r0, #500
	bl	task_delay
	b	.L10
	.size	task2_handler, .-task2_handler
	.align	1
	.global	task3_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task3_handler, %function
task3_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L12:
	movs	r0, #3
	bl	led_on
	movs	r0, #250
	bl	task_delay
	movs	r0, #3
	bl	led_off
	movs	r0, #250
	bl	task_delay
	b	.L12
	.size	task3_handler, .-task3_handler
	.align	1
	.global	task4_handler
	.syntax unified
	.thumb
	.thumb_func
	.type	task4_handler, %function
task4_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
.L14:
	movs	r0, #4
	bl	led_on
	movs	r0, #125
	bl	task_delay
	movs	r0, #4
	bl	led_off
	movs	r0, #125
	bl	task_delay
	b	.L14
	.size	task4_handler, .-task4_handler
	.align	1
	.global	enable_processor_faults
	.syntax unified
	.thumb
	.thumb_func
	.type	enable_processor_faults, %function
enable_processor_faults:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r3, .L16
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #65536
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #131072
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #262144
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L17:
	.align	2
.L16:
	.word	-536810204
	.size	enable_processor_faults, .-enable_processor_faults
	.align	1
	.global	systick_timer_init
	.syntax unified
	.thumb
	.thumb_func
	.type	systick_timer_init, %function
systick_timer_init:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #28
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, .L19
	str	r3, [r7, #20]
	ldr	r3, .L19+4
	str	r3, [r7, #16]
	ldr	r2, .L19+8
	ldr	r3, [r7, #4]
	udiv	r3, r2, r3
	subs	r3, r3, #1
	str	r3, [r7, #12]
	ldr	r3, [r7, #16]
	ldr	r3, [r3]
	and	r2, r3, #-16777216
	ldr	r3, [r7, #16]
	str	r2, [r3]
	ldr	r3, [r7, #16]
	ldr	r2, [r3]
	ldr	r3, [r7, #12]
	orrs	r2, r2, r3
	ldr	r3, [r7, #16]
	str	r2, [r3]
	ldr	r3, [r7, #20]
	ldr	r3, [r3]
	orr	r2, r3, #2
	ldr	r3, [r7, #20]
	str	r2, [r3]
	ldr	r3, [r7, #20]
	ldr	r3, [r3]
	orr	r2, r3, #4
	ldr	r3, [r7, #20]
	str	r2, [r3]
	ldr	r3, [r7, #20]
	ldr	r3, [r3]
	orr	r2, r3, #1
	ldr	r3, [r7, #20]
	str	r2, [r3]
	nop
	adds	r7, r7, #28
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L20:
	.align	2
.L19:
	.word	-536813552
	.word	-536813548
	.word	8000000
	.size	systick_timer_init, .-systick_timer_init
	.align	1
	.global	sched_stack_init
	.syntax unified
	.thumb
	.thumb_func
	.type	sched_stack_init, %function
sched_stack_init:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	.syntax unified
@ 128 "main.c" 1
	MSR MSP, R0
@ 0 "" 2
@ 129 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	sched_stack_init, .-sched_stack_init
	.align	1
	.global	task_stacks_init
	.syntax unified
	.thumb
	.thumb_func
	.type	task_stacks_init, %function
task_stacks_init:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	movs	r3, #0
	strb	r3, [r7, #15]
	b	.L23
.L24:
	ldrb	r3, [r7, #15]	@ zero_extendqisi2
	ldr	r2, .L29
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	movs	r2, #0
	strb	r2, [r3]
	ldrb	r3, [r7, #15]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [r7, #15]
.L23:
	ldrb	r3, [r7, #15]	@ zero_extendqisi2
	cmp	r3, #4
	bls	.L24
	ldr	r3, .L29
	ldr	r2, .L29+4
	str	r2, [r3]
	ldr	r3, .L29
	ldr	r2, .L29+8
	str	r2, [r3, #16]
	ldr	r3, .L29
	ldr	r2, .L29+12
	str	r2, [r3, #32]
	ldr	r3, .L29
	ldr	r2, .L29+16
	str	r2, [r3, #48]
	ldr	r3, .L29
	ldr	r2, .L29+20
	str	r2, [r3, #64]
	ldr	r3, .L29
	ldr	r2, .L29+24
	str	r2, [r3, #12]
	ldr	r3, .L29
	ldr	r2, .L29+28
	str	r2, [r3, #28]
	ldr	r3, .L29
	ldr	r2, .L29+32
	str	r2, [r3, #44]
	ldr	r3, .L29
	ldr	r2, .L29+36
	str	r2, [r3, #60]
	ldr	r3, .L29
	ldr	r2, .L29+40
	str	r2, [r3, #76]
	movs	r3, #0
	str	r3, [r7, #4]
	b	.L25
.L28:
	ldr	r2, .L29
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [r7, #8]
	ldr	r3, [r7, #8]
	subs	r3, r3, #4
	str	r3, [r7, #8]
	ldr	r3, [r7, #8]
	mov	r2, #16777216
	str	r2, [r3]
	ldr	r3, [r7, #8]
	subs	r3, r3, #4
	str	r3, [r7, #8]
	ldr	r2, .L29
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #12
	ldr	r3, [r3]
	mov	r2, r3
	ldr	r3, [r7, #8]
	str	r2, [r3]
	ldr	r3, [r7, #8]
	subs	r3, r3, #4
	str	r3, [r7, #8]
	ldr	r3, [r7, #8]
	mvn	r2, #2
	str	r2, [r3]
	movs	r3, #0
	str	r3, [r7]
	b	.L26
.L27:
	ldr	r3, [r7, #8]
	subs	r3, r3, #4
	str	r3, [r7, #8]
	ldr	r3, [r7, #8]
	movs	r2, #0
	str	r2, [r3]
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L26:
	ldr	r3, [r7]
	cmp	r3, #12
	ble	.L27
	ldr	r2, [r7, #8]
	ldr	r1, .L29
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r1
	str	r2, [r3]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L25:
	ldr	r3, [r7, #4]
	cmp	r3, #4
	ble	.L28
	nop
	nop
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L30:
	.align	2
.L29:
	.word	userTasks
	.word	536872960
	.word	536877056
	.word	536876032
	.word	536875008
	.word	536873984
	.word	idle_task
	.word	task1_handler
	.word	task2_handler
	.word	task3_handler
	.word	task4_handler
	.size	task_stacks_init, .-task_stacks_init
	.align	1
	.global	sp_to_psp
	.syntax unified
	.thumb
	.thumb_func
	.type	sp_to_psp, %function
sp_to_psp:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	.syntax unified
@ 175 "main.c" 1
	PUSH {LR}
@ 0 "" 2
@ 176 "main.c" 1
	BL get_psp_value
@ 0 "" 2
@ 177 "main.c" 1
	MSR PSP, R0
@ 0 "" 2
@ 178 "main.c" 1
	POP {LR}
@ 0 "" 2
@ 181 "main.c" 1
	MRS R0, CONTROL
@ 0 "" 2
@ 182 "main.c" 1
	ORR R0, R0, #2
@ 0 "" 2
@ 183 "main.c" 1
	MSR CONTROL, R0
@ 0 "" 2
@ 185 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	sp_to_psp, .-sp_to_psp
	.align	1
	.global	get_psp_value
	.syntax unified
	.thumb
	.thumb_func
	.type	get_psp_value, %function
get_psp_value:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
	ldr	r3, .L34
	ldr	r3, [r3]
	ldr	r2, .L34+4
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r3, [r3]
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L35:
	.align	2
.L34:
	.word	currentTask
	.word	userTasks
	.size	get_psp_value, .-get_psp_value
	.align	1
	.global	save_psp_value
	.syntax unified
	.thumb
	.thumb_func
	.type	save_psp_value, %function
save_psp_value:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, .L37
	ldr	r3, [r3]
	ldr	r2, .L37+4
	lsls	r3, r3, #4
	add	r3, r3, r2
	ldr	r2, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L38:
	.align	2
.L37:
	.word	currentTask
	.word	userTasks
	.size	save_psp_value, .-save_psp_value
	.align	1
	.global	update_next_task
	.syntax unified
	.thumb
	.thumb_func
	.type	update_next_task, %function
update_next_task:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	movs	r3, #255
	str	r3, [r7, #4]
	movs	r3, #0
	str	r3, [r7]
	b	.L40
.L43:
	ldr	r3, .L47
	ldr	r3, [r3]
	adds	r3, r3, #1
	ldr	r2, .L47
	str	r3, [r2]
	ldr	r3, .L47
	ldr	r1, [r3]
	ldr	r3, .L47+4
	umull	r2, r3, r3, r1
	lsrs	r2, r3, #2
	mov	r3, r2
	lsls	r3, r3, #2
	add	r3, r3, r2
	subs	r2, r1, r3
	ldr	r3, .L47
	str	r2, [r3]
	ldr	r3, .L47
	ldr	r3, [r3]
	ldr	r2, .L47+8
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	ldrb	r3, [r3]
	uxtb	r3, r3
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	cmp	r3, #0
	bne	.L41
	ldr	r3, .L47
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L45
.L41:
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L40:
	ldr	r3, [r7]
	cmp	r3, #4
	ble	.L43
	b	.L42
.L45:
	nop
.L42:
	ldr	r3, [r7, #4]
	cmp	r3, #0
	beq	.L46
	ldr	r3, .L47
	movs	r2, #0
	str	r2, [r3]
.L46:
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L48:
	.align	2
.L47:
	.word	currentTask
	.word	-858993459
	.word	userTasks
	.size	update_next_task, .-update_next_task
	.align	1
	.global	PendSV_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	PendSV_Handler, %function
PendSV_Handler:
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	.syntax unified
@ 216 "main.c" 1
	MRS R0, PSP
@ 0 "" 2
@ 217 "main.c" 1
	STMDB R0!, {R4-R11}
@ 0 "" 2
@ 218 "main.c" 1
	PUSH {LR}
@ 0 "" 2
@ 219 "main.c" 1
	BL save_psp_value
@ 0 "" 2
@ 222 "main.c" 1
	BL update_next_task
@ 0 "" 2
@ 223 "main.c" 1
	BL get_psp_value
@ 0 "" 2
@ 224 "main.c" 1
	LDMIA R0!, {R4-R11}
@ 0 "" 2
@ 225 "main.c" 1
	MSR PSP, R0
@ 0 "" 2
@ 226 "main.c" 1
	POP {LR}
@ 0 "" 2
@ 227 "main.c" 1
	BX LR
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	.size	PendSV_Handler, .-PendSV_Handler
	.align	1
	.global	schedule
	.syntax unified
	.thumb
	.thumb_func
	.type	schedule, %function
schedule:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r3, .L51
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #268435456
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L52:
	.align	2
.L51:
	.word	-536810236
	.size	schedule, .-schedule
	.align	1
	.global	task_delay
	.syntax unified
	.thumb
	.thumb_func
	.type	task_delay, %function
task_delay:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	.syntax unified
@ 238 "main.c" 1
	MOV R0, #0x1
@ 0 "" 2
@ 238 "main.c" 1
	MSR PRIMASK, R0
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, .L55
	ldr	r3, [r3]
	cmp	r3, #0
	beq	.L54
	ldr	r3, .L55+4
	ldr	r1, [r3]
	ldr	r3, .L55
	ldr	r3, [r3]
	ldr	r2, [r7, #4]
	add	r2, r2, r1
	ldr	r1, .L55+8
	lsls	r3, r3, #4
	add	r3, r3, r1
	adds	r3, r3, #4
	str	r2, [r3]
	ldr	r3, .L55
	ldr	r3, [r3]
	ldr	r2, .L55+8
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	movs	r2, #255
	strb	r2, [r3]
	bl	schedule
.L54:
	.syntax unified
@ 246 "main.c" 1
	MOV R0, #0x0
@ 0 "" 2
@ 246 "main.c" 1
	MSR PRIMASK, R0
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L56:
	.align	2
.L55:
	.word	currentTask
	.word	g_tick_count
	.word	userTasks
	.size	task_delay, .-task_delay
	.align	1
	.global	update_global_tick_count
	.syntax unified
	.thumb
	.thumb_func
	.type	update_global_tick_count, %function
update_global_tick_count:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
	ldr	r3, .L58
	ldr	r3, [r3]
	adds	r3, r3, #1
	ldr	r2, .L58
	str	r3, [r2]
	nop
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L59:
	.align	2
.L58:
	.word	g_tick_count
	.size	update_global_tick_count, .-update_global_tick_count
	.align	1
	.global	unblock_tasks
	.syntax unified
	.thumb
	.thumb_func
	.type	unblock_tasks, %function
unblock_tasks:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	movs	r3, #1
	str	r3, [r7, #4]
	b	.L61
.L63:
	ldr	r2, .L64
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	ldrb	r3, [r3]
	uxtb	r3, r3
	cmp	r3, #0
	beq	.L62
	ldr	r2, .L64
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #4
	ldr	r2, [r3]
	ldr	r3, .L64+4
	ldr	r3, [r3]
	cmp	r2, r3
	bhi	.L62
	ldr	r2, .L64
	ldr	r3, [r7, #4]
	lsls	r3, r3, #4
	add	r3, r3, r2
	adds	r3, r3, #8
	movs	r2, #0
	strb	r2, [r3]
.L62:
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L61:
	ldr	r3, [r7, #4]
	cmp	r3, #4
	ble	.L63
	nop
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
.L65:
	.align	2
.L64:
	.word	userTasks
	.word	g_tick_count
	.size	unblock_tasks, .-unblock_tasks
	.align	1
	.global	SysTick_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	SysTick_Handler, %function
SysTick_Handler:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	bl	update_global_tick_count
	bl	unblock_tasks
	ldr	r3, .L67
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	orr	r2, r3, #268435456
	ldr	r3, [r7, #4]
	str	r2, [r3]
	nop
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L68:
	.align	2
.L67:
	.word	-536810236
	.size	SysTick_Handler, .-SysTick_Handler
	.align	1
	.global	HardFault_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	HardFault_Handler, %function
HardFault_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
.L70:
	b	.L70
	.size	HardFault_Handler, .-HardFault_Handler
	.align	1
	.global	MemManage_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	MemManage_Handler, %function
MemManage_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
.L72:
	b	.L72
	.size	MemManage_Handler, .-MemManage_Handler
	.align	1
	.global	BusFault_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	BusFault_Handler, %function
BusFault_Handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
.L74:
	b	.L74
	.size	BusFault_Handler, .-BusFault_Handler
	.ident	"GCC: (15:13.2.rel1-2) 13.2.1 20231009"
