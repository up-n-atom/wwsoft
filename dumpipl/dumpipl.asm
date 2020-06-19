; A WonderWitch soft-app to dump the system IPL over serial by means of the
; Pocket Challenge V2 bootstrap

%assign HEAD 16
%assign SEGZ 64*1024

bits 16

cpu 186

SYSTEM_CTRL3 equ 0x62
SYSTEM_CTRL1 equ 0xa0
SERIAL_DATA equ 0xb1
SERIAL_STATUS equ 0xb3
INT_NMI_CTRL equ 0xb7

; Pre-pad
times (4*SEGZ)-($-$$) db 0xff

; Do as they do - Pocket Challenge V2
times HEAD db 0x0

start:
	cli
	xor ax, ax
	out INT_NMI_CTRL, al
	mov si, ax
; Enable serial - 38400 baud
	in al, SERIAL_STATUS
	and al, 0x1f
	or al, 0xe0
	out SERIAL_STATUS, al
; Dump IPL based on system
	mov bx, 0xfe00
	mov cx, 0x2000
	in al, SYSTEM_CTRL1
	test al, 2
	jnz fuelload
	shr cx, 1
	or bh, 1
fuelload:
	mov ds, bx
	cld
dumpload:
	in al, SERIAL_STATUS
	test al, 4
	jz dumpload
	lodsb
	out SERIAL_DATA, al
	loop dumpload
; Disable Serial
junkinthetrunk:
	in al, SERIAL_STATUS
	test al, 4
	jz junkinthetrunk
	and al, 0x5f
	out SERIAL_STATUS, al
; Power down
	mov al, 1
	out SYSTEM_CTRL3, al
	hlt

; Post-pad
times ((3*SEGZ)-HEAD)-($-start+HEAD) db 0xff

; Header
	db 0xea
	dw start
	dw 0x4000
	db 0
	db 0xff
	db 1
	align 16, db 0xff
