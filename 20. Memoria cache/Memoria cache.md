## memoria cache
### memoria
- Caratteristiche principali:
	- **dimensione**
	- **tempo di accesso**
	- **costo per bit**
- Compromessi determinati da limiti fisici
#### memorie dram
- Grande, economica ma lenta
- Velocità di trasferimento dati dalla memoria al processore è bassa rispetto a velocità elaborazione dati CPU
![[20. Memoria cache/Immagine 1.png|500]]
#### memoria sram
- Memoria costosa e di estensione ridotta (ordine di KB)
- Molto più veloce della memoria DRAM
### gerarchie di memoria
- È possibile sviluppare una **gerarchia di memoria** per soddisfare tutti i requisiti
#### memoria cache
- Memoria **SRAM** veloce, piccola e costosa
- Posizionata tra la memoria principale e il processore
	- contiene la copia di una parte dei dati presenti in memoria
#### funzionamento gerarchia di memoria
- Per ogni richiesta di accesso a una word, il processore controlla prima se è presente nella cache
	- ==cache hit==
		- presente nella cache
		- processore la legge dalla cache direttamente (molto veloce)
	- ==cache miss==
		- non presente nella cache
		- necessario accesso alla memoria principale (lento)
![[20. Memoria cache/Immagine 2.png|500]]
### ottimizzazione cache
#### Località di riferimento temporale
- **Dati** più utilizzati **mantenuti in cache** -> permette accesso + rapido
- Problemi:
	- dimensione limitata
	- difficile determinare dati più utilizzati
#### località di riferimento spaziale
- Il programma richiede dati vicini in memoria 
	- word con **indirizzi consecutivi**
- ==Block transfer==
	- quando vi è una lettura di una word nella memoria principale, vengono lette e copiate nella cache anche le word consecutive 
	- la velocità di lettura nella memoria principale dipende principalmente dalla latenza, non dal numero di dati trasferiti contemporaneamente 
### costo medio di accesso alla memoria
- $T_1$=tempo accesso cache (es. $10\,ns$)
- $T_2$=tempo accesso memoria (es. $100\,ns$)
- $p=$hit rate (percentuale accessi cache su accessi totali)
- Calcolo costo medio $T$ di accesso (media pesata)
	- $T=T_{1}\cdot p + T_{2}\cdot(1-p)$

### struttura di cache e memoria
#### memoria
- Locazioni di un byte e indirizzi su $n$ bit
- Locazioni raggruppati in **blocchi** di $K$ byte
![[20. Memoria cache/Immagine 3.png|200]]
#### struttura di cache e memoria
- Cache: contiene $M=2^r$ linee
- Ogni linea contiene
	- un **blocco** di $K$ byte
	- un ==TAG== che identifica il contenuto
![[20. Memoria cache/Immagine 5.png|300]]
#### accesso indirizzo in memoria
![[20. Memoria cache/Immagine 6.png|600]]
#### indirizzo di un blocco
- Si ottiene dagli $n-w$ bit più significativi dell'indirizzo
![[20. Memoria cache/Immagine 4.png|700]]
### cache a mappatura diretta
- Organizzazione memoria principale
	- divisa in pagine grandi come la cache
	- ogni pagina è divisa in blocchi
- Indirizzo blocco all'interno della pagina = indirizzo linea in cui verrà caricato nella cache
![[20. Memoria cache/Immagine 8.png|300]]
#### struttura indirizzi
- Suddivisi in campi:
	- **indice di pagina**
		- salvato nel TAG della cache
		- indica da quale pagina della memoria principale prendere il blocco
	- **indice di blocco** 
		- indica quale blocco prendere all'interno della pagina
		- corrisponde all'indice di **linea** all'interno della cache
	- **indice di byte** 
		- indica offset word all'interno del blocco
![[20. Memoria cache/Immagine 10.png|600]]
#### funzionamento
- Processore richiede accesso a un indirizzo di memoria
- Si controlla nella cache l'elemento all'indice di linea e si confronta TAG associato
	- uguale: cache **hit**
	- diverso: cache **miss**
#### pro e contro
- **Pro**
	- organizzazione semplice
- **Contro**
	- se si fa accesso a blocchi diversi con stesso indirizzo di linea, vengono sovrascritti nella cache anche se è ancora liberata
	- hit rate basso
### cache completamente associativa
- Viene inserito nuovo blocco nella cache
	- nella prima posizione liberata
	- sovrascrivendo una già occupata se sono tutte occupate
		- attraverso politica di rimpiazzo
#### struttura indirizzi
- La posizione di un blocco nella cache è libera, quindi per ricostruire a quale indirizzo appartiene viene salvato nel TAG l'intero indirizzo del blocco in memoria
 ![[20. Memoria cache/Immagine 11.png|600]]
#### funzionamento
- Processore richiede accesso a un indirizzo di memoria
- Indirizzo del blocco viene confrontato con **TUTTI** i tag per capire se è presente nella cache
	- presente: cache **hit**
	- non presente: cache **miss**
#### memoria associativa (cam)
- Detta ==Content Addressable Memory==
- Memoria in grado di effettuare un confronto in parallelo tra un dato cercato e i dati in essa contenuti
	- programmata in hardware
