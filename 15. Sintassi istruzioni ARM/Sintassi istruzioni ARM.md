## sintassi istruzioni arm
### Registro di stato cpsr
- Le istruzioni di confronto modificano i bit NZCV
- Una generica istruzione modifica i bit NZCV solo se si aggiunge il suffisso S
### istruzioni condizionate
- Tutte le istruzioni ARM possono essere rese condizionate
	- dipendere dai bit NZCV modificati da una istruzione precedente
- Basta aggiungere il suffisso della condizione
### architettura risc
- Le istruzioni non contengono mai indirizzo di memoria, può essere salvato solo nei registri
- Indirizzamento in memoria solo con istruzioni LDR e STR
### classe di sintassi 1: elaborazione dati
#### operazioni a 3 indirizzi
- ```ADC, ADD, AND, BIC, EOR, ORR, RSB, RSC, SBC, SUB```
	- es: ```ADD R0, R1, R2```
- ==```<opcode>{<cond>}{S} <Rd>, <Rn>, <shifter_operand>```== 
	- ```<cond>```: stabilisce l'esecuzione condizionata
	- ```S```: stabilisce se modifica i bit di condizione
	- ```<Rd>```: destinazione (Rd è sempre specificato per primo)
	- ```<Rn>```: primo operando
	- ```<shifter_operand>```: secondo operando
#### operazioni a 2 indirizzi
- ```CMN, CMP, MOV, MVN, TEQ, TST```
	- es. ```MOV R0, #0```
- ==```<opcode>{<cond>}{S} <Rd>, <shifter_operand>```==
	- ```<cond>```: stabilisce l'esecuzione condizionata
	- ```S```: stabilisce se modifica i bit di condizione
	- ```<Rd>```: destinazione (Rd è sempre specificato per primo)
	- ```<shifter_operand>```: operando
#### operatori
- ```<shifter_operand>```:
	- un valore immediato: ```#<valore>```
	- un registro: ```Rm```
	- un registro con scorrimento dato da:
		- un valore immediato: ```Rm, <sop> #<shift_imm>```
		- un registro: ```Rm, <sop> Rs```
- ```<sop>```
	- ```LSL```: logico a sinistra
	- ```LSR```: logico a destra
	- ```ASR```: aritmetico a destra
	- ```ROR```: rotazione a destra
	- ```RRX```: 33 bit rotazione a destra right usando il bit C come 33° bit
	- valore di shift può essere specificato da valore immediato o registro

>[!info] Non si può accedere direttamente alla memoria in questo tipo di istruzioni

### classi di sintassi 2 e 3: load/store
- ```LDR```
	- carica un valore dalla memoria al registro
	- ```LDR R0, [R1]```
- ```STR```
	- salva un valore dal registro alla memoria
	- ```STR R0, [R1]```
#### opzioni particolari
- Si può modificare la dimensione di lettura/scrittura aggiungendo suffissi
	- ```B```: byte
	- ```H```: halfword
	- ```SB```: byte con segno
		- solo su LDR: i bit più significativi liberi nel registro vengono impostati al segno
	- ```SH```: halfword con segno
		- solo su LDR: i bit più significativi liberi nel registro vengono impostati al segno
![[15. Sintassi istruzioni ARM/Immagine 1.png|300]]
#### sintassi classe 2 (word/unsigned byte)
- ==```LDR|STR{B} Rd, <addressing_mode2>```==
- ```<addressing_mode2>```: indirizzamento registro indiretto
	- senza offset
	- offset immediato: ```[Rn, #±<offset_12>]```
	- offset da registro: ```[Rn, ±Rm]```
	- offset da registro scalato: ```[Rn, ±Rm, <sop> #<shift_imm>]```
	- pre-incremento immediato: ```[Rn, #±<offset_12>]!```
	- pre-incremento da registro: ```[Rn, ±Rm]!```
	- pre-incremento da registro scalato: ```[Rn, ±Rm, <sop> #<shift_imm>]!```
	- post-incremento immediato: ```[Rn], #±<offset_12>```
	- post-incremento da registro: ```[Rn], ±Rm```
	- post-incremento da registro scalato:  ```[Rn], ±Rm, <sop> #<shift_imm>```
#### sintassi classe 3 (halfword/signed byte)
- ==```STR|LDR[H] Rd, <addressing_mode3>```==
- ==```LDR[SH|SB] Rd, <addressing_mode3>```==
- ```<addressing_mode3>```: indirizzamento registro indiretto
	- differenze con ```<addressing_mode2>```:
		- non si possono scalare i registri
		- offset solo da 8 byte
### caricare un valore immediato
- Non posso caricare un **qualsiasi** valore immediato, solo alcuni consentiti
- Metodo 1. carico valore con MOV e poi lo manipolo (somme e shift)
- Metodo 2. uso pseudoistruzione
	- ==```LDR Rd, =numero```==
	- assemblatore espande la pseudoistruzione in più istruzioni macchina
		- viene creato uno spazio in memoria contenente il numero e vi si accede tramite indirizzamento autorelativo
![[15. Sintassi istruzioni ARM/Immagine 2.png|300]]
