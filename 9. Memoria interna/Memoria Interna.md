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
![[Pasted image 20240315181407.png|300]]
### cella di memoria
- Può assumere due stati: $0$ e $1$
- Può essere scritta (almeno una volta)
- Può essere letta più volte
### tipi di memoria
![[Pasted image 20240314134511.png]]
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
![[Pasted image 20240315183243.png|200]]
#### static ram (sram)
- Bit viene salvato in un ==flip-flop==
- NO refresh
- **Bassa densità, alta velocità accesso**
- Utilizzata come ==cache==
- 20/35 ns
![[Pasted image 20240315183258.png|300]]
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
![[Pasted image 20240315185136.png|200]]
### organizzazione dram
![[Pasted image 20240315124504.png|500]]
- La memoria è una **matrice** (articolata in 2 dimensione):
	- così il segnale deve percorrere una distanza molto inferiore
- Posso comunicare l'indirizzo in due parti:
	- prima la riga (attiva RAS)
		- copiato in refresh circuitry
	- poi la colonna (attiva CAS)
		- letto da refresh circuitry
- **Bit di controllo**
	- ==RAS== (Row address select): indirizzo indica riga
	- ==CAS== (Column address select): indirizzo indica colonna
	- ==WE== (Write enable): effettua scrittura
	- ==OE== (Output enable): effettua lettura
- Operazione di refresh
	- ogni tot millisecondi devo leggere e riscrivere ogni elemento della memoria
	- refresh counter
		- indica indirizzo riga
	- MUX fa passare segnale del refresh
		- viene letta riga, copiata in refresh circuitry e riscritta
	- facendo una riga alla volta, è molto + efficiente