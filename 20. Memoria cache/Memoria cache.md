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
$$
T=T_{1}\cdot p + T_{2}\cdot(1-p)
$$
### struttura di cache e memoria
#### memoria
- Locazioni di un byte e indirizzi su $n$ bit
- Locazioni raggruppati in **blocchi** di $K$ byte
![[Pasted image 20240513131001.png|200]]
#### struttura di cache e memoria
- Cache: contiene $M=2^r$ linee
- Ogni linea contiene un blocco di $K$ byte e un ==TAG== che identifica il contenuto
![[Pasted image 20240513131554.png|300]]
#### accesso indirizzo in memoria
![[Pasted image 20240513131646.png|600]]
#### indirizzo di un blocco
![[Pasted image 20240513131121.png|700]]
### tipi di cache
#### cache a mappatura diretta
- Blocco $j$ viene mappato in $i=j\mod{m}$
#### cache completamente associativa
- Metto i blocchi nelle linee libere e fine
#### cache associativa a k-vie
- Compromesso tra i due approcci
- Ogni blocco può finire solo su uno specifico set di linee nella cache (non tutte)

### algoritmi di rimpiazzo
- ==FIFO==
	- si sovrascrive la linea inserita per prima
	- non ottimale
- ==LRU== (Least recently used)
	- si sovrascrive la linea che da più tempo non subisce accessi
	- bit di controllo per tenere tempo di accesso