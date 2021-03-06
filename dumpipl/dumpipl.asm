; A WonderWitch soft-app to dump the system IPL over serial by means of the
; Pocket Challenge V2 bootstrap

bits 16

cpu 186

	HDRZ equ 16
	SEGZ equ 64*1024

	SYSTEM_CTRL3 equ 0x62
	SYSTEM_CTRL1 equ 0xa0
	SERIAL_DATA equ 0xb1
	SERIAL_STATUS equ 0xb3
	INT_NMI_CTRL equ 0xb7

times (4*SEGZ)-($-$$) db 0xff

times HDRZ db 0x0

start:
	cli
	cld
	xor ax, ax
	out INT_NMI_CTRL, al
	mov si, ax
					; Enable serial - 38400 baud
	in al, SERIAL_STATUS
	and al, 0x1f
	or al, 0xe0
	out SERIAL_STATUS, al
					; Dump IPL based on system
					; WonderSwan Color/SwanCrystal
	mov bx, 0xfe00
	mov cx, 0x2000
	in al, SYSTEM_CTRL1
	test al, 2
	jnz .load
					; WonderSwan @ 0xff00/0x1000
	shr cx, 1
	or bh, 1
.load:
	mov ds, bx
.dump:
	in al, SERIAL_STATUS
	test al, 4
	jz .dump
	lodsb
	out SERIAL_DATA, al
	loop .dump
					; Flush and disable serial
.flush:
	in al, SERIAL_STATUS
	test al, 4
	jz .flush
	and al, 0x5f
	out SERIAL_STATUS, al
					; Power down
	mov al, 1
	out SYSTEM_CTRL3, al
	hlt

times ((3*SEGZ)-HDRZ)-($-start+HDRZ) db 0xff

	jmp 0x4000:start
	db 0
	db 0xff
	db 1
	align 16, db 0xff
