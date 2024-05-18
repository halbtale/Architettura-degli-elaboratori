## gestione della memoria
### memoria virtuale
- ==Memoria virtuale==
	- ogni processo vede la memoria interamente dedicata al processo stesso
	- $2^{n}$ locazioni ($n$ numero bit indirizzo)
	- ad essa vengono associati **indirizzi logici**
- ==Memoria fisica==
	- memoria fisica è condivisa con altri programmi e con il sistema operativo
	- potrebbe essere più grande o più piccola di quella virtuale
	- hardware e sistema operativo mappano la memoria virtuale in quella fisica
	- ad essa vengono associati **indirizzi fisici**
### gestione della memoria
- **Suddivisione** memoria affinché venga utilizzata da più processi
	- in modo **efficiente** per farci stare il numero massimo di processi
- Gestire mappatura memoria virtuale -> fisica di ogni processo
### memory management unit (Mmu)
- **Unità hardware** che gestisce la **mappatura** tra memoria **virtuale** e **fisica**
![[21. Gestione della memoria/Immagine 1.png|600]]
### tecniche mappatura memoria
- Tecnica di **paginazione**
	- non visibile al programmatore
- Tecnica di **segmentazione**
	- visibile al programmatore
### paginazione
- Memoria divisa in blocchi di **dimensione uguale** tra loro
	- memoria fisica viene divisa in ==pagine fisiche== o ==frame== 
	- memoria virtuale divisa in ==pagine logiche
- **MMU** mappa pagine logiche in pagine fisiche
![[21. Gestione della memoria/Immagine 2.png|400]]
#### versione semplificata
- Memoria virtuale costituita da una sola pagina e memoria fisica costituita da tante pagine
- All'indirizzo logico si aggiunge un offset corrispondente all'indirizzo fisico in cui si trova la pagina
	- si aggiungono $q$ bit che indicano l'indice di pagina contenuti in un ==MAP== (**registro di mappa**)
![[21. Gestione della memoria/Immagine 3.png|500]]
#### page table
- Contiene **registri di mappa** per un determinato programma
- Specifica in quali **pagine fisiche** sono mappate le sue **pagine logiche**
	- gli indirizzi logici iniziano da 0 e occupano una o più pagine logiche
#### campi dell'indirizzo logico
- Campi
	- **Bit di offset**
		- bit meno significativi
		- indicano offset indirizzo da inizio pagina
	- ==IPL== (**Indice Pagina Logica**)
		- indica a quale pagina logica è associato l'indirizzo
	- ==IPF== (**Indice Pagina Fisica**)
		- indica a quale pagina fisica è associato l'indirizzo
- Trasformazione indirizzi
	- **IPL** viene sostituito con **IPF**

![[21. Gestione della memoria/Immagine 6.png|500]]
#### page table in memoria
- Con un numero elevato di pagine logiche, **MMU** non riesce a contenere tutti i registri di mappa
	- si colloca **page table** in **un'area protetta della memoria fisica**
- ==Page table pointer==
	- **MMU** contiene puntatore alla page table associata al processo attivo
#### resident set
- Non è necessario caricare tutte le pagine logiche di un processo in memoria
	- occupa spazio per niente
	- memoria potrebbe venir utilizzata da altri programmi in esecuzione
	- non è detto che sia sufficientemente grande
- ==Resident set==
	- insieme delle pagine logiche caricate in **memoria primaria**
- Le altre pagine logiche vengono lasciate nella **memoria secondaria** (disco)
#### memory fault
- Si verifica un processo richiede un dato che non si trova in memoria ma sul disco
	- genera **interrupt**
	- sistema operativo con richiesta I/O recupera dato dal disco (==swap in==)
- Memory fault in caso di memoria **totalmente occupata**
	- si sceglie quale pagina nella memoria principale deve essere rimpiazzata (==swap out==)
		- attraverso **politica di rimpiazzo**
	- si inserisce nuova pagina
