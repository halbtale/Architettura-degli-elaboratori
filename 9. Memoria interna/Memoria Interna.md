## memoria interna
### caratteristiche dellla memoria centrale
- Divisa in ==locazioni==
	- ogni locazione contiene $L$ bit (in genere $1\,byte=8\,bit$)
	- ogni locazione è individuata da un indirizzo
- Con indirizzi di $N$ bit, possono essere indicizzabili $2^n$ locazioni
- Dimensione totale: $L\cdot N$
### ordinamento dei bite in memoria
#### dimensione locazione memoria ≠ dimensione word
- Problema:
	- devo salvare una word: 4 byte
	- una locazione contiene solo 1 byte
- Soluzione:
	- salvo 4 byte in 4 locazioni consecutive
#### big e little endian
- ==Big Endian==
	- memorizzata dalla parte più significativa a quella meno significativa
- ==Little Endian==
	- memorizzata dalla parte meno significativa a quella più significativa
#### esempio
- Memorizzare: $0xAABBCCDD$
![[9. Memoria interna/Immagine 3.png|300]]
### cella di memoria
- Può assumere due stati: $0$ e $1$
- Può essere scritta (almeno una volta)
- Può essere letta più volte
### tipi di memoria
![[9. Memoria interna/Immagine 1.png]]
### memorie persistenti
#### rom (read only memory)
- Contenuto è **permanente** e non può essere cambiato
- Dati scritti sull'**hardware** durante il processo di fabbricazione
- Inserimento dati **costoso** 
#### prom (programmable rom)
- Contenuto è **permanente** e non può essere cambiato
- Si può scrivere il valore in una memoria vuota **dopo** processo di fabbricazione
- Maggiore flessibilità e minor costo rispetto alla rom
####  eprom (erasable prom)
- Memoria **persistente**
- Si può cancellare **tutta** la memoria con **radiazioni ultraviolette**
#### eeprom (electically erabable prom)
- Si possono cancellare **singoli bit** con segnali elettrici
- + costosa di EPROM e densità minore
#### flash memory
- La **cancellazione** avviene per **settori**
- Compromesso tra EPROM e EEPROM
	- ha densità più alta ed è meno costosa di EEPROM
### memoria volatile: ram (random-access memory)
- Memoria ==volatile== in cui si può leggere e scrivere efficientemente
#### dynamic ram (dram)
- Bit rappresentato da presenza o meno della carica in un ==condensatore==
- Richiede ==refresh== periodico
	- condensatore tende a disperdere la carica
	- i dati vengono periodicamente letti e riscritti
- **Alta densità, velocità accesso limitata**
- Utilizzata come ==memoria principale==
- 2/3 ns
![[9. Memoria interna/Immagine 4.png|200]]
#### static ram (sram)
- Bit viene salvato in un ==flip-flop==
- NO refresh
- **Bassa densità, alta velocità accesso**
- Utilizzata come ==cache==
- 20/35 ns
![[9. Memoria interna/Immagine 5.png|300]]
### organizzazione chip dram
![[9. Memoria interna/Immagine 2.png|500]]
- La memoria è una **matrice** (articolata in 2 dimensione):
	- così il segnale deve percorrere una distanza molto inferiore
	- ogni locazione è determinata da un indirizzo (riga + colonna)
	- ogni locazione può contenere + bit
- Indirizzo comunicato al chip in due parti
	- prima indirizzo **riga**
		- ==RAS== (Row address select): indirizzo indica riga
	- poi indirizzo **colonna** 
		- ==CAS== (Column address select): indirizzo indica colonna
- Selezionata la cella (o celle) di memoria ad un indirizzo
	- ==WE== (Write enable): effettua scrittura
		- viene scritta la locazione da "**Data Input Buffer**"
	- ==OE== (Output enable): effettua lettura
		- viene letta la locazione su "**Data Output Buffer**"
- Operazione di refresh
	- ogni tot millisecondi devo leggere e riscrivere ogni elemento della memoria
	- refresh counter
		- indica indirizzo riga
	- MUX fa passare segnale del refresh
		- viene letta riga, copiata in refresh circuitry e riscritta
- Sono presenti anche dei pin **Vcc** e **Vss** per il funzionamento del chip
- SRAM è identica ma non ha "Refresh Circuitry"
![[9. Memoria interna/Immagine 7.png|200]]
#### ottimizzazione refresh
- Analisi
	- $T_r=\text{periodo in cui effettuare refresh memoria}$
	- $N=\text{numero elementi su cui effettuare refresh}$
	- $t_r=\frac{T_r}{N}=\text{tempo disponibile per fare refresh di un elemento}$
	- $t_a=\text{tempo di accesso per effettuare refresh di un elemento}$
	- $P=\frac{t_a}{t_r}\cdot100=\text{tempo in percentuale impiegato per refresh}$
- Osservazione
	- conviene fare il refresh una riga alla volta invece che un bit alla volta
		- riducendo N, si diminuisce il tempo percentuale impiegato per il refresh
### organizzazione della memoria
- $N$ locazioni e $L$ bit/locazione
- Implementata attraverso struttura gerarchica
- **Chip di memoria**
	- contiene $N_{1}$ locazioni con $L_1$ bit/locazione
	- es. $N_1=1G\,locazioni$ e $L_{1}=8\,bit=1\,byte$ 
- **Modulo**
	- Insieme di chip di memoria -> incrementa dimensione bit/locazione
	- Es. 8 chip -> $L=8\cdot L_1=8\cdot8=64\,bit=8\,byte$ 
- **Banchi**
	- Insieme di più moduli -> incrementa numero di locazioni totali
	- Es. 2 moduli (uno per lato) -> $N_2=2\cdot N_1=2\cdot 1G\,locazioni=2G\,locazioni$
- **Memoria RAM**
	- Insieme di più banchi
	- Es. 4 banchi -> $N=4\cdot N_2=4\cdot 2G\,locazioni=8G\,locazioni$
	- Dimensione totale: $L\cdot N=8G locazioni \cdot 8\,byte/locazione=64GB$
![[9. Memoria interna/Immagine 6.png|200]]
![[9. Memoria interna/Immagine 8.png|400]]
![[9. Memoria interna/Immagine 9.png]]

