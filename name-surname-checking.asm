	org 100h	;PRZESUNIECIE

;Kazda linie po wpisywaniu zakanczamy znakiem dolara - $
start:
	XOR	DI,DI
	MOV	AH,2
	
wyp1:	;wypisujemy komunikat o imieniu
	MOV DL,[a+DI]
	CMP	DL,58
	JE	ent1
	INT	21H
	INC	DI
	JMP	wyp1

ent1:	
	MOV	AH,2
	MOV	DL,10
	INT	21H
	MOV DL,13
	INT	21H
	
	XOR DI,DI	;czyścimy i enterujemy
	
wcz1:	;wczytujemy imie do zmiennej
	MOV	AH,1
	INT	21H
	MOV	[imie+DI],AL
	CMP	AL,65	;porównuje z 'A'
	JL	nieL1	;jeśli niżej to do nieL1
	
wroc1:
	CMP AL,122	;porównuje z 'z'
	JG	nieL2	;jeśli wyżej to do nieL2
	
wroc2:
	CMP	AL,90	;porównuje z 'Z'
	JG	nieL3	;jeśli wyżej to do nieL3
	
wroc3:
	INC	DI
	MOV	CL,36
	CMP	AL,CL	;jeśli to nie spacja
	JNE	wcz1	;to do wcz1
	
	;ENTER
	MOV	AH,2
	MOV	DL,10
	INT	21H
	MOV	DL,13
	INT	21H
	
	XOR	DI,DI
	MOV	AH,2
	
wyp2:	;wypisujemy komunikat o nazwisku
	MOV DL,[b+DI]
	CMP	DL,58
	JE	ent2
	INT	21H
	INC	DI
	JMP	wyp2

ent2:
	MOV	AH,2
	MOV	DL,10
	INT	21H
	MOV	DL,13
	INT	21H
	
	XOR	DI,DI
	XOR	CX,CX
	
wcz2:	;wczytujemy nazwisko do zmiennej 
	MOV	AH,1
	INT	21H
	MOV	[nazw+DI],AL
	CMP	AL,65	;porównuje z 'A'
	JL	nieL1N	;jeśli niżej to do nieL1N
	
wroc1N:
	CMP AL,122	;porównuje z 'z'
	JG	nieL2N	;jeśli wyżej to do nieL2N
	
wroc2N:
	CMP	AL,90	;porównuje z 'Z'
	JG	nieL3N	;jeśli wyżej to do nieL3N
	
wroc3N:
	INC	DI
	MOV	CL,36
	CMP	AL,CL	;jeśli to nie dolar
	JNE	wcz2	;to do wcz2
	
	;ENTER
	MOV	AH,2
	MOV	DL,10
	INT	21H
	MOV	DL,13
	INT	21H
	
	XOR	BX,BX	
	MOV	BL,1
	CMP	[bool],BL
	JE	blad
	JNE	nieblad
	
komun:


	;ENTER
	MOV	AH,2
	MOV	DL,10
	INT	21H
	MOV	DL,13
	INT	21H
	
	
	XOR	DI,DI
	MOV	ah,2
	
wypI:	;wypisujemy imię
	MOV	DL,[imie+DI]
	CMP	DL,36
	JE	imie1
	INT	21H
	INC	DI
	JMP	wypI
	
imie1:
	MOV	AH,2
	MOV	DL,32
	INT	21H
		
	XOR	DI,DI
	MOV	AH,2
	
wypN:	;wypisujemy nazwisko
	MOV	DL,[nazw+DI]
	CMP	DL,36
	JE	koniec
	INT	21H
	INC	DI
	JMP	wypN

koniec:
	MOV	AX, 4C00h	; KONIEC PROGRAMU
	INT	21H
	
nieL1:
	MOV	CL,1
	CMP	AL,36
	JE	wroc1
	MOV	[bool],CL
	JMP 	wroc1	
nieL2:	
	MOV	CL,1
	MOV	[bool],CL
	JMP	wroc2
nieL3:	
	CMP	AL,97
	JL	nieL4
	JMP	wroc3
nieL4:
	MOV	CL,1
	MOV	[bool],CL
	JMP	wroc3


	;dla nazwiska 
nieL1N:
	MOV	CL,1
	CMP	AL,36
	JE	wroc1N
	MOV	[bool],CL
		
	JMP 	wroc1N	
nieL2N:	
	MOV	CL,1
	MOV	[bool],CL
	JMP	wroc2N
nieL3N:	
	CMP	AL,97
	JL	nieL4N
	JMP	wroc3N
nieL4N:
	MOV	CL,1
	MOV	[bool],CL
	JMP	wroc3N
	
blad:
	XOR	DI,DI
	MOV	AH,2
bladP:
	MOV	DL,[niedob+DI]
	CMP	DL,36
	JE	komun
	INT	21H
	INC	DI
	JMP	bladP
	
nieblad:
	XOR	DI,DI
	MOV	ah,2
nieblP:
	MOV	DL,[dobre+DI]
	CMP	DL,36
	JE	komun
	INT	21H
	INC	DI
	JMP	nieblP

a 	DB	'P','o','d','a','j',32,'s','w','o','j','e',32,'i','m','i','e',':'
b	DB	'P','o','d','a','j',32,'s','w','o','j','e',32,'n','a','z','w','i','s','k','o',':'
imie	TIMES	10	db	36
nazw	TIMES	10	db	36
bool	DB	0
niedob	DB	'B',136,165,'d',32,'w',32,'i','m','i','e','n','i','u',32,'l','u','b',32,'n','a','z','w','i','s','k','u','!',36
dobre	DB	'I','m','i',169,32,'i',32,'n','a','z','w','i','s','k','o',32,'p','o','p','r','a','w','n','e','!',36