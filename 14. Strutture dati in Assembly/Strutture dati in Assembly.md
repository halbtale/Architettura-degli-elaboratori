## strutture dati in assembly
### array
- Bisogna definire:
	- **indirizzo iniziale** in memoria, $V$
	- **numero di elementi**, $N$
	- **dimensione di ciascun elemento**, $L$ (in byte)
![[14. Strutture dati in Assembly/Immagine 1.png|400]]
### definizione di un array
- Alloco in memoria un segmento di $N*L$ byte
```arm
.bss
V:    .skip N*L
```
### accesso agli elementi dell'array
- Se devo accedere all'i-esimo elemento, lo troverò nella posizione
	- $Ind[V]=V+offset$
	- $offset=i*L$
#### in arm
- Esempio: 
	- $L=4$
	- Si voglia copiare in R2 il valore $V[i]$
```
LDR R0, =V
MOV R1, #i
LDR R2, [R0, R1, LSL #2]
```

<div style="page-break-after: always;"></div>

### matrice
- Bisogna definire:
	- **indirizzo iniziale**, $M$
	- **numero di righe**, $R$
	- **numero di colonne**, $C$
	- **dimensione di ciascun elemento**, $L$
- La memoria è però un vettore unidimensionale
	- la maggior parte dei linguaggi di programmazione alloca per righe
	- ```[[a,b,c,d], [e,f,g,h], [i,l,m,n]]```
```
.bss
M:    .skip R*C*L
```
![[14. Strutture dati in Assembly/Immagine 2.png|200]]
- Morton Layout (+ avanzato)
	- divido matrice in 4 e le metto a Z
	- ogni sotto-matrice la divido per 4 le le salvo a Z
	- ricorsivo...
### accesso agli elementi di una matrice
- Per individuare un elemento ho bisogno di riga $i$ e colonna $j$
	- parto da indirizzo iniziale $M$
	- devo saltare $i$ righe, ciascuna delle quali contiene $C$ locazioni
	- devo poi saltare $j$ colonne per arrivare alla colonna desiderata
	- ogni locazione che salto contiene $L$ byte
```
ind M[i, j] = M + (i*C+j)*L
```
#### in arm
- Esempio
	- voglio copiare R0 in $M[i,j]$
	- L=2 (halfword)
```arm
MOV R1, #i
MOV R2, #j
MOV R3, #C
LDR R4, =M

MUL R3, R1, R2     @calcola R3=i*C
ADD R3, R3, R2     @calcola R3=i*C+j
LSL R3, R3, #1     @calcola R3=(i*C+j)*2
STRH R0, [R4, R3]  @copia R0 in M[i,j]
```

### accesso con array ausiliario di puntatori
- Si può creare un array di puntatori per evitare il prodotto
	- $P[i]$ punta all'indirizzo d'inizio della i-esima riga
```
.bss
M:    .skip R*C*L

.data
P:    .word M, M+C*L, M+2*C*L, ...
```
#### in arm
- Esempio
	- voglio copiare R0 in $M[i,j]$
	- L=2 (halfword)
```
MOV R1, #i
MOV R2, #j
LDR R4, =P

LSL R3, R1, #2         @i*4
LDR R3, [R4, R3]       @indirizzo riga i
ADD R3, R3, R2, LSL #1 @indirizzo di M[i,j]
STRH R0, [R3]          @copia R0 in M[i,j]
```
### accesso con array ausiliario di offset
- Si può utilizzare un array con gli offset di ciascuna riga rispetto all'indirizzo iniziale M
```arm
.bss
M:    .skip R*C*L

.data
O:    .hword 0, C*L, 2*C*L, ...
```
#### in arm
- Esempio
	- voglio copiare R0 in $M[i,j]$
	- L=2 (halfword)
```
MOV R1, #i
MOV R2, #j
LDR R3, =M
LDR R4, =O

LSL R5, R1, #1 @R5=i*2
LDRH R4, [R4, R5] @R4=R4+R5: offset riga i
ADD R4, R4, R2, LSL 1 @R4=R4+(R2*2): offset M[i,j]
STRH R0, [R3, R4] @copia R0 in M[i, j]
```

### stack
- Struttura dati "**LIFO**" (Last In, First Out)
- Consente operazioni
	- ==PUSH==
	- ==POP==
- ==Stack Pointer==
	- punta alla testa dello stack
	- mantenuto nel registro SP
#### tipi di stack
- **Ascending**
	- elementi inseriti da indirizzo + basso a + alto
