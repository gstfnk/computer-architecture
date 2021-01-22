	org 100h
	
start:
	mov	ah,1
	int	21h
	sub	al, 48
	mov	[liczba1], al

	int	21h
	sub	al, 48
	mov	[liczba2], al


	mov	ax, [liczba1]
	mov	bx, [liczba2]

	push	ax
	push	bx

	call	dodawanie
	call	wyswietl
	
	mov	ax, [liczba1]
	mov	bx, [liczba2]
	push	ax
	push	bx

	call	odejmowanie
	call	wyswietl

	xor	ax, ax

	mov	ax, [liczba1]
	mov	bx, [liczba2]
	push	ax
	push	bx

	call	mnozenie
	call	wyswietl

	mov	ax, [liczba1]
	mov	bx, [liczba2]
	push	bx
	push	ax

	call	dzielenie
	call	wyswietl
	jmp	koniec

wyswietl:
	mov ah, 2
	mov dl, 32
	int	21h

	pop	cx
	pop	dx
	int	21h
	push	cx
	xor	dx, dx
	ret

dodawanie:
	pop	cx
	pop	bx
	pop	ax

	add	ax, bx
	push 	ax
	push	cx
	ret
	
odejmowanie:
	pop	cx
	pop	bx
	pop	ax 
	
	sub	ax, bx
	push	ax
	push	cx
	ret

mnozenie:	
	pop	cx
	pop	ax
	pop	bx

	mul	bx
	
	push	ax
	push	cx
	ret

dzielenie:
	pop	cx
	pop	ax
	pop	bx	
	xor	dx, dx		
	cmp	bx, 0
	je	czyzero

	div	bx
	
dalej:
	push	ax
	push	cx
	ret

czyzero:
	mov	dl, 33
	mov	ah, 2
	int	21h

	jmp	dalej

koniec:
	mov	ax, 4C00h
	int	21h

liczba1	dw	0
liczba2	dw	0
