## i/o con dma (direct memory access)
### problema della gestione dell'i/o con interrupt
- Se I/O ha frequenza interrupt piccola
	- processore occupato per la gran parte del tempo a gestire I/O 
	- processore interrotto ogni volta che una piccola parte dei dati è pronta
#### indicatore performance
- **Data rate**
	- indica quanti dati provenienti dall'I/O possono venire gestiti al massimo ogni secondo
	- $D_r=\frac{1s}{T_{RSI}}$
	- es. $1000\,dati/s$

### dma controller
- Gestisce trasferimento dati I/O -> memoria alleggerendo carico processore
- Ha accesso a I/O e memoria tramite bus
#### interno del dispositivo
- ==Address register==
	- registro che contiene indirizzo da cui leggere in memoria
- ==Memory count==
	- contiene numero di dati da trasferire
#### funzionamento
- Processore invia **segnale** al DMA indicando:
	- **device** I/O su cui leggere
	- **numero** dati da trasferire
	- **indirizzo** memoria su cui scrivere
	- comando **START**
- Il controller
	- è in **busy waiting** sul dispositivo
		- trasferisce dato in memoria non appena è pronto
	- **decrementa contatore** dati rimasti da trasferire e aggiorna puntatore in memoria
	- quando contatore arriva a zero, invia **IRQ** al processore
![[24. IO con DMA/Immagine 4.png|400]]
### accesso al bus
- Bus **condiviso** con processore
- **DMA** ha **priorità** su processore per accesso in memoria
- Quando gli serve l'accesso, avverte processore con ==HOLD request==
	- processore consente l'accesso con ==HOLD ack==
#### cycle stealing
- Il processore accede alla memoria anche per il fetch (se non è in cache)
	- se non può utilizzare il bus a causa del DMA, il processore rimane bloccato
		- perde un ciclo -> "cycle stealing"
- Soluzione:
	- DMA non trasferisce i dati alla memoria tutti in un colpo (burst) ma viene fatto un dato alla volta
	- in questo modo il processore è in grado di continuare a effettuare le operazioni di fetch quando il bus non viene utilizzato
	 
<div style="page-break-after: always;"></div>

### sistemi i/o avanzato
- **Fly-by DMA**
	- dati in transito NON vengono memorizzati temporaneamente sul dMa
- **DDIO DMA**
	- DMA usa direttamente la cache invece che la memoria
- **I/O channels**
	- DMA Controller è un piccolo processore in grado di eseguire la subroutine indicatagli dalla cpu
- **I/O processor**
	- DMA Controller è un vero e proprio processore in grado di controllare il dispositivo esterno senza l'ausilio della CPU
### sistemi multiprocessore
- DMA può essere considerato un processore supplementare
	- con la stessa tecnica, si può dare supporto al processore con altri dispositivi esterni
- Processori supplementari:
	- **processori ausiliari** specializzati per una specifica task
		- es. GPU (processore per gestire la grafica)
	- **acceleratori hardware** 
		- es. TPU per machine learning o chip per crittografia
	- **processori paritari multipli**
		- permettono calcolo parallelo e ridondanza