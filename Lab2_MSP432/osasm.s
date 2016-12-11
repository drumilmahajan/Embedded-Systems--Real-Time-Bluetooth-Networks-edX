;/*****************************************************************************/
; OSasm.s: low-level OS commands, written in assembly                       */
; Runs on LM4F120/TM4C123/MSP432
; Lab 2 starter file
; February 10, 2016
;


        AREA |.text|, CODE, READONLY, ALIGN=2
        THUMB
        REQUIRE8
        PRESERVE8

        EXTERN  RunPt            ; currently running thread
        EXPORT  StartOS
        EXPORT  SysTick_Handler
        IMPORT  Scheduler



SysTick_Handler                ; 1) Saves R0-R3,R12,LR,PC,PSR
    CPSID   I                  ; 2) Prevent interrupt during switch
	
	PUSH {R4-R11}			   ; Pushing registers R4 to R11 on the stack
	LDR R0, =RunPt			   ; Loading address of RunPt
	LDR R1, [R0] 			   ; Loading the contents of RunPt to R1. Now R1 has address of current runnig thread's TCB
	LDR [R1], SP			   ; Present thread's SP to its TCB. 
	
	LDR R1, [R1, #4]		   ; Accesing next of present TCB and loading its contents in R1 which is address of TCB of next thread
	STR R1, [R0] 			   ; Putting the address of next thread's TCB in current RunPt
	LDR SP, [R1]			   ; Putting the contents of r1 which is SP of next thread in the system's SP
	
	POP {R4-R11}			   ; Popping the R4-R11 manually
    
	CPSIE   I                  ; 9) tasks run with interrupts enabled
    BX      LR                 ; 10) restore R0-R3,R12,LR,PC,PSR

StartOS

	LDR R0, =RunPt			   ; Address of RunPt in R0
	LDR R1, [R0]			   ; contents of RunPt in R1 which is pointer of first TCB
	LDR [R1], SP			   ; Contents of R1 which is SP to first thread into system's SP
	
	POP {R4-R11}			   ; Popping R4-R11 into systems {R4-R11}
	POP {R0-R3}				   ; Popping R0-R3 into systems {R0-R3} # POP {is the destination to ehich popped reg are stored}
	POP {R12}				   ; Popping R12
	
	ADD SP, #4 				   ; Skipping LR on stack because it has nothing useful
	POP {LR}				   ; {LR} is the LR of systems and the values popped is the PC from the stack. so PC goes to LR so BX LR is correct.
	
	ADD SP, #4				   ; PSR is not valid yet so just skipped.
    CPSIE   I                  ; Enable interrupts at processor level
    BX      LR                 ; start first thread

    ALIGN
    END
