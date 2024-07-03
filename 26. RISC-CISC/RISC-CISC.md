## risc vs cisc
### cisc (complex instruction set computer)
- **ISA** caratterizzata da:
	- **tanti** tipi di **istruzioni**
		- + complesse e flessibili
		- possono occupare più di una word e avere lunghezza variabile
		- permettono di accedere anche direttamente alla memoria
	- **pochi registri**
- Istruzioni eseguite tramite **microcodice**
	- unità di controllo che decompone ogni istruzione in sottoparti
- **Obiettivo**:
	- ridurre numero di istruzioni necessarie per creare il programma
	- utile per il programmatore
		- in origine si programmava in assembly
- Problema
	- chip complesso da realizzare a livello elettronico
	- difficile da ottimizzare programma
### risc (reduced instruction set computer)
- Introdotta da **Patterson** e **Hennessy**
	- vincono **Turing Award**
- **ISA** caratterizzata da
	- **pochi** tipi di **istruzioni**
		- semplici
		- brevi: lunghezza fissa (~ 1 word)
		- lavorano solo su registri o semplici operazioni di lettura/scrittura in memoria
		- poche tecniche di indirizzamento
	- **tanti registri**
- Vantaggi
	- se il programma è fatto da tante istruzioni semplici, è più facile da ottimizzare a livello hardware
	- **pipeline**
		- istruzioni più corte e prevedibili
		- meno possibilità di stallo
	- si può ottimizzare ulteriormente con tecniche adottate dal compilatore
		- es. **loop unrolling**
- Svantaggi
	- richiede programmi più lunghi
		- non è più un problema poiché non si programma direttamente in assembly
### costo esecuzione programma
- $T_E=N_{C}\cdot C_{I} \cdot T_{C}$
- CISC cerca di ridurre numero istruzioni
- RISC cerca di ridurre numero di cicli per interpretare istruzione
### esempi di processori risc
- Ormai tutti i processori sono RISC
- Computer x86 sono apparentemente CISC ma in realtà internamente le istruzioni vengono scomposte in RISC
	- convertite internamente dall'hardware
