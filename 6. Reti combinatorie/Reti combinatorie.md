## reti combinatorie
### valori logici
- 2 valori logici
	- ==0==
	- ==1==
### porta logica
- Dispositivo con N ingressi e 1 uscita
- Implementazione di una funzione logica elementare
### porta not
- Inverte valore input
![[Pasted image 20240304133233.png|200]]
- Caratteristiche
	- la linea indica un canale che trasferisce il valore logico
	- triangolo -> trasmette segnale
	- pallino -> inverte segnale
### porta and
- Restituisce 1 solo se tutti gli input sono 1
![[Screenshot 2024-03-04 alle 13.34.06.png|200]]
### porta or
- Restituisce 1 solo se almeno 1 degli input è uguale a 1
![[Screenshot 2024-03-04 alle 13.34.50.png|200]]
### porta nand
- Not AND
![[Pasted image 20240304133526.png|200]]
### porta nor
- Not OR
![[Pasted image 20240304133608.png|200]]
### porta xor (or esclusivo)
- 1 se e solo se gli input sono diversi
![[Screenshot 2024-03-04 alle 13.46.06.png|200]]
### equivalenze porte logiche
- Tutte le porte logiche si possono implementare solo OR e NOT
	- si possono sfruttare leggi di De Morgan

![[Screenshot 2024-03-04 alle 13.38.41.png|500]]
![[Screenshot 2024-03-04 alle 13.38.46.png|500]]
- Tutte le porte logiche si possono implementare solo con NAN o NOR
![[Screenshot 2024-03-04 alle 13.38.52.png|600]]
### tabelle di verità
- Modo per rappresentare una funzione
	- esplicita i valori di uscita per ogni combinazione dei valori di ingresso
![[Pasted image 20240304134312.png]]
### registro da un bit
- Dispositivo in grado di memorizzare un bit
![[Pasted image 20240304134830.png|300]]
### bus
- Collegamento elettrico tra parti diverse di un elaboratore
	- consente trasferimento dell'informazione
- Composto da linee
	- ogni linea consente di trasferire un bit
![[Pasted image 20240304134949.png]]
### gruppi di bit
- 4 bit: "**nibble**"
- 8 bit: "**byte**"
- 16 bit: "**half-word**"
- 32 bit: "**word**" (word si basa su taglia memoria -> computer a 32 bit)
- 64 bit: "**double-word**"
### reti logiche combinatorie
- Valori uscita determinati **UNIVOCAMENTE** dai valori in entrata
- Caratteristiche
	- **priva di stato**
	- **interamente descritta dalla sua tabella di verità**
### multiplexer n/1
- Caratteristiche
	- $n+\log_2(n)$ bit di input
	- $1$ bit di output
![[Pasted image 20240304135416.png|200]]
#### esempio
- A,B: linee input
- C: bit di controllo
	- linea che decide quale di A o B propagare in output
	- C=0 -> trasmetto A
	- C=1 -> trasmetto B
- Y: output
