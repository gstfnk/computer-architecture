	ORG 100H	;PRZESUNIECIE

	;(4) Program, ktÛry pobiera ciπg znakÛw z wejúcia i wypisuje na wyjúciu
	;≥aÒcuch pozbawiony WIELKICH liter w nim zawartych.
	;Program powinien mÛc wieloktornie powtarzaÊ operacje
	;z rÛønymi ciπgami znakÛw oraz zakoÒczyÊ pracÍ po naciúniÍciu
	;przez uøytkowanika klawisza SPACJA.
	;WykorzystaÊ procedury i stos. PrzewidzieÊ sytuacje wyjπtkowe.

;Program koÒczy prace po naciúniÍciu przez uøytkownika klawisza SPACJA
;tylko i wy≥πcznie wtedy, kiedy SPACJA pojawia siÍ na pierwszym miejscu
;ciπgu wejúciowego, tak, aby uøytkownik mÛg≥ wpisaÊ sobie pe≥ne zdania


start:	
	CALL	wkom1	;Wyúwietlanie komentarza 1
	CALL	ent		;ENTER
	
	CALL	wkom2	;Wyúwietlanie komentarza 2
	CALL	ent		;ENTER
	
	CALL	wkom3	;Wyúwietlanie komentarza 3
	CALL	ent		;ENTER
	
	CALL	wkom4	;Wyúwietlanie komentarza 4
	CALL	ent		;ENTER
	
start2:	
	MOV	SI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "input"
	MOV	DI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "output"

	CALL	czyszczenie	;Czyszcze zmienne
	CALL	ent			;ENTER

	MOV	SI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "input"
	MOV	DI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "output"
	
wczytaj:	;Wczytywanie znakÛw z klawiatury
	MOV	AH,10
	MOV	DX,input
	INT	21H	
	
	CALL	ent		;ENTER
	
	XOR	SI,SI
	XOR	DI,DI	
	MOV	SI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "input"
	MOV	DI,2	;Ustawiam indeks na 2, bo od tego znaku jet nasze wpisywanie - do "output"
	
cowinput:
	XOR	DX,DX
	
	MOV	DL,[input+2]	;Jeúli pierwszy znak to SPACJA to musisz skoÒczyÊ
	CMP	DL,32			;bez wzglÍdu na to czy potem jest litera czy nie
	JE	przerwij

	XOR	DX,DX
	MOV	DL,[input+SI]	;Jedziemy po tabli ciπgu wpisanego przez uøytkownika
	
	CMP	DL,'$'			;Koniec ciπgu
	JE	zakoncz			;ZakoÒcz - tπ czÍúÊ programu
	
	;Sytuacje wyjπtkowe:
	CMP	DL,164	;•
	JE	duza
	
	CMP	DL,143	;∆
	JE	duza
	
	CMP	DL,168	; 
	JE	duza
	
	CMP	DL,157	;£
	JE	duza
	
	CMP	DL,227	;—
	JE	duza
	
	CMP	DL,224	;”
	JE	duza
	
	CMP	DL,151	;å
	JE	duza
	
	CMP	DL,141	;è
	JE	duza
	
	CMP	DL,189	;Ø
	JE	duza
	
	CMP	DL,32			;Spacje traktujemy jako normalny znak
	JE	wrzuc			;Wrzucamy jπ do ciπgu wyjúciowego
	
	CMP	DL,'A'			
	JB	wrzuc
	
	CMP	DL,'Z'
	JA	wrzuc
	
	CMP	DL,'A'
	JAE	duza
	
wrzuc:	;Wrzucamy do ciagu wyjúciowego nie-wielkie-litery
	XOR DX,DX
	MOV	DL,[input+SI]
	MOV	[output+DI],DL
	INC	DI
	INC	SI
	JMP	cowinput
	
duza:	;Wykrywamy duøπ literÍ, wrzucamy jπ na stos
	XOR DX,DX
	MOV	DL,[input+SI]
	PUSH	DX
	INC	SI
	JMP	cowinput
	