#### costo dei page fault
- Variabili
	- $t_A$: tempo di accesso alla memoria
	- $t_F$: tempo necessario per gestire un page fault
	- $p_F$: probabilità di page fault
	- $t_M$: tempo medio di accesso in memoria
- $t_M=(1-p_{F}) \cdot t_{A}+ p_{F}\cdot t_{F}$
#### principio di località
- **Località temporale**
	- in un certo intervallo di tempo, il processore opera su indirizzi localizzati nelle medesime pagine
- **Località spaziale**
	- vengono utilizzati indirizzi consecutivi in modo da aver bisogno di meno pagine possibili
#### trashing
- Si verifica quando un processore rimpiazza un blocco poco prima di tentare di accedervi e ciò avviene troppo frequentemente
	- effettua **swap out** e poco dopo **swap in**
- Processore perde gran parte del tempo a eseguire **swap** 
	- forte rallentamento
#### page table - versione completa
- Per ogni ==IPL== (indirizzo pagina logica) è associato:
	- ==IPF==: indirizzo pagina fisica 
		- se presente in **memoria primaria**
	- ==IMS==: indirizzo in **memoria secondaria**
	- **Bit di controllo**
		- **P**: pagina presente nella memoria fisica
		- **M**: pagina modificata durante la permanenza in memoria fisica
			- in caso di rimpiazzo, se modificata, va aggiornata anche sul disco
		- bit di **protezione** (sola lettura, sola esecuzione, riservato a S.O.)
![[21. Gestione della memoria/Immagine 4.png|700]]
#### ottimizzazione page table
- Poiché la **page table** è salvata in memoria
	- ogni accesso in memoria richiede **due** accessi (uno anche per leggere la page table)
- ==TLB== (**Translation Lookaside Buffer**)
	- cache specifica per la page table
	- contiene un sottoinsieme degli elementi della page table
	- **evita** accesso in memoria principale per leggere page table
- Funzionamento
	- **IPL** cercato nella CAM del **TBL**
	- **hit**
		- si costruisce subito indirizzo fisico
	- **miss**
		- va in memoria e legge dalla page table
		- se pagina è presente in memoria principale
			- si costruisce indirizzo fisico
			- si aggiorna TBL
		- caso **page fault**
			- si effettua swap in
			- si costruisce indirizzo fisico
			- si aggiorna page table e TLB

![[21. Gestione della memoria/Immagine 5.png|600]]
#### vantaggi
- **Protezione**
	- attraverso bit di controllo, si può inserire **meccanismi di controllo degli accessi**
		- ==read only== o riservato a ==sistema operativo==
- **Frammentazione dello spazio libero**
	- la suddivisione in pagine consente di caricare processi nelle aree libere anche se spazio è frammentato
- **Rilocamento**
	- rende facile l'utlizzo della memoria per il programmatore attraverso il layer di astrazione della memoria virtuale
	- se memoria è piena, può copiare temporaneamente programma su disco e poi reinserirlo successivamente in memoria, anche in una posizione diversa (**rilocato**)
	- permette esecuzione di più programmi in contemporanea
- **Protezione da interferenze**
	- impedisce che un processo possa accedere alla memoria di altri processi
	- misura di sicurezza
- **Comunicazione tra processi**
	- nel caso di computazione parallela, consente che processi diversi possano accedere ad aree di memoria comuni
### segmentazione
- Permette al **programmatore** di dividere la memoria in modo opportuno
- Programmi costruiti in **moduli** (==segmenti==) compilati e scritti separatamente
	- ogni modulo ha la propria memoria virtuale
	- ogni segmento può essere di dimensione variabile
- Ogni **indirizzo** è costituito da:
	- ==IS== (**indice di segmento**)
	- ==OS== (**offset**)
- A ogni programma è associata una ==segment table== che contiene
	- ==ISS==: indirizzo iniziale di ogni segmento
	- ==DS==: dimensione di ogni segmento
	- bit di controllo
- Indirizzo finale è dato da: **ISS + OS**
- È possibile avere un sistema ibrido paginazione + segmentazione