- **Descending**
	- elementi inseriti da indirizzo + alto a + basso
- **Empty**
	- SP punta al primo elemento vuoto
- **Full**
	- SP punta all'ultimo elemento usato
- Si utilizza ==Full Descending==
### implementazione stack
#### allocazione memoria
- Definizione di un'area di memoria riservata allo stack
![[14. Strutture dati in Assembly/Immagine 3.png|200]]
```arm
	    .equ STL, 4096
	    .skip STL
stack:  .skip 4

LDR SP, =stack
```
#### push
- Operazione di push del nuovo elemento R0
```
SP = SP - 4
M[SP] = R0
```
#### pop
- Operazione di pop e salva ultimo elemento in R0
```
R0 = M[SP]
SP = SP + 4
```
#### pop e push multipli
- I registri con indirizzo di memoria + grandi vengono messi negli indirizzi di memoria + grandi
```
PUSH {R0, R5, R2, R1, R6, R7, R3, R4}
@ovvero
PUSH {R7}
PUSH {R6}
PUSH {R5}
PUSH {R4}
PUSH {R3}
PUSH {R2}
PUSH {R1}
PUSH {R0}
```
- Quando vengono estratti vengono assegnati dal registro + piccolo a + grande
```
POP {R0-R7}
@ovvero
POP {R0}
POP {R1}
POP {R2}
POP {R3}
POP {R4}
POP {R5}
POP {R6}
POP {R7}
```

<div style="page-break-after: always;"></div>

### linked list
- Ogni elemento della lista contiene
	- ==campo puntatore==
		- 4 byte
		- punta all'indirizzo successivo
		- se è l'ultimo elemento o la lista è vuota punta a NIL (valore speciale)
	- ==campo== che contiene i ==dati== associati all'elemento della lista
- ==HEAD==
	- contiene puntatore al primo elemento della lista
![[14. Strutture dati in Assembly/Immagine 4.png]]
```
		.equ NIL, -1
HEAD:   .word NIL
```

#### accesso
- Se R1 punta a un elemento, con questa istruzione punterà al successivo
	- l'indirizzo a cui punta inizialmente in memoria R1 contiene l'indirizzo dell'elemento successivo
```
LDR R1, [R1]
```
#### inserzione
- Inserzione alla fine della lista di un elemento il cui indirizzo si trova in R0
	- faccio loop della lista e trovo ultimo elemento
	- cambio puntatore dell'ultimo elemento da NIL a quello di R0
	- in R0 metto puntatore a NIL
```
		LDR R1, =HEAD    @puntatore iniziale
		MOV R3, #NIL     @R3=NIL
		
CERCA:  LDR R2, [R1]     @R2 conterrà il puntatore successivo
		CMP R2, #NIL     @controlla se R2 è l'ultimo elemento (NIL)
		BEQ ULTIMO       @se è l'ultimo elemento, salta a ULTIMO
		MOV R1, R2       @altrimenti passa alla prossima iterazione
		B CERCA

ULTIMO: STR R0, [R1]     @salva indirizzo R0 nell'ultima posizione
		STR R3, [R0]     @ora fai puntare R0 a NIL
```
![[14. Strutture dati in Assembly/Immagine 5.png|500]]

#### estrazione
- Estrazione del primo elemento
	- se è vuota non faccio nulla
	- trovo indirizzo secondo elemento
	- sposto HEAD dal puntatore del primo elemento al secondo
```
		LDR R1, =HEAD    @puntatore iniziale
		LDR R0, [R1]     @R0=puntatore al primo elemento
		CMP R0, #NIL     @controlla se lista è vuota
		BEQ VUOTA        @se è vuota, non estrarre
		LDR R2, [R0]     @R2=puntatore al secondo elemento
		STR R2, [R1]     @HEAD ora punta a R2
VUOTA:
```
![[14. Strutture dati in Assembly/Immagine 6.png|500]]
#### inserzione elemento in posizione generica
- Inserisco R2 nella posizione successiva di quello puntato da R1
![[14. Strutture dati in Assembly/Immagine 7.png|500]]
#### unione di due liste
- Siano LC1 e LC2 due Linked List
- R0 -> indirizzo ultimo elemento LC1
- R2 -> indirizzo primo elemento LC2
- Rimuovere primo elemento di LC2 e agganciare l'intera lista LC2 in coda a LC1 ![[14. Strutture dati in Assembly/Immagine 8.png|600]]
