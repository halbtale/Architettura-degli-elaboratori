## Componenti e organizzazione di un elaboratore
### programmazione in hardware
- **Hardwired programming**
- Implementazione di un programma attraverso un insieme di componenti logiche base (AND, OR, MULTIPLEXER, ROM, etc)
#### PRO
- Implementazione programma con area circuito minima
- Esecuzione veloce
- Risparmio energetico
#### contro
- Il programma non può essere modificato
- Costo di implementazione
- Approccio specifico e non generale
#### esempi
- TPU (Tensor Processing Unit)
	- ottimizzato per moltiplicazione di matrici
	- utilizzato per Machine Learning
### programmazione in software
- Presenza di una famiglia di funzioni logiche e aritmetiche base già implementate
- Invio "segnali di controllo"
	- indicano quali funzioni e in che ordine attivare sui dati input
#### pro
- Programma può esser modificato
- Costo implementazione ridotto
- Universalità
#### contro
- Minore efficienza di calcolo
- Circuiti + estesi e complessi
- Maggiore consumo energetico
### sistema per la programmazione in software
![[8. Componenti e organizzazione di un elaboratore/Immagine 1.png|500]]
- Si assegna un univoco ad ogni possibile sequenza di segnali
	- ogni codice denota un'**istruzione**
- **Instruction Interpreter**
	- componente hardware per **tradurre codici** in **segnali**
### Componenti computer
#### cpu
![[8. Componenti e organizzazione di un elaboratore/Immagine 3.png|300]]
- ==ALU==
	- pezzi hardware che eseguono operazioni aritmetiche e logiche base
- ==Control Unit==
	- attiva le varie operazioni dell'ALU
#### modulo io (input/output)
![[8. Componenti e organizzazione di un elaboratore/Immagine 4.png|200]]
- Permette alla CPU di comunicare con il mondo esterno
	- immissione input
	- emissione output
#### memoria
![[8. Componenti e organizzazione di un elaboratore/Immagine 5.png|150]]
- Serve per salvare:
	- istruzioni
	- dati di input
	- dati temporanei
- Divisa in locazioni (blocchi)
	- ogni blocco è una **word**
	- accessibili tramite un **indirizzo**
#### bus
- Serve per connettere i vari moduli (CPU/IO/Memoria)

### architettura di von neumann
![[8. Componenti e organizzazione di un elaboratore/Immagine 9.png|500]]
- CPU ha sei registri principali
	- ==MAR== (**Memory address Register**)
		- contiene indirizzo memoria 
	- ==MBR== (**Memory buffer register**)
		- salva contenuto di una locazione di memoria
	- ==I/O AR== (**Access Register**)
		- contiene indirizzo dispositivo I/O
	- ==I/O BR== (**Buffer Register**)
		- contiene dato ricevuto o da inviare verso dispositivo I/O
	- ==IR== (**Instruction Register**)
		- contiene il codice che l'Execution unit deve processare
	- ==PC== (**Program counter**)
		- mantiene indirizzo di memoria della prossima istruzione
- CPU può avere altri registri per memorizzare dati temporanei
	- se ce ne è solo uno, si chiama AC
	- altrimenti R0, R1, ...
### ciclo di un'istruzione
![[8. Componenti e organizzazione di un elaboratore/Immagine 10.png|600]]
- **Fetch**
	- recupera dalla memoria la prossima istruzione da eseguire
	- istruzione viene salvata nel registro IR
	- PC viene aggiornato con indirizzo istruzione successiva
- **Decode**
	- L'istruzione inserita nel registro IR viene decodificata
- **Execute**
	- l'istruzione inserita nel registro IR viene eseguita
#### ciclo di un'istruzione nel dettaglio
![[8. Componenti e organizzazione di un elaboratore/Immagine 13.png|600]]
- **Instruction fetch**
	- recupera istruzione da indirizzo memoria del PC
- **Instruction operation decoding**
	- estrae tipo di operazione dall'istruzione
- **Operand address calculation**
	- estrae indirizzo di memoria dall'istruzione
