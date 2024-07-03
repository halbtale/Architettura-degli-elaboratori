## i/o con interrupt
### concetto di base
- Il processore avverte il dispositivo che vuole effettuare un'operazione di I/O
- Processore torna a eseguire altre operazioni
- Quando il dispositivo è pronto, avverte il processore
- Ricevuto il segnale, il processore esegue le operazioni relative al dispositivo di I/O
![[23. IO con interrupt/Immagine 1.png|400]]
### gestione dell'i/o a interruzioni
- Modulo I/O **segnala** al processore che il dato è pronto (**IRQ**)
- Processore esegue le seguenti operazioni:
	- **salvataggio contesto**
	- **RSI**
	- **ripristino contesto**
### interrupt request (irq)
- Presenza linea di segnale di controllo che si connette a un pin del processore
- Nel modulo I/O
	- registro **STATUS** indica se dispositivo è pronto o meno
	- registo **IM** abilita o disabilita generazione interrupt
	- segnale **IRQ** generato non appena dispositivo è pronto
- Nel processore
	- registro **I** abilita o disabilita ricezione interrupt nel processore
![[23. IO con interrupt/Immagine 2.png|500]]
### salvataggio del contesto
- Non appena riceve interrupt, processore deve gestirlo il più velocemente possibile (per evitare perdita di dati)
- Quando riceve interrupt, termina istruzione in corso ma poi non prosegue con le istruzioni successive
- Operazioni effettuate (via **hardware**)
	- imposta registro **I** a **0**
		- impedisce ricezione di ulteriori interrupt
		- viene utilizzato da interrupt con priorità alta
	- salva registri **PC** e **CPSR**
	- aggiorna il **PC** per eseguire la **RSI**
		- di solito è collocata all'indirizzo 0 dal sistema operativo

>[!info] info
>Non vengono salvati gli altri registri, queste operazioni verranno effettuate dalla routine di servizio 

### rsi: routine di servizio
- Salvata in memoria in indirizzi bassi dal sistema operativo
- Software scritto appositamente per la gestione di un tipo di I/O
	- ci sarà una routine diversa per ogni tipologia
#### preambolo alla rsi
- Effettua **operazioni preliminari** prima di eseguire la subroutine vera e propria
- Queste operazioni possono essere svolte
	- via software (+ lento ma + semplice)
	- via hardware (+ veloce ma + elaborato/costoso)
- 1. ==Conclusione salvataggio del contesto==
	- registri copiati nello stack o utilizzo di un set diverso di registri (**banked registers**)
- 2. ==Identificazione==
	- capire quale dei dispositivi ha generato interrupt 
	- si può leggere status di ogni dispositivo (**software polling**)
		- leggo celle memoria virtuale che indicano stato di ogni dispositivo
		- cerco quale dispositivo ha lanciato interrupt
	- esistono implementazioni hardware apposite
- 3. ==Gestione di IRQ concorrenti==
	- ci potrebbero essere più dispositivi I/O che hanno generato interrupt contemporaneamente
	- si assegna ad ogni tipo di dispositivo una priorità e vengono gestiti per primi quelli con la priorità più alta
		- quando si serve un dispositivo con priorità alta, si può impostare **IM=0** su tutti i dispositivi di priorità inferiore per prevenire invio interrupt
#### routine di servizio
- Scritta dal programmatore
- Deve interrompere segnale IRQ e gestire l'interrupt
#### ripristino del contesto
- Operazioni effettuate
	- ripristina registri **POP** e **CPSR**
	- ripristina registro **I** al valore **1** per permettere nuove richieste di interrupt
### ottimizzazioni hardware per routine di servizio
#### banked registers
- **Set di registri** dedicati per la subroutine che gestisce gli interrupt
	- i dati del programma rimangono non modificati nell'altro set
- Possono esserci più set di banked register 
	- la funzione di subroutine può essere interrotta da subroutine prioritarie
	- bisogna avere **numero set** = **numero priorità**
#### interrupt vettorizzati
- Processore, quando è pronto a gestire interrupt, lancia segnale ==IACK== (**Interrupt acknowledgement**)
- Il dispositivo che ha generato interrupt invia attraverso linea dati il numero del proprio identificativo (**IVN**)
- Tabella che associa identificativi dispositivi a indirizzi subroutine di servizio da chiamare
	- IVN usato come offset per leggere nell'array
	- IVN contiene indirizzo della prima istruzione della RSI da eseguire
- In totale ci sono due linee: una per **IRQ** e una per **IACK**
#### mascheramento
- Meccanismo utilizzato per gestire le **priorità** lato hardware
- Attraverso porte logiche si può fare in modo che IRQ a priorità maggiore **mascheri** (non trasmetta) **segnali** di **IRQ** e **IACK** da/a dispositivi I/O con priorità minore
![[24. IO con DMA/Immagine 1.png|700]]
#### daisy chain dei dispositivi
- Meccanismo utilizzato per gestire le **priorità** lato hardware
- Dispositivi collegati in una "**daisy chain**" (ghirlanda)
	- la **linea IACK** entra in ogni dispositivo e da questo prosegue verso il successivo
- Processore manda il segnale **IACK** prima ai dispositivi con maggiore priorità
	- se il dispositivo non ha generato l'interrupt
		- **passa** segnale al dispositivo successivo
	- se il dispositivo ha generato interrupt
		- **ferma** propagazione segnale e invia **IVN** al processore
	- gli altri dispositivi rimangono in **IRQ** **pending**

<div style="page-break-after: always;"></div>

### tipi di interrupt
- Non tutti gli interrupt sono associati ad I/O
- Meccanismo utilizzato per gestire vari tipi di **eccezione** oltre all'I/O:
	- ==program==
		- operazioni non consentite da parte del programma (es. divisione per 0, mancanza permessi, ecc)
	- ==timer==
		- permette di eseguire del codice allo scadere di un timer
	- ==hardware failure==
		- problema all'hardware fisico (es. problema alimentazione)
### gestione delle eccezioni in aRM
- Gli interrupt vengono definiti **eccezioni**
- Presenza di 6 livelli di priorità
	- I/O
		- ==FIQ== (**Fast Interrupt**)
		- ==IRQ== (**Interrupt**)
- Sfrutta meccanismi hardware
	- **interrupt vettorizzati**
	- **banked register**
![[24. IO con DMA/Immagine 5.png|400]]
<div style="page-break-after: always;"></div>

#### ulteriori ottimizzazioni
- Interruzione istruzioni complesse (che occupano + di un ciclo)
	- 1. spezzate (STM; LDM)
	- 2. interrotte e poi rifatte(DIV;UDIV)
- IVT
	- non contiene indirizzo prima istruzione
	- contiene direttamente codice di branch verso la prima istruzione
	- in FIQ, contiene direttamente la prima istruzione della RSI
- **Tail chaining**
	- al termine di una RSI, se c'è già un altro IRQ pending, viene eseguita direttamente senza ripristinare il contesto
- **Late-arriving preemption**
	- se un IRQ prioritario arriva prima dell'inizio di un altra RSI, sfrutta il fatto che aveva già salvato il contesto per la RSI interrotta