## allocazione dinamica
### la rientranza
- Subroutine si dice **rientrante** se di essa può iniziare una nuova esecuzione mentre è ancora in corso una sua esecuzione precedente
#### quando?
- in seguito a una ==chiamata ricorsiva==
	- funzione che chiama se stessa
- in seguito a un'==interrupt==
	- funzione viene congelata non appena arriva l'interrupt, viene eseguita la funzione di supporto dell'interrupt che potrebbe chiamare la medesima funzione congelata, e poi riprende l'esecuzione della funzione iniziale
	- non controllabile dal programmatore
- in un ==sistema multiprocessore==
	- la stessa funzione può essere eseguita contemporaneamente in più processori
#### requisiti di una subroutine rientrante
- **NON** deve alterare i dati su cui stava operando ogni sua attivazione precedente non terminata
- Subroutine come ==pure code==
	- deve contenere solo codice, non indirizzi di memoria
	- i dati **NON** fanno parte della subroutine
	- i dati appartengono all'**istanza di esecuzione**
- Ad ogni sua invocazione deve allocare i dati su un **luogo diverso**:
	- ==dati locali== 
		- variabili locali
	- ==parametri di ingresso e di uscita==
		- incluso indirizzo di ritorno
### allocazione dinamica della memoria
- Salvo i dati della subroutine nello **stack**
	- ad ogni esecuzione si troveranno in indirizzi di memoria diversi
- Problema:
	- è difficile calcolare la posizione dei dati sulla base di SP dato che cambia in continuazione
#### utilizzo dello stack-frame
- Ogni istanza della funzione ha accesso a uno **stack-frame**
	- spazio allocato in cima allo stack per la singola esecuzione di una subroutine
	- vengono inseriti **dati locali** e **parametri**
	- ci può essere **solo** un frame attivo alla volta
- ==Frame Pointer==
	- punta all'indirizzo dello stack da cui parte lo spazio allocato per una funzione
	- rimane fissa
	- ARM: si trova nel registro ==FP== (R11)
### allocazione e rilascio di un frame
- La creazione del frame non viene fatta dal sistema operativo in automatico
	- viene fatta dal compilatore quando si programma in linguaggi ad alto livello
- Allocazione dinamica memoria
	- push {FP}
		- salvo frame pointer precedente nello stack
	- FP = SP
		- faccio puntare il frame pointer nell'indirizzo d'inizio dello spazio allocato
	- SP = SP - e 
		- sposto lo stack pointer allocando $e$ indirizzi per dati della funzione
- Rilascio dinamico memoria
	- SP = FP
		- sposto lo stack pointer indietro fino all'indirizzo del frame pointer
		- in questo modo lo spazio allocato per la funzione è come se venisse eliminato
	- pop {FP}
		- viene ripristinato il valore precedente all'invocazione della funzione

<div style="page-break-after: always;"></div>

### struttura stack frame
- Convenzione GCC
	- parametri ingresso prima del nuovo frame
	- vecchi valori LR e FP
		- ```PUSH {LR, FP}```
	- nuovo frame inizia dalla word che contiene vecchio FP
		- ```MOV FP, SP```
	- al di sopra: salvataggio altri registri
	- al di sopra: variabili locali
![[18. Allocazione dinamica/Immagine 1.png|400]]
>[!info] Offset rispetto a FP
>- negativi: dati esecuzione attuale della funzione
>- positivi: parametri di ingresso/uscita

### passaggio dei parametri di input
- **Pochi parametri**
	- si usano i registri r0, r1, r2, r3, r4, r5, r6
	- + veloce
- **Molti parametri**
	- alcuni nei registri, altri nello stack
 
<div style="page-break-after: always;"></div>


### esempio di subroutine ricorsiva
![[18. Allocazione dinamica/Immagine 2.png|600]]
#### main()
- Viene allocato un nuovo frame-pointer

```
@ int main() {

main:
	PUSH {FP, LR} @salvo i valori precedenti di FP e LR nello stack
	MOV FP, SP    @FP punta all'inzio del nuovo frame allocato
```
![[18. Allocazione dinamica/Immagine 3.png]]
<div style="page-break-after: always;"></div>

- Allocato lo spazio per i dati locali
```
	@ int W, X, Y, Z 

	SUB SP, SP, #16     @alloco 16 byte (4 interi di 4 byte)
```
![[18. Allocazione dinamica/Immagine 4.png|300]]
- Chiamata alla subroutine R
```
	@R(X,Y,&Z)

	LDR R0, [FP, #-8]   @carica X in R0
	PUSH {R0}           @inserisci X nello stack (parametro ingresso)

	LDR R0, [FP, #-12]  @carica Y in R0
	PUSH {R0}           @inserisci Y nello stack (parametro ingresso)

	SUB R0, FP, #16     @carica indirizzo di Z in R0
	PUSH {R0}           @salva indirizzo di Z nello stack (parametro ingresso)

	BL R                @salta alla label della funzione e aggiorna LR

	ADD SP, SP, #12     @rilascia l'area di memoria allocata per i parametri
```
![[18. Allocazione dinamica/Immagine 5.png|300]]
- Termine del main
```
	@ }

	MOV SP, FP           @rilascia area di memoria allocata per stack-frame
	POP {FP, PC}         @ripristina stato precedente di FP e salta a LR salvato

```
#### r(i, j, \*o)
- Allocazione del nuovo frame pointer
```
@ void r(int I, int J, int *O) {

R:
	PUSH {FP, LR}       @salva valori precedenti di FP e LR
	MOV FP, SP          @fai puntare FP all'inizio dello stack frame
```
![[18. Allocazione dinamica/Immagine 6.png|300]]
- Allocato lo spazio per i dati locali
```
	@ int A, B, C

	SUB SP, SP, #12   @allocati 12 byte (3 interi di 4 byte)
```
![[18. Allocazione dinamica/Immagine 7.png|300]]
<div style="page-break-after: always;"></div>

- Utilizzo dei parametri di ingresso della funzione
```
	@ *O = I+J

	LDR R0, [FP, #16]  @carica I in R0
	LDR R1, [FP, #12]  @carica J in R1
	ADD R0, R0, R1     @calcola I+J e salva risultato in R0
	LDR R1, [FP, #8]   @carica in R1 l'indirizzo di O
	STR R0, [R1]       @salva risultato alla cella di memoria all'indirizzo R1

```
- If statement
```
	@ if (A==0)

	LDR R0, [FP, #-4]  @carica in R0 il valore di A
	CMP R0, #0         @controla A==0?
	BNE END_IF         @se la condizione non è soddisfatta salta blocco if	
	...


END_IF:
	...
```

<div style="page-break-after: always;"></div>

- Blocco interno dell'if con chiamata ricorsiva della funzione
```
	@R(A, B, &C)

	LDR R0, [FP, #-4]  @carica A in R0
	PUSH {R0}          @inserisci A nello stack (parametro ingresso)

	LDR R0, [FP, #-8]  @carica B in R0
	PUSH {R0}          @inserisci B nello stack (parametro di ingresso)

	SUB R0, FP, #12    @calcola indirizzo di C e mettilo in R0
	PUSH {R0}          @inserisci indirizzo di C nello stack (parametro ingresso)

	BL R               @chiama la funzione e aggiorna LR

	ADD SP, SP, #12    @rilascia area di memoria allocata per parametri ingresso
```
![[18. Allocazione dinamica/Immagine 8.png|200]]
- Termine della funzione R
```
	@ }

	MOV SP, FP       @rilascia area di memoria allocata per stack-frame
	POP {FP, PC}     @ripristina FP precedente e salta a LR salvato
```