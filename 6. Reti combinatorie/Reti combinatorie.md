## reti combinatorie
### valori logici
- 2 valori logici
	- ==0==
	- ==1==
### porta logica
- Dispositivo con N ingressi e 1 uscita
- Implementazione di una funzione logica elementare
#### porta not
- Inverte valore input
- Caratteristiche
	- la linea indica un canale che trasferisce il valore logico
	- triangolo -> trasmette segnale
	- pallino -> inverte segnale
#### porta and
- Restituisce 1 solo se tutti gli input sono 1
#### porta or
- Restituisce 1 solo se almeno 1 degli input è uguale a 1
#### porta nand
- Not AND
#### porta nor
- Not OR
#### porta xor (or esclusivo)
- 1 se e solo se gli input sono diversi
![[6. Reti combinatorie/Immagine 2.png]]
### equivalenze porte logiche
- Tutte le porte logiche si possono implementare solo con
	- 1. OR e NOT
	- 2. AND e NOT
	- 3. NAND
	- 4. NOR
	- si possono sfruttare leggi di De Morgan
- Esempio:
![[6. Reti combinatorie/Immagine 6.png|500]]
### tabelle di verità
- Modo per rappresentare una funzione
	- esplicita i valori di uscita per ogni combinazione dei valori di ingresso
![[6. Reti combinatorie/Immagine 1.png|500]]
### bus
- Collegamento elettrico tra parti diverse di un elaboratore
	- consente trasferimento dell'informazione
- Composto da linee
	- ogni linea consente di trasferire un bit
![[6. Reti combinatorie/Immagine 4.png]]
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
### funzioni logiche n/1
- $n$ input -> combinazioni valori possibili: $2^n$
- 1 output -> valori possibili: $2$
- Funzioni logiche generabili (combinazioni totali):
	- $2^{2^n}$
### funzioni logiche n/m
- $n$ input -> combinazione possibili valori: $2^n$
- $m$ output -> combinazione possibili valori: $2^m$
- Funzioni logiche generabili (combinazioni totali):
	- $(2^m)^{2^n}$
### algebra booleana
![[6. Reti combinatorie/Immagine 9.png]]
- Xor Identities
	- $A\cdot \overline{B}\,+\overline{A}\cdot B\, = A \oplus B$
	- $A\cdot B\,+\overline{A}\cdot \overline{B}\, = \overline{A \oplus B}$

### somma di prodotti
- Tecnica per generare la funzione logica da tabella di verità
- Osservo quando output = 1
	- trovo condizione di ogni riga in cui E=1 (attraverso prodotti)
	- sommo tutte le condizioni
![[6. Reti combinatorie/Immagine 10.png]]
$$
E=\overline{A}\cdot\overline{B}+A\cdot B
$$
### prodotti di somme
- Tecnica per generare la funzione logica da tabella di verità
- Osservo quando output = 0
	- trovo condizione di ogni riga in cui E=0 (attraverso somma)
	- moltiplico tutte le condizioni
![[6. Reti combinatorie/Immagine 11.png]]
$$
E=(A+\overline{B})\cdot(\overline{A}+B)
$$
### multiplexer n/1
- $n$ bit di input
- $\log_2(n)$ bit di controllo
	- servono per decidere quale dei segnali di input trasmettere
	- indicano insieme il numero in binario del bit di input
		- se ho solo due input: 0/1 (basta 1 bit)
		- se ho tre/quattro input: 00/01/10/11 (servono 2 bit)
		- in generale, il numero massimo di input esprimibili è dato da $n=2^{x}$, $x$ numero di bit di controllo, dati $n$ input sono necessari $x=\log_2(n)$ bit di controllo
- $1$ bit di output
#### multiplexer 2/1
- A,B: linee input
- C: bit di controllo
	- linea che decide quale di A o B propagare in output
	- C=0 -> trasmetto A
	- C=1 -> trasmetto B
- Y: output
![[6. Reti combinatorie/Immagine 5.png|200]]
![[6. Reti combinatorie/Immagine 7.png|400]]
### encoder 2^n/n
- $2^n$ bit di input
- $n$ bit di output
- Attivando $i-esimo$ input, viene codificato negli output in binario il valore $i$
#### esempio decoder 4/2
- L'implementazione circuitale si può ricavare dalle mappe di Karnaugh
![[6. Reti combinatorie/Immagine 3.png|200]]
![[6. Reti combinatorie/Immagine 13.png|200]]

### decoder n/2^n
- $n$ bit di input
- $2^n$ bit di output
- I bit di input codificano in modo univoco quale segnale di output attivare
	- $i-esima$ uscita dove $i$ è il valore binario degli ingressi
![[6. Reti combinatorie/Immagine 8.png|200]]
#### realizzazione
- Sfrutto porta logica AND
	- metto i NOT sui bit che voglio che si attivino quando sono 0