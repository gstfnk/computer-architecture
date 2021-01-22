	ORG 100H
	
start:
	;Wyświetlamy kom1
	CALL	wkom1
	CALL	ent
	;Wyświetlamy kom2
	CALL	wkom2
	CALL	ent
	;Wyświetlamy kom3
	CALL	wkom3
	CALL	ent
	;Wyświetlamy kom4
	CALL	wkom4
	CALL	ent
	;Wczytujemy znaki z klawiatury
	MOV	AH,10
	MOV	DX,input
	INT	21H
	
	MOV	DI,2	;Ustawiam indeks na 2, bo od tego znaku jest nasze wpisywanie - do "output"
	MOV	SI,2	;Ustawiam indeks na 2, bo od tego znaku jest nasze wpisywanie - do "input"
	
cowinput:
	MOV	DL,[input+SI]
	
	CMP	DL,'$'	;Spotykamy $ - koniec znaków wpisywanych 
	JE	nastos ;Skaczemy na stos
	
	CMP	DL,'/'	;Niedozwolona operacja - program nie działa dla dzielenia
	JE	niedozwolony	;Wyświetlamy komunikat o błędzie
	
	CMP	DL,'-'	;Niedozwolona operacja - program nie działa dla odejmowania
	JE	niedozwolony	;Wyświetlamy komunikat o błędzie
	
	CMP	DL,'9'
	ja	niedozwolony ;Niedozwolony znak - wyświetlamy komunikat o błędzie
	
	CMP	DL,'0'
	JAE	cowinputret ;Wpisujemu cyfrę i pętla sprawdza dalej
	
	CMP	DL,'(' ;Wrzucamy nawias początkowy ląduje na stos
	JE	poczateknawiasu
	
	CMP	DL,')' ;Zdejmujemy znaki ze stosu do momentu znalezienia nawiasu 
	JE	koniecnawiasu
	
	CMP	DL,'+'
	JE	conastosie ;Mnożenie ma największą wagę, więc zanim dodamy musimy sprawdzić czy mamy mnożenie
	
	CMP	DL,'*'
	JE	pomnoz	;Ma największą wagę, więc możemy pomnożyć od razu 
	
	MOV	DL,32	;Wstawiamy spacje
	
cowinputret:
	MOV	[output+DI],DL
	XOR	DX,DX
	;Zapętlamy (zwiększamy indeksy)
	INC	DI
	INC	SI
	JMP	cowinput

conastosie: 
	POP	CX	
	CMP	CL,'*'
	JNE	niemnozenie 
	MOV	[schowek],DL
	MOV	DL,32
	MOV	[output+DI],DL
	INC	DI
	XOR	DX,DX
	MOV	DL,[schowek]
	MOV	[output+DI],CL
	XOR CX,CX
	INC DI
	POP CX
	CMP	CL,'*'
	JNE	niemnozenie
	PUSH CX
	PUSH DX
	XOR	CX,CX
	XOR	DX,DX
	MOV	DL,32
	MOV	[output+DI],DL
	INC DI
	INC	SI
	JMP	cowinput
	
niemnozenie:
	PUSH	CX
	PUSH	DX
	MOV	DL,32
	XOR CX,CX
	JMP	cowinputret

pomnoz:
	PUSH	DX
	MOV	DL,32
	JMP	cowinputret
	
poczateknawiasu:
	PUSH	DX	;Wrzucamy '(' na stos
	MOV	DL,32	;Wstawiamy spacje
	JMP	cowinputret
	
koniecnawiasu:	;Dopóki nie będzie '(' to ściągamy to co mamy ze stosu
	MOV	[schowek],DL
	MOV	DL,32
	MOV	[output+DI],DL
	INC	DI
	XOR	DX,DX
	MOV	DL,[schowek]
	POP	CX
	CMP	CL,'('
	JNE	niemanawiasu	;Jeśli nie ma nawiasu to idziemy dalej po ciągu
	XOR	CX,CX
	INC	SI
	JMP	cowinput
	
niemanawiasu: 
	XOR	DX,DX
	MOV	DL,CL
	MOV	[output+DI],DL
	INC	DI
	XOR	DX,DX
	XOR	CX,CX
	JMP	koniecnawiasu

nastos:
	POP	CX
	CMP	CL,0
	JNE	dalejstos
	CALL	ent
	;Wyświetlamy kom5
	CALL	wkom5
	CALL	ent
	;Wyświetlamy nasz output = ONP
	CALL	wonp
	
	MOV	DI,2 ;Restartujemy indeksator
	JMP obliczenia

;Ciąg dalszy output
dalejstos:	
	MOV	[output+DI],CL
	INC DI
	XOR DX,DX
	MOV	DL,32
	;XOR	CX,CX
	MOV	[output+DI],DL
	INC DI
	JMP	nastos
	
