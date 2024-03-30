## introduzione ad assembly
### introduzione
- **Architettura di un elaboratore**
	- parte visibile al programmatore
- **Istruzioni macchina**
	- sequenze di byte interpretabili dal processore
- **Linguaggio assembly**
	- livello di astrazione superiore al linguaggio macchina
	- ogni istruzione macchina viene codificata in una stringa alfanumerica
### instruction set architecture (Isa)
- Caratteristiche
	- **tipo di dato**
	- **registri**
	- **caratteristiche delle istruzioni**
	- **indirizzamento**
	- **codifica delle istruzioni**
- Visione semplificata dell'hardware
	- non vede funzionamento interno dei moduli
	- vede solo un sottoinsieme dei registri
		- es. MAR/MBR,IR non visibili
### dati
- Tipologie di dati
	- numeri
	- caratteri
	- dati logici
	- indirizzi
- Dimensione dati ARM
	- byte = 8 bit
	- half-word = 16 bit
		- indirizzi multipli di 2
	- word = 32 bit
		- indirizzi multipli di 4
### registri
- 16 registri accessibili in ARM
#### registri generici
- R0-R10
- Utilizzati per memorizzazione di dati temporanei

#### registri con utilizzi particolari
- R11: ==FP==
	- Frame Pointer
	- utilizzato per implementare funzioni
- R12: ==IP==
	- Scratch register
- R13: ==SP==
	- Stack Pointer
	- contiene puntatore ad uno stack nella memoria (usato da push/pop)
- R14: ==LR==
	- Link register
	- utilizzato per implementare funzioni
- R15: ==PC==
	- Program Counter
	- punta all'istruzione in memoria successiva
	- ```PC = CURRENT_IND + 4```
	- in realtà internamente punta a +8
		- ARM usa pipeline quindi inizializza già l'istruzione successiva
		- PC quindi conta all'indirizzo successivo all'istruzione successiva
#### current program status register (cpsr)
- Registro di stato
	- contiene informazioni sullo **stato** della macchina
- Presenta flag di 1 bit:
	- ==N==: **Negative**
		- $N=1$ se l'ultimo risultato era negativo
	- ==Z==: **Zero**
		- $Z=1$ se l'ultimo risultato era zero
	- ==C==: **Carry**
		- bit di riporto
	- ==V==: **Overflow**
		- $V=1$ se c'è stato un overflow
### operazioni aritmetico logiche
#### Operazioni aritmetiche
- ```ADD, SUB, MUL```
-  Per numeri interi e floating point
#### operazioni logiche
- ```AND, OR, EOR```
#### istruzioni di rotazione
- ```LSL, LSR, ASR, ROR```
- Shift
	- aritmetici (corrispondono a moltiplicazioni/divisioni per 2 in complemento a 2)
	- logici (spostano bit a destra e sinistra)
- Rotazione (a destra o sinistra)
![[10. Introduzione ad Assembly/Immagine 1.png|600]]
#### istruzioni di confronto
- ```CMP, TST, TEQ``` 
### trasferimento dati
- Istruzioni per trasferire dati 
	- ```MOV```: operazione da registro a registro
	- ```LDR```: operazione da memoria a registro
	- ```STR```: operazione da registro a memoria
	- ```PUSH/POP```: operazione di pop/push in uno stack
		- usano un registro speciale (SP)
- Informazioni richieste
	- indirizzo sorgente, destinazione
	- modo in cui vengono indicati gli indirizzi
	- lunghezza del dato da trasferire
### input/output
- Istruzioni per gestire I/O e muovere dati da/verso I/O
- In ARM non ci sono istruzioni specifiche per I/O
	- vengono usate le stesse della memoria
### trasferimento di controllo
- Salto (branch)
	- ```b```: incondizionato
	- ```bXX```: condizionato
- Salto di istruzione (skip)
	- esegui istruzione solo se condizione è verificata
	- si aggiungono due caratteri alla fine di istruzione (es ```addXX```)
	- ```XX=GT,GE,LT,LE,EQ,NE```
- Chiamata a procedura (procedure call)
	- invoca una funzione
	- ```BL``` (branch and link) 
<div style="page-break-after: always;"></div>

### operandi di un'istruzione
- Operandi specificano dove trovare valori input e dove salvare risultato
- Tipologie
	- **esplicito**
		- l'istruzione definisce l'operando
		- + lento da processare ma + flessibile
	- **implicito**
		- l'operando assume un valore predefinito e non viene rappresentato nell'istruzione
- A livello di ISA, uno può creare le stesse istruzioni con 0,1,2,3,4 operandi
- ARM
	- 0 operandi (nop)
	- 1 operando (salti)
	- 2 operandi (confronti, spostamento dati)
	- 3 operandi (somme, sottrazioni)
	- 4 operandi (prodotto con somma)