- **Riceve** un **dato** e **restituisce** **indirizzo** delle celle che contengono quel dato
	- opposto del funzionamento della RAM
#### pro e contro
- **Pro**
	- hit rate molto alto
- **Contro**
	- costosa (richiede circuito CAM)
### cache set-associativa a k-vie
- Compromesso tra cache a mappatura diretta e cache completamente associativa
- Ad ogni indice di blocco
	- non corrisponde **UNA** linea di cache
	- corrispondono $k$ linee di cache
		- presenti in un **set** con indice uguale all'indice di blocco
![[20. Memoria cache/Immagine 13.png|400]]
![[20. Memoria cache/Immagine 17.png|600]]
#### struttura indirizzi
- Suddivisi in campi:
	- **indice di pagina**
		- salvato nel TAG della cache
		- indica da quale pagina della memoria principale prendere il blocco
	- **indice di blocco** 
		- indica quale blocco prendere all'interno della pagina
		- corrisponde all'indice di **set** all'interno della cache da cui prendere blocco
	- **indice di byte** 
		- indica offset word all'interno del blocco
![[20. Memoria cache/Immagine 12.png|600]]
#### funzionamento
- Processore richiede accesso a un indirizzo di memoria
- Indirizzo blocco viene confrontato con tutti i tag all'interno del **set** in cui si trova
	- non serve controllare tutte le celle della cache, ma solo quelle del set in cui si trova
	- attraverso CAM viene effettuato in parallelo
		- più piccola e meno costosa (pochi indirizzi da confrontare)
	- si avrà cache **hit** o **mis**
#### pro e contro
- Implementazione più utilizzata
- Rispetto a mappatura diretta
	- + efficiente
	- + costosa (richiede CAM)
- Rispetto a completamente associativa
	- - efficiente
	- -  costosa (richiede tante piccole CAM invece di una grande)
### algoritmi di rimpiazzo
- Utilizzati quando è necessario sovrascrivere un blocco della cache già presente per inserire nuovo blocco di word
	- determinano hit rate
- ==FIFO== (First in first out)
	- si sovrascrive la linea inserita per prima
	- non ottimale
		- potrebbe sovrascrivere blocchi utilizzati molto se inseriti per primi
- ==LRU== (Least recently used)
	- si sovrascrive la linea che da più tempo non subisce accessi
	- bit di controllo per tenere tempo di accesso
### scrittura di un blocco
#### approccio copy-back
- Nella **scrittura** viene **modificata** solo la word nella **cache**
	- si utilizza un bit di controllo per indicare che il blocco è stato modificato ma non salvato nella memoria principale (==dirty bit==)
	- scrittura molto veloce
- Nella **lettura**, se il blocco selezionato per essere sovrascritto ha il dirty bit attivo, il contenuto del blocco viene prima copiato nella memoria principale e poi sovrascritto
	- lettura più lenta
#### approccio write-through
- Nella **scrittura** viene prima **modificata** la word nella **cache** e successivamente viene effettuata l'operazione di scrittura nella memoria principale
	- l'esecuzione prosegue al termine dell'operazione di scrittura
#### write buffer
- Compromesso tra i due approcci
- Nella **scrittura** vengono effettuate le seguenti operazioni
	- la word viene **modificata** nella cache
	- la word viene **inserita** in un **write buffer**
		- memoria SRAM piccola e veloce per dati temporanei
		- verrà successivamente copiata in background nella memoria principale
	- processore prosegue con l'esecuzione delle istruzioni successive senza attendere completamento scrittura in memoria principale
		- non rallenta esecuzione
### bit di controllo
- ==Dirty bit==
	- indica se word in cache non è ancora stata aggiornata nella memoria principale
- ==LRU==
	- Least recently used
	- indica timestamp ultimo accesso a word
- ==Bit di validità==
	- indica se blocco è una copia valida del blocco corrispondente in rAm
	- può essere invalidato da trasferimenti DMA o sistemi multiprocessore
### dimensione cache
$$D_{\text{cache}} = N_{\text{linee}}\cdot(D_{\text{blocco}}+D_{\text{tag}}+N_{\text{bit di controllo}}) $$

### cache distinta per istruzioni e dati
- È utile utilizzare la cache per le istruzioni
	- sono consecutive
-  Si preferisce avere la cache per istruzioni e per i dati distinte
	- si evitano conflitti
	- bisogna analizzarle separatamente
![[20. Memoria cache/Immagine 14.png|600]]
<div style="page-break-after: always;"></div>

### gerarchia multilivello
- Si possono avere più livelli di cache
	- *1° livello*
		- piccola e ad accesso rapidissimo
		- integrata nel chip del processore
	- *2° livello*
		- più grande e ad accesso meno rapido
		- esterna al processore
	- i livelli più lontani sono più lenti ma più capienti
![[20. Memoria cache/Immagine 16.png|500]]
### organizzazione memoria raspberry
- **L1-data**
	- dimensione: 48KB
	- blocco: 64 locazioni
	- 2-way
- **L1-instructions**
	- dimensione: 32KB
	- blocco: 64 locazioni
	- 4-way
- **L2**
	- dimensione: 1MB
	- blocco: 64 locazioni
	- 16-way

