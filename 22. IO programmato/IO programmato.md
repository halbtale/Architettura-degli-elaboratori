## I/O programmato
### gestione dell'i/o
- Sequenza di operazioni che il processore deve eseguire per:
	- **leggere** dati da dispositivo esterno
	- **scrivere** dati su dispositivo esterno
- Comunicazione processore-dispositivi I/O deve avviene attraverso **protocollo I/O** 
- Dispositivi connessi fisicamente attraverso **modulo I/O**
### funzionamento dispositivo esterno
- **Unità di controllo**
	- comunica con il processore
- **Buffer**
	- dispositivo input: contiene bit che verranno inviati al processore
	- dispositivo output: contiene bit che riceve dal processore
- **Transducer**
	- trasforma bit nel segnale fisico del dispositivo (es. accende LED)
![[22. IO programmato/Immagine 1.png|500]]
### modulo di i/o
- Da un lato connesso al **processore** e dall'altro ai **dispositivi I/O**
- Funzioni
	- **controllo** e **temporizzazione**
	- mette in **comunicazione** processore a dispositivi esterni
	- **data buffer**
	- controllo degli **errori**
- Linee
	- **address line**
		- trasmette indirizzo dispositivo con cui processore vuole comunicare
	- **data line**
		- trasmette dati in ingresso/uscita
	- **control line**
		- trasmette segnali di controllo
	- **status**
		- trasmette segnale di stato dispositivo I/O
![[22. IO programmato/Immagine 3.png|500]]
### accesso al dispositivo
- *Linguaggio* utilizzato tra processore e dispositivi I/O
#### isolated
- Linee di controllo e di dati dedicate
- Il processore contiene **istruzioni dedicate** di lettura e scrittura per I/O
#### memory mapped
- Dispositivi I/O collegati con le stesse linee del bus usate per la memoria
- Dispositivi mappati con **indirizzi memoria virtuale**
- Si utilizzano le stesse istruzioni di LDR/STR che si utilizzano per la memoria

### i/o programmato
- **Protocollo di comunicazione** con il dispositivo
- Processore si fa carico direttamente delle operazioni per lettura/scrittura da I/O
- Può utilizzare quattro tipi di comando
	- **controllo**
	- **test**
	- **lettura**
	- **scrittura**
#### operazione di lettura
- Attraverso pooling
- Esegue le seguenti operazioni
	- 1. invia **comando di lettura** al dispositivo
	- 2. **attende** che dispositivo I/O sia pronto effettuando un **loop**
	- 3. legge la word dal **data buffer** del modulo I/O
	- 4. scrive dato letto nella memoria
#### scrittura
- Esegue le seguenti operazioni
	- 1. invia **comando di scrittura** al dispositivo
	- 2. **attende** che dispositivo I/O sia pronto effettuando un **loop**
	- 3. **scrive** la word presa dalla memoria sul **data buffer** del modulo I/O
#### pro e contro
- **Pro**
	- molto **reattivo**
	- **facile** da implementare
	- si utilizza in scenari critici e economici
- **Contro**: problema del ==busy waiting==
	- processore "occupato" a controllare se dispositivo è pronto
	- dispositivi *molto* più lenti del processore
	- grande spreco di potenza computazionale