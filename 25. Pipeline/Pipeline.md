## pipeline
### prefetch
- Fasi **fetch** e **execute** utilizzano **circuiti logici distinti**
- Si può adottare ==instruction prefetch==
	- mentre eseguo istruzione corrente, faccio fetch istruzione successiva
- **Limite** dell'approccio a due fasi:
	- velocità fetch < velocità execute
		- execute contiene infatti tante sotto-fasi
		- difficile da sincronizzare
	- non permette di raddoppiare le prestazioni
### scomposizione in 6 fasi
- Tutte le **fasi** richiedono in genere lo **stesso tempo** (se dati sono nelle cache)
#### fasi
1. **Fetch instruction** (==FI==)
	- leggi la prossima istruzione
2. **Decode instruction** (==DI==)
	- determina opcode e tipo operandi
3. **Calculate operands** (==CO==)
	- calcola indirizzo effettivo di ogni operando
4. **Fetch operands** (==FO==)
	- fai accesso il memoria per recuperare operandi se necessario
5. **Execute instruction** (==EI==)
	- esegui istruzione 
6. **Write operand** (==WO==)
	- scrivi risultato in memoria o su un registro

<div style="page-break-after: always;"></div>

### pipelining
- Se tutte le fasi sono eseguite da sezioni indipendenti di hardware, possono essere eseguite tutte contemporaneamente
![[25. Pipeline/Immagine 2.png|600]]
- La pipeline è **completa** solo dopo il transitorio
	- transitorio, con molte istruzioni, è di durata trascurabile
	- quando è completa, viene terminata un'istruzione al termine di ogni fase
### hardware in più
- Servono dei **buffer** (registri) per memorizzare parziali di ogni ciclo e separare le fasi
![[25. Pipeline/Immagine 3.png|500]]
### tempo minimo di avanzamento
- Dati:
	- $k$ = numero di fasi
	- $t_i$ = tempo di esecuzione dell'i-esima fase
	- $d$ = tempo per trasmettere un segnale alla fase successiva
- Il tempo di esecuzione $T$ di una fase è il massimo $T_i$ di tutte le fasi
	- così ci si assicura che tutte le fasi siano sincronizzate
	- ad esso bisogna aggiungere il tempo per trasmette il segnale
- $T_{\text{ciclo}}=\max_i[t_i]+d$

<div style="page-break-after: always;"></div>

### tempo di esecuzione
- Per eseguire $N$ istruzioni con $k$ fasi da $t$ secondi
- **Senza pipeline**
	- $t_1={N}\cdot k \cdot t$
		- tutte le $N$ istruzioni impiegano $k\cdot t$
- **Con pipeline a fasi**
	- $t_{k}= k\cdot t+(N-1)\cdot t$
		- **transitorio**: primi k cicli
		- **regime**: istruzione eseguita ad ogni ciclo
### fattore di speed-up
- Indica di quanto viene ridotto il tempo di esecuzione
$$S_K=\lim_{N\to +\infty}\frac{T_1}{T_K}=\lim_{N\to +\infty}\frac{N\cdot k\cdot t}{k\cdot t+(N-1)\cdot t}=\lim_{N\to +\infty}\frac{N\cdot k}{k+N-1}=\lim_{N\to +\infty}\frac{k\cdot N}{N}=k$$
- Si osserva che il tempo di esecuzione con un numero abbastanza ampio di istruzioni si riduce (idealmente) di $k$ volte
### inceppamento della pipeline
- **Pipeline stall/bubble**
	- bolle d'aria nella pipeline che rallentano il processo
	- riducono fattore di speedup
### cache miss
- Istruzione deve **accedere** in **memoria** 
	- può richiedere due o tre cicli
	- esecuzione viene rallentata
![[25. Pipeline/Immagine 4.png|500]]

<div style="page-break-after: always;"></div>

### resource hazard
- **Conflitti** con le **risorse**
	- due istruzioni cercano di accedere contemporaneamente alla memoria
	- può avvenire anche se la fase richiede accesso alla memoria per il fetch
![[25. Pipeline/Immagine 5.png|400]]
### data hazard
- Causata da **dipendenze** tra istruzioni
	- gli operandi di un'istruzione sono i risultati di una istruzione precedente ancora da terminare
	- l'esecuzione non può procedere finché il risultato non è pronto
![[25. Pipeline/Immagine 6.png|500]]
#### rimedi contro i data hazard
- Tecnica: ==riordino delle istruzioni==
	- si fanno eseguire altre istruzioni prima di quelle che richiedono i dati
	- di solito viene fatta dal compilatore
- Tecnica: ==bypass== (o ==data forwarding==)
	- i risultati prodotti dall'ALU vengono inviati all'istruzione successiva senza attendere che vengano memorizzat
![[25. Pipeline/Immagine 7.png|450]]
### control/branch hazard
- Causata da **salti condizionati**
	- se ho un branch, conosco istruzione successiva solo dopo aver fatto execute
- In caso di un salto, il processore viene rallentato di molto, poiché deve:
	- svuotare pipeline
	- annullare effetti fasi eseguite delle istruzioni successive che non dovranno andare eseguite
	- rialimentare pipeline con istruzioni dell'altra diramazione
![[25. Pipeline/Immagine 8.png|400]]
#### rimedi contro control hazard
- Tecnica: ==multiple streams==
	- creo **due pipeline**
		- una con flusso normale
		- una con il salto
	- analisi speculativa -> faccio più conti del necessario
		- quando risultato è noto, si scarta il ramo sbagliato
	- **limiti**:
		- possibili conflitti su registri/memoria
		- ci potrebbero essere più branch di seguito
- Tecnica: ==delayed branch==
	- posso collocare **istruzioni non pericolose** dopo branch
		- es. istruzioni che non modificano memoria
		- in caso di salto, è facile pulire gli effetti
	- ri-ordinamento viene fatto tipicamente da compilatore
	- se non è presente un'istruzione di questo tipo, viene inserito **NOP**
- Tecnica: ==branch prediction==
	- si cerca di predire quale sarà il risultato del branch
		- es. su un for loop, torna indietro n volte e solo l'ultima vai avanti
	- **statico** 
		- decide in base all'**opcode**
	- **dinamico**
		- scelta dipende da bit di stato
		- **branch history table**
#### predittore dinamico
- Utili in caso di esecuzioni ripetute di un salto (es. for loop)
- La predizione su effettuare salto o meno si basa su salti precedenti
- Si associano bit di stato ad ogni branch condizionato
	- 1 bit
		- ricorda solo l'ultima esecuzione
	- 2 bit
		- ricorda le ultime due esecuzioni
		- + stabile
![[25. Pipeline/Immagine 9.png|500]]
- **Branch history table** (==BHT==)
	- cache con CAM
	- contiene indirizzi istruzioni di salto e stato predizione
	- funzionamento
		- PC confrontato con indirizzi CAM
		- se presente, scelta viene fatta con stato predizione
		- se assente, inserita nuova riga nella tabella
		- quando risultato branch è noto, si aggiorna stato predizione
- **Branch target buffer** (==BTB==)
	- simile alla BHT, ma contiene anche l'indirizzo di branch
	- permette di capire eventuale indirizzo di salto senza decodificare istruzione di salto
	- + efficiente
![[25. Pipeline/Immagine 10.png|500]]
