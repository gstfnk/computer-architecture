	org 100h
	
start:
	CALL	wkom1
	CALL	ent
	
	;Zapisujemy podany ciąg do zmiennej
	MOV		AH,10
	MOV		DX,ciag
	INT		21H
	CALL	ent
	
	CALL	wkom2
	CALL	ent
	
value:	
	;Zapisujemy podaną liczbę do zmiennej
	MOV		AH,10
	MOV		DX,liczba
	INT		21H

	XOR		BX,BX			;Czyszczę rejestr 
	MOV		BX,liczba		;Do BX wkładam adres
	MOV		DL,[BX+2]		;W DL umieszczam liczba[2]
	SUB		DL,48 			;Zamieniam DL na liczbę	
	XOR		AX,AX
	MOV		AX,DX

szyfr:
	XOR		BX,BX
	MOV		BX,ciag
	XOR 	CX,CX
	MOV 	CL,[BX+1] 			;Ilość znaków w ciągu (ilość iteracji loopS)
	ADD 	CX,2
	MOV 	DI,2
	
	loopS:
		XOR 	DX,DX			;Czyścimy rejestr
		MOV 	DL,[BX+DI]		;Do DL wrzucamy ciag[DI]
		CMP		DL,65			;DL-65(A)=
		JB		space			;Zamieniamy na spacje jeśli poniżej 65, bo to nie litera
		CMP		DL,91			;DL-91(Z)=
		JB		toLower			;Zamieniamy na małe jeśli poniżej 91
		CMP		DL,97			;DL-97(a)=
		JB		space			;Zamieniamy na spacje jeśli poniżej 97
		CMP 	DL,122			;DL-122(z)=
		JNA		zmiana			;Zmieniamy jeśli poniżej lub równe 122
		JA		space			;Zamieniamy na spacje jeśli powyżej 122, bo to nie litera
		contin:
			MOV		[BX+DI],DL		;Zmienione literki wstawiamy do ciągu
			INC		DI				;DI++;
			CMP		DI,CX			;DI-CX=
			JB		loopS			;Następna iteracja loopS jeśli CX>DI
		
	CALL	ent	
	CALL	wkom3
	CALL	ent
	CALL	wciag
	CALL	koniec

wkom1: ;Wyświetlamy kom1
	MOV		AH,9
	MOV		DX,kom1
	INT		21H
ret

wkom2:	;Wyświetlamy kom2
	MOV		AH,9
	MOV		DX,kom2
	INT		21H
ret

wkom3:	;Wyświetlamy kom3
	MOV		AH,9
	MOV		DX,kom3
	INT		21H
ret
	

ent:	;Enter
	PUSH	AX
	PUSH	DX
	
	MOV		AH,2
	MOV		DL,10	;Do następnej linii
	INT		21H
	MOV		DL,13	;Powrót karetki
	INT		21H
	
	POP		DX
	POP		AX
ret

space:
	MOV		DL,32		;DL=32(spacja)
	JMP		contin
	
toLower:
	ADD 	DL,32		;DL=DL+32('a'-'A')
	JMP		zmiana
	
zmiana:
	ADD		DL,AL		;DL=DL+AL
	CMP 	DL,122		;DL-122(z)=
	JA 		loopZM		;Jeśli DL>122
	JMP 	contin
		
loopZM:
	SUB		DL,26		;DL=DL-26(z tylu składa się alfabet angielski)
	CMP		DL,122		;DL-122=
	JA 		loopZM		;Jeśli DL>122 to następna iteracja
	JMP		contin
	
wciag:		;Wyswietlamy ciąg
	MOV		AH,9
	MOV		DX,ciag+2 	;Od pierwszego znaku, czyli od indeksu=2
	INT		21h
ret

koniec:
	MOV		AX,4C00H
	INT		21H
ret

; Pierwsza wartość = 10, druga wartość = ile tych liczb jest, nasze pisanie zaczyna się od 2 indeksu
; indeks = 0, 				indeks = 1, 							indeks = 2
; times + [rozmiar tablicy] + db + [wypełniamy dolarkami]

liczba	db	10,0
		TIMES	11	db	36
		
ciag	db	26,0
		TIMES	27	db	36

kom3	db	"Ci",165,"g Cezara: $"
kom2	db	"Podaj warto",152,134," przesuni",169,"cia (od 0 do 9): $"
kom1	db	"Podaj ci",165,"g znak",162,"w do zaszyfrowania (max 25 znak",162,"w): $"

