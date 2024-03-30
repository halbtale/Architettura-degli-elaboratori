## introduzione a programmazione in aRM
### struttura del programma
- Insieme di **istruzioni assembly**
	- istruzione assembly ≠ istruzione macchina
	- (quasi) diretta corrispondenza
	- confine + vicino tra hardware e software per il programmatore
- Programma assembly viene **compilato**
	- fase 1: assemblaggio
	- fase 2: linkaggio
- Programma eseguibile
	- contiene dati, istruzioni, punto di ingresso
### direttive e simboli
- ==Simboli==
	- stringhe che denotano particolari valori
	- ==Label==: indica indirizzo di memoria di una particolare istruzione
		- esempio: ```main:, lamiaistruzione:```
	- ```.equ COSTANTE, #1```
		- definisce simbolo per valore numerico
- ==Direttive==
	- istruzioni per l'assemblatore
	- esempi: ```.space, .global, .data, .bss```
### punto di inizio
- Definito dalla label main
```arm
.global main
main: 
	MOV R0, #10
```
### commenti
- Preceduti da ```@```
### sintassi di un'istruzione
```arm
label: istruzione operandi @commento
```
- Label deve cominciare dal primo carattere
- Istruzione deve essere indentata
- Case Insensitive
### allocazione dati
- È possibile allocare spazio per variabili attraverso direttive
```arm
maschera: .word 0xAAAAAAAA
stringa: .ascii "Pippo"
output: .space 4
```
- ```.word, .hword, .byte```: inizializza variabili
- ```.ascii```: inizializza una stringa
- ```.space, .skip```: allocano aree di memoria (```.space inizializza a zero```)
### segmenti di un programma
#### text
- Contiene le istruzioni
- Preceduto da ```.text```
#### data
- Contiene dati inizializzati
- Preceduto da ```.data```
#### bss
- Contiene dati non inizializzati
- Preceduto da ```.bss```