obliczenia:
	MOV	DL,[output+DI]
	CMP	DL,'$'
	JE	komEND	;Jeśli trafimy na dolarka = koniec ciągu to skaczemy do komendy kończącej
	CMP DL,'0'
	JAE cyfra 
	JMP	znaki
	obliczenia2:
		INC	DI
		XOR	DX,DX
		JMP	obliczenia
	
cyfra:
	XOR	AX,AX
	MOV	al,DL
	SUB	AX,48
	XOR	BX,BX
	MOV	bl,10
	
czywielo: ;Sprawdzamy czy jest to liczba jedno czy wielocyfrowa 
	XOR	CX,CX
	INC	DI
	MOV	CL,[output+DI]
	CMP	CL,47
	jb	jedno ;Za cyfrą nie ma kolejnej, więc jest to jednocyfrowa liczba
	sub	CL,48
	MUL bl
	ADD	AX,CX
	JMP czywielo ;Zapętlamy
	
jedno:
	PUSH AX
	XOR	DX,DX
	MOV	DL,CL
	XOR	AX,AX
	XOR	CX,CX
	JMP znaki

;Sprawdzamy znaki
znaki:
	CMP	DL,'+'
	JE	wezdodaj

	CMP	DL,'*'
	JE	wezmnoz

	JMP	obliczenia2
	
wezdodaj: ;Ściągamy 2 liczby do obliczeń dodajemy je
	XOR	AX,AX
	XOR	BX,BX
	POP	BX
	POP AX
	CMP	DL,'+'
	JE	dodaj
	
wezmnoz:	;Ściągamy 2 liczby do obliczeń je mnożymy 
	XOR	AX,AX
	XOR	BX,BX
	POP	BX
	POP AX
	CMP	DL,'*'
	JE	pomnoz2


dodaj:
	ADD	AX,BX
	PUSH	AX
	JMP	obliczenia2
	
	
pomnoz2:
	MUL	BX
	PUSH	AX
	JMP	obliczenia2

	
;Komentarz ostateczny kończący 
komEND:
	;Enter
	CALL	ent
	;Wyświetlamy kom6
	MOV	ah,9
	MOV	DX,kom6
	INT	21H
	;Enter
	CALL	ent

;Schemat kończenia obliczeń i zamieniania z bin -> dec
obliczenia3:
	XOR	BX,BX
	MOV	BX,10
	XOR	DX,DX
	XOR	CX,CX
	XOR	AX,AX
	POP	AX
	MOV	CX,0
	
obliczenia4:
	INC	CX
	DIV	BX
	PUSH	DX
	XOR	DX,DX
	CMP	AX,0
	JNE	obliczenia4
	MOV	AH,2
	
obliczenia5:
	POP	DX
	ADD	DL,'0'
	INT	21h
	loop	obliczenia5

koniec:	

	MOV	AX,4C00h
	int	21h
	
niedozwolony:
	MOV	ah,9
	MOV	DX,kom7
	int	21h
	JMP	koniec
	
ent:	;Enter
	MOV		AH,2
	MOV		DL,10	;Do następnej linii
	INT		21H
	MOV		DL,13	;Powrót karetki
	INT		21H
ret

wkom1:
	MOV	AH,9
	MOV	DX,kom1
	INT	21H
ret

wkom2:
	MOV	AH,9
	MOV	DX,kom2
	INT	21H
ret

wkom3:
	MOV	AH,9
	MOV	DX,kom3
	INT	21H
ret

wkom4:
	MOV	AH,9
	MOV	DX,kom4
	INT	21H
ret

wkom5:
	MOV	AH,9
	MOV	DX,kom5
	INT	21H
ret

wkom6:
	MOV	AH,9
	MOV	DX,kom6
	INT	21H
ret

wkom7:
	MOV	AH,9
	MOV	DX,kom7
	INT	21H
ret

wonp:
	MOV	AH,9
	MOV	DX,output
	INT	21H
ret

;ZMIENNE - OBLICZENIA
; Pierwsza wartość = 10, druga wartość = ile tych liczb jest, nasze pisanie zaczyna się od 2 indeksu
; indeks = 0, 				indeks = 1, 							indeks = 2
; times + [rozmiar tablicy] + db + [wypełniamy dolarkami]

input	DB	26,0
		TIMES	27	DB	36
output	DB	26,0
		TIMES	27	DB	36
schowek	DB	0
			
kom1	db	"ONP - Odwrotna Notacja Polska",36
kom2	db	"Dozwolone znaki to: cyfry od 0 do 9, (, ), *.",36
kom3	db	"Dozwolone operacje: dodawanie i mno",190,"enie.",36
kom4	db	"Wpisz wyra",190,"enie do obliczenia:",36
kom5	db	"Podane wyra",190,"enie w postaci ONP:",36
kom6	db	"Wynik podanego wyra",190,"enia:",36
kom7	db	"Podano niedozwolony znak!",36