- **Operand fetch**
	- recupera dato da memoria
- **Data operation**
	- esegue operazione dell'istruzione
- **Operand address calculation**
	- capisce dove salvare dato in memoria
- **Operand store**
	- salva il dato in memoria
- **Instruction address calculation**
	- aggiorna PC
### tipi di un'istruzione
- **Processore-memoria**
	- spostamento di un dato dal processore alla memoria
- **Processore-IO**
	- spostamento di un dato da processore a modulo IO
- **Elaborazione dati**
	- esecuzione di operazioni logiche o aritmetiche
- **Controllo**
	- modifica della sequenza delle istruzioni
	- es. while, if, ecc
### esempio architettura con 1 registro temporaneo (AC)
#### formato istruzione
![[8. Componenti e organizzazione di un elaboratore/Immagine 11.png|500]]
- 16 bit
- ==Opcode==
	- determina il tipo di operazione (load/store/add)
- ==Address==
	- indirizzo di memoria
#### Instruction set architecture (tipo di operazioni disponibili)
- **Load**
	- Carica nel registro AC il dato contenuto in memoria all'indirizzo "address"
	- OPCODE: $0x1$
- **Store**
	- Scrivi il contenuto del registro AC in memoria all'indirizzo indicato nel campo "address"
	- OPCODE: $0x2$
- **Add**
	- Somma il contenuto del registro AC con il dato contenuto in memoria all'indirizzo indicato nel campo "address" e il risultato viene scritto in AC
	- OPCODE: $0x5$
#### contenuto della memoria
![[8. Componenti e organizzazione di un elaboratore/Immagine 12.png|500]]
#### simulazione esecuzione
- **Fetch**
	- PC contiene l'indirizzo della prima istruzione da eseguire
		- in questo caso PC=300
	- Istruzione all'indirizzo indicato dal PC viene copiata nel registro IR
		- IR $\leftarrow$ 1940
	- PC viene incrementato di un'unità
		- PC $\leftarrow$ 301
- **Decode**
	- Viene decodificata l'istruzione presente in IR (1940)
		- 1 $\rightarrow$ LOAD all'indirizzo $940$
- **Execute**
	- Viene aggiornato il valore del MAR per l'istruzione LOAD
		- MAR $\leftarrow$ 940
	- Viene letto dalla memoria il dato nell'indirizzo del MAR e salvato nel MBR
		- MBR $\leftarrow$ 3
	- Il dato viene infine scritto nel registro AC
		- AC $\leftarrow$ 3
- Viene ripetuto il ciclo con PC=301
### interfaccia delle componenti
![[Immagine 15.png|600]]
- Non mi interessa l'implementazione dei diversi moduli
	- mi basta sapere gli input e gli output
### bus
- Mezzo di **trasmissione** condiviso che collega più componenti
- Nei computer moderni sono presenti più bus invece di uno unico
![[Immagine 16.png|500]]
#### linee di comunicazione
- Ogni bus consiste in più linee di comunicazione
- ==Data Bus==
	- Linee usate per trasmettere dati tra componenti
	- **Bus width** (numero di linee)
		- indica numero di bit che possono essere trasmessi contemporaneamente
		- il data bus può consistere di 32, 64, 128, + linee
		- + bus è grande, + è veloce
		- per trasmettere $n$ bit bisogna inviare $w$ bit $\frac{n}{w}$ volte
- ==Address Bus==
	- Utilizzato per indicare **indirizzo** sorgente/destinazione del dato da trasmettere
	- Con $w$ linee si possono indicare $2^w$ indirizzi
		- si possono indicare ancora più indirizzi scomponendoli in più parti
- ==Control Bus==
	- Linee usate per trasmettere i segnali di controllo
	- Esempio segnali:
		- **Memory write** $\rightarrow$ scrivi i dati trasmessi all'indirizzo specificato
		- **Memory read** $\rightarrow$ leggi i dati all'indirizzo specificato
		- **Clock** $\rightarrow$ per sincronizzare le operazioni
![[Immagine 17.png|500]]
