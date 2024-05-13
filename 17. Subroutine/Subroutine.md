## subroutine
### chiamata a procedura
- Una **Procedura/subroutine/funzione** è una sequenza di istruzioni che può essere invocata da un altro programma
- Vantaggi
	- **riusabilità** e **modularità** del codice
- Meccanismo di chiamata richiede:
	- **istruzione per chiamare la procedura**
	- **istruzione per tornare al punto iniziale**
		- all'istruzione successiva a quella di chiamata
### definire una funzione
- In assembly si utilizza una **label** per definire l'indirizzo di inizio della funzione
```
FUN: istruzione 1
	 istruzione 2
```

### chiamare una funzione
- Si utilizza B o BL 
```
BL FUN
```

### ritorno da funzione
- **Indirizzo di ritorno**
	- indirizzo dell'istruzione successiva a quella di chiamata
- Per "tornare indietro", è necessario inserire in PC l'indirizzo di ritorno
### implementazioni delle chiamate a procedura
#### 1ª soluzione 
- Salvo l'indirizzo di memoria in una locazione di memoria adibita a tale scopo
```
	MOV r0, #ind @indirizzo in memoria dove salvare l'indirizzo di ritorno
	LDR r1, =rit @carica in r1 l'indirizzo di ritorno
	STR r1, [r0] @salva indirizzo di ritorno in memoria nel punto indicato da r0
	B PROC       @chiama la funzione
RIT:...istruzioni varie...

PROC:
	...istruzioni varie...
	MOV r0, #ind @indirizzo in memoria dove trovare l'indirizzo di ritorno
	LDR r1, [r0] @carica in r1 l'indirizzo di ritorno
	MOV pc, r1   @torna all'indirizzo di ritorno
```

> [!warning] Limitazione
> - Se la subroutine ne chiamasse un'altra, verrebbe perso l'indirizzo di ritorno (sovrascritto)
> - Accesso in memoria è lento
#### 2ª soluzione 
- L'indirizzo di ritorno viene salvato nella prima locazione di memoria di ciascuna subroutine
	- convenzione che le istruzioni eseguibili siano collocate dalla cella di memoria successiva
```
	LDR r0, =PROC @indirizzo dove salvare indirizzo di ritorno
	LDR r1, =RIT  @carica in r1 l'indirizzo di ritorno
	STR r1, [r0]  @salva indirizzo di ritorno in memoria nel punto indicato da r0
	B PROC+4      @salta alla prima istruzione eseguibile della funzione
RIT:...istruzioni varie...

PROC: .space 4    @word per l'indirizzo di ritorno
	...istruzioni varie...
	MOV r0, =PROC @indirizzo in memoria dove trovare l'indirizzo di ritorno
	LDR r1, [r0]  @carica in r1 l'indirizzo di ritorno
	MOV pc, r1    @torna all'indirizzo di ritorno
```

>[!warning] Limitazione
>- Questa implementazione consente alla subroutine di chiamarne un'altra
>- Non supporta invocazioni ricorsive (verrebbe sovrascritto indirizzo di ritorno)
#### 3ª soluzione 
- Indirizzo di ritorno viene salvata in un registro invece che in memoria
```
	LDR r14, =RIT @salva indirizzo di ritorno nel registro r14
	B PROC
RIT:...istruzioni varie

PROC:
	...istruzioni varie...
	MOV pc, r14   @vai all'indirizzo di ritorno (salvato nel registro r14)
```

>[!success] Vantaggi
>- Utilizzare i registri rende la chiamata molto veloce

>[!warning] Svantaggi
>- Ogni volta che la subroutine ne chiama un'altra devo usare un registro diverso, e ci sono pochi registri disponibili
#### 4ª soluzione 
- Indirizzo di ritorno viene memorizzato in uno stack con un'operazione di push
```
	LDR r14, =RIT  @salva in r14 indirizzo di ritorno
	PUSH {r14}     @salva registro nello stack
	B PROC
RIT:...istruzioni varie...

PROC:
	...istruzioni varie...
	POP {pc}       @carica in pc il valore nello stack dell'indirizzo di ritorno
```

>[!success] Vantaggi
>- Consente di chiamare un'altra subroutine o se stessa ricorsivamente senza mai perdere indirizzo di ritorno (salvato in una posizione sicura: lo stack)
>- Può essere rientrante (+ esecuzioni parallele)

>[!warning] Svantaggi
>- L'accesso in memoria è lento

### chiamate a procedure in arm
- ==Compilatore GCC== per ARM usa un mix di soluzione 3 e 4
- Per invocare una procedura salva l'indirizzo di ritorno in r14 (==LR==, link register)
- Se è necessario invocare altre procedure all'interno della procedura, si salva il precedente valore di LR nello ==stack==
- Compromesso tra **efficienza** e **flessibilità**
#### implementazione con "bl"
- ==BL: Branch and link==
	- ```BL FUN```
	- salva indirizzo istruzione successiva a BL in LR
	- carica nel PC l'indirizzo della subroutine (effettua il salto)
- Per tornare indietro, semplicemente
	- ```MOV PC, LR```
### passaggio dei parametri
- Veicolo principale per passare i parametri: utilizzo dei registri
#### parametri in ingresso e in uscita
- ==In ingresso==
	- dati passati alla subroutine
- ==In uscita==
	- risultati restituiti dalla subroutine
#### parametri per valore o per indirizzo
- ==Per valore==
	- il registro conterrà direttamente il valore da utilizzare nella subroutine
	- eventuali modifiche non coinvolgono il valore originario
- ==Per indirizzo==
	- il registro passato contiene l'indirizzo di memoria dove trovare il valore
	- la subroutine può accedere al valore originario e modificarlo
<div style="page-break-after: always;"></div>

### preservare stato programma durante l'esecuzione di una subroutine
#### disciplina della programmazione
- Durante l'esecuzione di una subroutine, deve modificare solo **ciò che è esplicitamente previsto che la subroutine modifichi**, ovvero i valori in uscita
- Se la subroutine modifica valori originari, può causare effetto collaterale indesiderato
#### utilizzo dello stack
- Una subroutine può aver bisogno di utilizzare i registri per calcolare dei valori intermedi
- Conviene usare lo stack per:
	- **salvare il contenuto dei registri**
	- **ripristinare il contenuto dei registri**
```
	BL SUB1

SUB1:
	PUSH {lr, r0-r2} @salva nello stack LR e i registri input
	...istruzioni varie...
	BL SUB2          @chiamata di una funzione annidata
	...istruzioni varie...
	POP {lr, r0-r2}  @ripristina valore originale LR e registri input
	MOV pc, lr
```

>[!failure] Attenzione
>- Non bisogna salvare nello stack il registro di output altrimenti viene sovrascritto durante il POP invece di contenere il valore calcolato dalla subroutine

