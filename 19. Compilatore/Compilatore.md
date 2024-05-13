## compilatore
### processo di produzione del software
- **Analisi** del problema
- **Progettazione** del programma
- **Scrittura** del programma
![[19. Compilatore/Immagine 1.png|600]]
### sistema di sviluppo in linguaggio assembly
- ==Text Editor==
	- programma per scrittura/modifica codice sorgente
- ==Assemblatore==
	- traduce codice sorgente di un file in modulo oggetto
- ==Linker==
	- mette insieme i diversi moduli e crea un unico eseguibile
- ==Loader==
	- programma per caricare in memoria programma eseguibile
- ==Debugger==
	- permette di eseguire passo passo le istruzioni codificate
	- ```gdb```o ```gdbgui```
![[19. Compilatore/Immagine 2.png|700]]
### moduli sorgenti
- Presenta due tipi di istruzioni
	- ==istruzioni assembly==
		- coincidono con le istruzioni macchina
	- ==istruzioni per l'assemblatore==
		- direttive (```.word```, ```.skip```)
		- pseudoistruzioni (```ldr r0, =label```)
### simboli
- Stringhe alfanumeriche con un significato particolare
- **Tipologie**
	- di ==sistema==
		- rappresentano OPCODE, registri, tecniche di indirizzamento
	- ==label==
		- rappresentano indirizzi di memoria
	- ==costanti==
		- ```.equ costante, 3```
- **Classificazione**
	- ==locali==
		- utilizzabili solo all'interno del file
	- ==globali==
		- definito nel modulo e visibili all'esterno
		- si definiscono con ```.global```
	- ==esterni==
		- visibili nel modulo ma definiti in un modulo esterno
- **Valore**
	- ==assoluto==
		- valore NON cambia (es .equ)
	- ==da rilocare==
		- valore dipende dalla posizione in codice in memoria (es label)
#### forward reference
- Utilizzo di un simbolo prima della sua definizione
![[19. Compilatore/Immagine 3.png|200]]
### il programma assemblatore
- Operazioni effettuate
	- traduce **istruzioni assembly** in **istruzioni macchina**
	- esegue direttive
	- sostituisce simboli con il loro valore
- Viene generato ==modulo oggetto==
	- comando: ```as -o main.o main.s```
	- ```main.s -> main.o```
- Può generare un file di **listing** utile per debug
- Segnala eventuali errori di compilazione
![[19. Compilatore/Immagine 4.png|600]]
#### funzionamento dell'assemblatore
- Effettua **due scansioni** del file di input
	- Avere due scansioni permette di gestire le forward reference
- Mantiene un ==LC (Location Counter)==
	- indica indirizzo nella memoria in cui verrà salvata l'istruzione 
		- parte da indirizzo zero
	- viene incrementato ad ogni istruzione letta
#### prima scansione
- Cerca tutte le definizioni dei simboli
- Viene costruita la ==tabella dei simboli==
	- per ogni simbolo definito contiene
		- **nome** simbolo
		- **valore**
		- **scope** (locale/globale)
- Operazioni effettuate
	- 1. leggi riga codice sorgente
	- 2. se contiene un simbolo, aggiungilo alla tabella dei simboli
	- 3. incrementa LC del numero di byte necessari per codificare la riga letta
	- 4. ritorna al passo 1
#### seconda scansione
- **Risolve simboli** e **converte istruzioni**
	- Ogni simbolo presente nella tabella viene sostituito nel codice con il suo valore
		- si registra nella tabella inoltre l'indirizzo dove tale simbolo è usato
	- Ogni istruzione assembly viene codificata in linguaggio macchina
	- Viene allocato spazio dati e mantenuto contatore LC
- Operazioni effettuate
	- 1. leggi riga codice sorgente
	- 2. sostituisci simbolo con valore e registra indirizzo in cui viene usato in tabella simboli
	- 3. codifica istruzione in binario
	- 4. incrementa LC del numero di byte usati per codificare istruzione
	- 5. torna al punto 1
#### gestione simboli esterni
- Assemblatore crea **tabella dei simboli esterni**
	- indica simboli mancanti
	- indica indirizzi in cui vengono utilizzati
- Solo successivamente il linker risolverà i simboli mancanti

#### assemblaggio di segmenti e file multipli
- L'assemblatore lavora **indipendentemente** su ogni file
- Per ogni file:
	- ogni **segmento** (text/data/bss) è costituito da un proprio spazio di indirizzamento
		- LC riparte sempre da zero
	- si effettua la **prima scansione** per ogni segmento 
	- si costruisce una **tabella unica** per tutti i simboli
	- si effettua la **seconda scansione** di ogni simbolo
	- generato un singolo file oggetto
#### output: modulo oggetto
- Modulo oggetto generato:
	- ```main.o```
- Contiene:
	- codifica di ogni segmento di codice
	- tabella simboli locali/globali e tabella simboli esterni
- Per analizzare le tabelle dei simboli:
	- ```nm main.o```
![[19. Compilatore/Immagine 6.png|600]]
>[!warning] Nota per gli esercizi
>- se viene chiesto indirizzo in tabella simboli globali si intende indirizzo label
>- se viene chiesto indirizzo in tabella simboli esterni si intende l'indirizzo d'uso della label

### il programma linker
- **Unisce** tutti i moduli oggetto
- Viene generato ==file eseguibile==
	- comando: ```ld -o main func1.o func2.o main.o```
	- ```func1.o func2.o main.o -> main```
- **File eseguibile generato** contiene:
	- programma in linguaggio macchina
	- informazioni di supporto
		- es. indirizzo main
![[19. Compilatore/Immagine 7.png|500]]
#### costruzione del programma eseguibile
- Operazioni effettuate
	- calcola **estensione di memoria** occupata da ciascun segmento
	- posizione iniziale indirizzi di memoria segmenti e **nuovo indirizzo** **iniziale**
	- **riallocazione** di ogni indirizzo di memoria definito da una **label**
	- risoluzione **simboli esterni**
![[19. Compilatore/Immagine 8.png|500]]

#### riallocazione
- **Aggiornamento indirizzo di memoria label** a seguito dell'unione di segmenti
- Non vengono riallocati
	- **costanti** (.equ)
	- indirizzi definiti da **offset** 
![[19. Compilatore/Immagine 9.png]]

>[!warning] Nota per gli esercizi
>Se viene chiesto il valore del campo di indirizzo di un simbolo si intende semplicemente l'indirizzo, non il valore reale dato dall'indirizzamento autorelativo
#### output: programma eseguibile
- Contiene
	- istruzioni macchina
	- dati in ```.data```/```.bss```
	- indirizzo main
	- dimensione segmenti
	- tabelle simboli
	- info debug

### Loader
- Operazioni effettuate
	- **carica in memoria** istruzioni macchina
	- muove ```PC```all'indirizzo del main
	- se necessario, rialloca il programma in nuovi indirizzi
### librerie
- Collezioni di moduli oggetto con subroutine che possono essere invocate da altri programmi
#### librerie statiche
- Codice incluso nel momento del linking
#### libreria dinamica
- Codice libreria incluso **successivamente** al linking
	- il linker non risolve i simboli della libreria dinamica
- Classificazione:
	- **load-time dynamic library**
		- risoluzione simboli effettuata dal loader
	- **run-time dynamic library**
		- risoluzione simboli effettuata dal sistema operativo