## codifica delle istruzioni
### formati delle istruzioni
- I bit sono raggruppati in campi
- Devono includere
	- Tipo di istruzione (**opcode**)
	- Tipo di indirizzamento di ogni operando
		- può essere implicito nei primi campi
	- Indirizzo di ogni operando
### allocazione dei bit
- Quanti bit usare per ogni campo?
- Dipende da
	- modi di indirizzamento
		- se c'è solo un modo servono meno bit rispetto a se ci sono + modi
	- numero di operandi
		- istruzioni con 2 operandi hanno + bit ciascuno rispetto a istruzioni con 3 operandi
	- registri vs memoria
	- numero gruppi di indirizzi 
	- intervallo/granularità indirizzi
### lunghezza delle istruzioni
- Lunghezza dipende da
	- dimensione/organizzazione/struttura memoria
		- es. quanti bit servono per indicare indirizzo
	- complessità/velocità del processore
	- uguale o multiplo di una word (unità base)
	- multiplo della lunghezza di un carattere
#### istruzioni a lunghezza variabile (in x86)
- **PRO**
	- maggiore numero di possibili opcode
	- indirizzamenti più flessibili
- **CONTRO**
	- aumenta la complessità per il processore
	- possono essere richiesti più fetch per leggere un'istruzione
#### istruzioni a lunghezza fissa (in arm)
- **PRO**
	- semplifica complessità per il processore
- **CONTRO**
	- riduzione del numero di operazioni e di indirizzamenti
### codifica nell'architettura x86
![[13. Codifica delle istruzioni/Immagine 1.png|600]]
- Instruction prefix
	- dà informazioni su quanto lunga è l'istruzione

<div style="page-break-after: always;"></div>

### codifica nell'architettura aRM
![[13. Codifica delle istruzioni/Immagine 2.png|700]]
- ==Cond==
	- condizione (es. esegui sempre o solo in una determinata condizione)
- ==Classe==
	- quale delle classi usare per codificare l'istruzione
- ==Tipo==
	- opcode (es. add)
- ==Modifica dei bit di stato==
	- se modificare i bit di stato o meno
- ==Registri e valori immediati==
### classi di istruzioni
#### data processing
- ==Data processing Immediate==
	- ```ADD R0, R1, #3```
- ==Data Processing Register Shift==
	- ```ADD R0, R1, R2```
- ==Data Processing Immediate Shift==
	- ```ADD R0, R1, R3 LSL #2```
#### load/store
- ==Load/Store Register Offset==
	- ```LDR R0, [R2]```
	- ```STR R0, [R2]```
- ==Load/Store Multiple==
	- ```PUSH {R0, R2, R3}```
#### branch
- ==Branch with link==
	- ```BEQ loop```
### codifica di valori immediati
![[13. Codifica delle istruzioni/Immagine 6.png|300]]
- ==c==
	- 8 bit
	- definiscono un valore
- ==r==
	- 4 bit
	- rotazione a destra di 2r posizioni
- Non posso rappresentare tutti i numeri (no 0x102)
	- il numero deve rimanere dentro agli 8 bit con le rotazioni
	- non posso shiftare di numeri dispari
- Posso usare la pseudo-istruzione per salvarlo in memoria
	- ```LDR R0, =0x102```
### esempio
- Istruzione: ```ADD R0, R1, #0x104```
- Codifica hex: ```E2810F41```
![[13. Codifica delle istruzioni/Immagine 3.png|500]]
- Significato dei bit
	- **Cond**: esegui sempre  
	- **Classe**: Data processing immediate 
	- **Tipo**: ADD  
	- **Modifica registro di s**tato: no 
	- **Registro sorgente**: R1  
	- **Registro destinazione**: R0  
	- **Valore immediato**: 0x104
### reference 
![[13. Codifica delle istruzioni/Immagine 7.png|400]]
![[13. Codifica delle istruzioni/Immagine 8.png|600]]
