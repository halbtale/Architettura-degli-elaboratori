## memoria interna
### caratteristiche dellla memoria centrale
- Divisa in ==locazioni==
- Ogni locazione contiene $L$ bit
- Con indirizzi di $n$ bit, ci possono essere $2^n$ locazioni
	- dimensione indirizzi dipendono da dimensione bus e dimensione memoria
- Dimensione **massima** memoria
	- $L\cdot2^n$
### ordinamento dei bite in memoria
- Architettura ARM
	- $word=32bit=4 byte$
	- $l=8 bit=1 byte$
	- vengono lette 4 locazioni consecutive
#### notazione little o big endian
- Sceglie se leggere notazioni da basso verso l'alto o dall'alto verso il basso
### memoria
- Insieme di registri
### tipi di memoria
![[Pasted image 20240314134511.png]]
#### rom (read only memory)
- Dati scritti sull'hardware
#### prom (programmable rom)
- Si può scrivere il valore in una memoria vuota
- Una volta scritta, non si può più cambiare
####  eprom (erasable prom)
- Si può cancellare con radiazione ultravioletta
#### eeprom (electically erabable prom)
- Si può cancellare con segnali elettrici singoli bit
#### flash memory
- La cancellazione avviene per settori
- Compromesso tra EPROM e EEPROM
#### ram (random access memory)
- Memoria che si può leggere e scrivere facilmente
- Tipologie
	- **Dynamic RAM (DRAM)**
		- con condensatore, che dopo un po' si scarica
		- + piccola, + lenta, + economica
		- utilizzata come memoria principale
		- 2/3 ns
	- **Static RAM (SRAM)**
		- simile a flip-flop
		- + grande, + veloce, + costosa
		- utilizzata come cache
		- 20/30 ns
### organizzazione della memoria
- $N$ locazioni e $L$ bit/locazione
- **Chip di memoria**
	- numero locazioni e bit/locazione fissi
	- $N_{1}<N$ e $L_{1}<L$
	- es. chip con 1G locazioni da 8 bit
- **Modulo**
	- + chip di memoria vengono messi assieme
	- Espando bit per locazione: $L_{1}\rightarrow L$
	- es. modulo con 1G locazioni da 64 bit
- **Banchi**
	- Metto insieme + moduli per ottenere $N_{1}\rightarrow N$ locazioni
	- es. banco con 16G locazioni da 64 bit
### organizzazione dram
![[Pasted image 20240315124504.png|500]]
- La memoria è una matrice (articolata in 2 dimensione)
	- il segnale deve percorrere una distanza di un ordine di grandezza molto inferiore
- Posso comunicare l'indirizzo in due parti:
	- prima la riga 
		- copiato in refresh circuitry
	- poi la colonna
		- letto da refresh circuitry
- Bit di controllo
	- RAS: indirizzo indica riga
	- CAS: indirizzo indica colonna
	- WE: write enable (effettua scrittura)
	- OE: output enable (effettua lettura)
- Operazione di refresh
	- ogni tot millisecondi devo leggere e riscrivere ogni elemento della memoria
	- refresh counter
		- indica indirizzo riga
	- MUX fa passare segnale del refresh
		- viene letta riga, copiata in refresh circuitry e riscritta
	- facendo una riga alla volta, è molto + efficiente