	org 100h	;PRZESUNIECIE

	MOV	AH,1
	INT	21H	;pobranie pierwszego znaku
	SUB	AL,48	;zamiana cyfr w tabeli ascii
	MOV	[a],AL	;przypisuje do zmiennej wartosci


	MOV	AH,1
	INT	21H
	SUB	AL,48
	MOV	[b],AL
 
	;ENTER

	MOV	AH,2
	MOV	DL,10
	INT	21H

	MOV	AH,2
	MOV	DL,13
	INT	21H

dodawanie:
	XOR 	CX,CX 		;zerujemy cx
	ADD	CL,[a]		;dodanie do cl a
	ADD	CL,[b]		;dodanie do cl b
	
	MOV	AH,2
	MOV	DL,CL		;wyswietlenie operacji dodawania
	INT	21H	

	;SPACJA
	MOV 	AH,2
	MOV 	DL,32
	INT 	21H

odejmowanie:
	XOR	CX,CX
	MOV	CL,[a]	
	SUB	CL,[b]

	MOV 	AH,2
	MOV	DL,CL
	INT	21H	

	;SPACJA	
	MOV	AH,2
	MOV	DL,32
	INT	21H
	
mnozenie:
	XOR 	AX,AX
	XOR	CX,CX
	MOV	AH,[a]
	MOV	AL,[b]
	MUL	AH
	MOV	CL,AL
	
	MOV	AH,2
	MOV	DL,CL
	INT	21h
	
	;SPACJA
	MOV	AH,2
	MOV	DL,32
	INT	21H

dzielenie:
	XOR	AX,AX
	MOV	AL,[a]
	MOV	BH,[b]
        
	CMP BH,0
	JZ  zero
	DIV	BH
	CMP	BH,0
	JNZ nzero

zero:
	MOV     AL,33
	
nzero:
	MOV     CL,AL
	MOV     CH,AH

	MOV	AH,2
	MOV	DL,CL
	INT	21H
	

	MOV	AX, 4C00h	; KONIEC PROGRAMU
	INT	21H

a 	DB	0
b	DB	0