zakoncz:	;Wyúwietlanie komentarza 5 wraz z ciπgiem wyjúciowym
	XOR	DX,DX
	MOV	SI,2	;Zeruje indeksy
	MOV	DI,2
	
	MOV	AH,9
	MOV	DX,kom5
	INT	21H
	
	CALL	ent
	
	XOR	DX,DX
	MOV	AH,9
	MOV	DX,output+2
	INT	21H
	
	CALL	ent
	
	JMP usuniete
	
usuniete:	;Dodatkowo program chce wyúwietliÊ litery usuniÍte
	XOR	DX,DX
	MOV DL,[input+SI]
	
	CMP	DL,'$'
	JE	dalej
	CMP	DL,164	;•
	JE	indeks
	CMP	DL,143	;∆
	JE	indeks
	CMP	DL,168	; 
	JE	indeks
	CMP	DL,157	;£
	JE	indeks
	CMP	DL,227	;—
	JE	indeks
	CMP	DL,224	;”
	JE	indeks
	CMP	DL,151	;å
	JE	indeks
	CMP	DL,141	;è
	JE	indeks
	CMP	DL,189	;Ø
	JE	indeks
	CMP	DL,'A'
	JB	pomin
	CMP	DL,'Z'
	JA	pomin
	CMP	DL,'A'
	JA	indeks
	
indeks:	;PowiÍkszamy indeks duzych liter i ciagu wejsciowego
	INC	DI	;ZwiÍkszamy indeks duzych
	INC	SI	;ZwiÍkszamy indeks inputu
	JMP	usuniete
	
pomin:	;Pomijamy wszystkie nie-wielkie-litery
	INC	SI	;ZwiÍkszamy indeks inputu
	JMP usuniete
	
przerwij:	;Przerywamy na spacje
	XOR	DX,DX
	CALL	wkom7
	JMP	koniec
	
dalej:	;Konczymy drugie sprawdzenie ciπgu i uzupelniamy duze litery odrzucone
	CMP	DI,1
	JE	koncz
	XOR DX,DX
	POP DX
	MOV	[duze+DI],DL
	DEC	DI
	JMP	dalej
	
koncz:	;Wyúwietlanie zmiennej duze i kom6 
	MOV	AH,9
	MOV	DX,kom6
	INT	21H
	
	CALL	ent
	
	XOR	DX,DX
	MOV	AH,9
	MOV	DX,duze+3
	INT	21H
	
	CALL	ent
	
	JMP start2
	
koniec:
	MOV	AX,4C00H
	INT	21H

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

;Czyúcimy zmienne wstawiajac dolary co kazde wywo≥anie uøytkownika

czyszczenie:
	XOR	DX,DX
	CMP	SI,28
	JE	wczytaj
	MOV	DL,36
	MOV	[input+SI],DL
	XOR	DX,DX
	MOV	DL,36
	MOV	[output+SI],DL
	XOR	DX,DX
	MOV	DL,36
	MOV	[duze+SI],DL
	INC SI
	JMP	czyszczenie
ret

ent:	;Enter
	MOV		AH,2
	MOV		DL,10	;Do nastÍpnej linii
	INT		21H
	MOV		DL,13	;PowrÛt karetki
	INT		21H
ret

; Pierwsza wartoúÊ = 26, druga wartoúÊ = ile tych liczb jest, nasze pisanie zaczyna siÍ od 2 indeksu
; indeks = 0, 				indeks = 1, 							indeks = 2
; times + [rozmiar tablicy] + db + [wype≥niamy dolarkami]

input	DB	26,0
		TIMES	27	DB	36
output	DB	26
		DB	0
		TIMES	27	DB	36
duze	DB	26,0
		TIMES	27	DB	36

kom1	db	"Usuwanie WIELKICH liter z ci",165,"gu! Zasady programu:",36
kom2	db	"1. Wpisujesz ci",165,"g znak",162,"w, zatwierdzasz klawiszem ENTER.",36
kom3	db	"2. Ja oddaje Ci ten sam ci",165,"g znak",162,"w, ale bez WIELKICH liter.",36
kom4	db	"3. Wpisuj",165,"c na pocz",165,"tku SPACJA+ENTER przerywasz dzia",136,"anie programu.",36
kom5	db	"Ci",165,"g bez WIELKICH liter:",36
kom6	db	"Takie litery usun",165,136,"em:",36
kom7	db	"Koniec programu. Dziekuje :)",36