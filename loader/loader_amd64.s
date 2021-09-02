TEXT ·Allocate(SB),$0-56
		XORQ AX,AX
        MOVW callid+0(FP), AX
        MOVQ PHandle+8(FP), CX 
        MOVQ SP, DX 
        ADDQ $0x48, DX
        MOVQ $0,(DX)
        MOVQ ZeroBits+35(FP), R8
        MOVQ SP, R9 
        ADDQ $40, R9
        ADDQ $8,SP
        MOVQ CX,R10
        SYSCALL
        SUBQ $8,SP
        RET

//Shout out to C-Sto for helping me solve the issue of  ... alot of this also based on https://golang.org/src/runtime/sys_windows_amd64.s
#define maxargs 8
//func Syscall(callid uint16, argh ...uintptr) (uint32, error)
TEXT ·NtProtectVirtualMemory(SB), $0-56
	XORQ AX,AX
	MOVW callid+0(FP), AX
	PUSHQ CX
	MOVQ argh_len+16(FP),CX
	MOVQ argh_base+8(FP),SI
	MOVQ	0x30(GS), DI
	MOVL	$0, 0x68(DI)
	SUBQ	$(maxargs*8), SP
	MOVQ	SP, DI
	CLD
	REP; MOVSQ
	MOVQ	SP, SI
	SUBQ	$8, SP
	MOVQ	0(SI), CX
	MOVQ	8(SI), DX
	MOVQ	16(SI), R8
	MOVQ	24(SI), R9
	MOVQ	CX, X0
	MOVQ	DX, X1
	MOVQ	R8, X2
	MOVQ	R9, X3
	MOVQ CX, R10
	SYSCALL
	ADDQ	$((maxargs+1)*8), SP
	POPQ	CX
	MOVL	AX, errcode+32(FP)
	MOVQ	0x30(GS), DI
	MOVL	0x68(DI), AX
	MOVQ	AX, err_itable+40(FP)
	RET
        

