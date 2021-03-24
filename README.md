# Computer Architecture
### [Name Surname](name-surname.ASM)
Napisać program, który:
- od nowej linii
- wyświetla imię i nazwisko studenta – uwzględniając małe i duże litery
- za pomocą przerwania dosowego ah, 2
- przerwać działanie programu za pomocą ah, 1
### [Name Surname using Cheking](name-surname-checking.asm)
Napisać program, który posiada walidację i sprawdza, czy w imieniu bądź nazwisku nie ma niedozwolonych znaków i informuje o tym użytkownika.
### [Name Surname using Conditions](name-surname-condition.ASM)
Zmodyfikuj swój program z poprzednich zajęć, tak aby, po wprowadzeniu jednego znaku ASCII z klawiatury program wyświetlił na ekranie dla wartości (znaku ASCII) większej od 90 -nazwisko, a dla mniejszej wartości znaku ASCII - imię.
### [Arithmetical operation](arithmetical-operation.asm)
Pobierz dwie cyfry a i b z klawiatury za pomocą przerwania 21h
i wykonaj poniższe operacje:

1. Dodaj a i b   i wyświetl wynik w postaci znaku ASCII
2. Odejmij a i b   i wyświetl wynik w postaci znaku ASCII
3. Pomnóż a i b   i wyświetl wynik w postaci znaku ASCII
4. Podziel a przez b   i wyświetl wynik w postaci znaku ASCII
*  Wyświetl wykrzyknik, jeśli b wynosi 0 w miejscu wyniku dzielenia.

*  Oddziel wyniki spacją.

*  Odejmij od symboli ASCII przesunięcie.

### [Arithmetical operation procedure](arithmetical-operation-procedure.asm)
Przepisz zadane z ostatnich zajęć, aby generowało identyczny wynik, ale wykorzystując procedury dodawania, odejmowania, mnożenia
i dzielenia. Zamiast wykorzystywać zmiennych do operacji arytmetycznych proszę korzystać ze stosu.

* Można wyłącznie przetrzymywać argumenty a i b w zmiennych.
### [Single-digit Factorial](single-digit-factorial.asm)

Napisz program do liczenia silni, liczby jednocyfrowej* wprowadzanej z klawiatury, wynik wyświetlaj w systemie dziesiętnym za pomocą znaków ASCII.
* Stosuj procedury

* Stosuj stos

* Do wartości 8  - arytmetyka 16 bitowa
### [Caesar Cipher](caesar-cipher.asm)

Napisz program, który pobierze do 25 znaków ASCII z klawiatury za pomocą ah,10. Następnie pobierze przesunięcie szyfru Cezara,
i wyświetli komunikat zakodowany.

* Zapętl alfabet, konwertuj duże litery do małych. Wszystkie inne znaki zamień na spację. Wyświetlanie komunikatów zrealizuj za pomocą ah,9.

Na ocenę bdb:

*  Program ma wczytywać argument do przesunięcia w postaci liczby dziesiętnej
z zakresu 16 bitowego, wielokrotność alfabetu rozwiąż za pomocą dzielenia modulo.

*  Zaprogramuj pełne menu. Powitanie, wybór opcji, wielokrotne kodowanie, zakończenie programu. Pamiętaj o wypełnianiu tablicy dolarami…
### [ONP](onp.asm)

Napisz program, który pobierze do 25 znaków ASCII z klawiatury za pomocą ah,10. Następnie przetworzy wyrażenie z postaci konwencjonalnej i wyświetli w postaci ONP, a następnie wyświetli wynik w postaci dziesiętnej.

- Uwzględnij nawiasy, nawiasy wielokrotne i podstawowe operacje arytmetyczne:
    - Dodawanie, mnożenie
- Zakres danych 16 bitów bez znaku
- Nie używamy koprocesora
### [Final Project](project.asm)
Napisać program, który pobiera ciąg znaków z wejścia i wypisuje na wyjściu łańcuch pozbawiony wielkich liter w nim zawartych. Program powinien móc wielokrotnie powtarzać operację z różnymi ciągami znaków oraz zakończyć pracę po naciśnięciu przez użytkownika klawisza SPACJA. Wykorzystać procedury i stos. Przewidzieć sytuacje wyjątkowe.

