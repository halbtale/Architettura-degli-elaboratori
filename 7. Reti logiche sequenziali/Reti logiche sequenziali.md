## reti logiche sequenziali

### registro
- Dispositivo in grado di **memorizzare nel tempo un valore logico**
![[7. Reti logiche sequenziali/Immagine 6.png|200]]
#### latch
- Dipendono dal ==livello== dei segnali in ingresso
#### flip-flop
- Sensibili ai ==fronti== dei segnali d'ingresso
### clock
- **Clock**
	- segnale che oscilla tra 0 e 1 con una data frequenza
- **Circuito** ==asincrono==
	- l'output è determinato da come cambiano i segnali in ogni istante di tempo
	- latch
		- dipendono dal **livello** dei segnali in ingresso
- **Circuito** ==sincrono==
	- l'output è determinato dai valori dei segnali in certi istanti di tempo
	- instanti di tempo sono dati dal segnale di clock
	- flip-flop: 
		- sensibili ai **fronti** dei segnali d'ingresso
### latch r-s
- Meccanismo
	- ==R== = 1 -> **Reset**: Q=0
	- ==S== = 1 -> **Set**: Q=1
	- $P=\overline{Q}$
	- Si assume che non siano mai entrambi a 1
![[7. Reti logiche sequenziali/Immagine 1.png|200]]
#### Implementazione
	![[Pasted image 20240308130512.png|300]]
- Rimettere gli output negli input permette di mantenere lo stato
	- dopo qualche iterazione si stabilizza
	- se R,S vengono impostati a 0, lo stato si preserva
### flip-flop
#### flip-flop r-s
![[7. Reti logiche sequenziali/Immagine 3.png|500]]
- Clock oscilla periodicamente tra 0 e 1
- Se clock=0 -> propaga (0,0) -> non cambia output
- Se clock=1 -> propaga (R,S)
- Il clock è in grado di congelare lo stato del sistema
#### flip-flop j-k
![[7. Reti logiche sequenziali/Immagine 5.png|500]]
- Simile al flip-flop R-S
	- K -> R
	- J -> S
- Gli output controllano passaggio input (per evitare situazioni incontrollate)
	- Se $Q$=0, blocca passaggio segnale K (reset) 
	- Se $\overline{Q}$=0, blocca passaggio segnale J (set)
- Permette funzione di **toggle**
	- Se $K=J=1$
		- quando $Q=0$, passa solo $J=1$ quindi $set$
		- quando $Q=1$, passa solo $K=1$ quindi reset
	- ciò viene regolato dal clock
#### flip-flop di tipo d
![[7. Reti logiche sequenziali/Immagine 4.png|500]]
- Invece di avere R ed S distinte, ho solo una linea D
	- così evito caso (1,1)
- D = dato
	- viene memorizzato
- In aggiunta al clock, posso avere un segnale di controllo che attiva arbitrariamente la memorizzazione del dato D
#### flip flop di tipo d (master-slave)
- Ingesso e uscita disaccoppiati
- Memorizza il nuovo valore solo nel fronte di discesa del clock
	- permette di far cambiare il valore di $Q_0$ una volta ad ogni iterazione del clock
	- se il clock è lungo (es. rimane fisso a 1 per un po' di tempo), $Q_0$ non viene modificato
		- cambia solo quando clock passa da 1->0
![[7. Reti logiche sequenziali/Immagine 10.png|300]]
- Funzionamento
	- Clock=1 -> salva $D_0$ in $Q'_{0}$
	- Clock=0 -> salva $Q'_{0}$ in $Q_0$
#### sommario
![[7. Reti logiche sequenziali/Immagine 7.png|400]]
### registri paralleli
- Insieme di più memorie da 1 bit che possono essere lette/scritte in **parallelo**
#### implementazione
![[7. Reti logiche sequenziali/Immagine 8.png|600]]
### registri a scorrimento (shift registers)
- Insieme di più memorie da 1 bit che possono essere lette/scritte **serialmente**
- A ciascun impulso del clock, i contenuti nel registro scorrono di una posizione verso destra
- Esempio di applicazione: divisione per 2 in binario
#### implementazione
![[7. Reti logiche sequenziali/Immagine 9.png|500]]
- Il dato salvato in ogni registro viene dato in ingresso al successivo
- Quando il clock=1, il valore di ogni registro viene salvato nel successivo
	- bisogna calibrare bene il clock o si rischia che vengano effettuati più shift contemporaneamente
#### implementazione con flip-flop master-slave
![[7. Reti logiche sequenziali/Immagine 11.png|500]]
- Viene effettuato uno shift ad ogni fronte di discesa del clock, indipendentemente dalla sua durata
	- quando Clock=1, $M$ memorizzano valore ma $S$ rimangono uguali
	- quando Clock=0, $S$ memorizzano valore ma $M$ rimangono uguali
### contatore binario
![[7. Reti logiche sequenziali/Immagine 12.png|500]]

### sintesi di reti logiche sequenziali
- La **funzione logica** della rete combinatoria nel sistema sequenziale dipende da:
	- input
	- valori dello stato in cui si trova il sistema
		- ovvero degli output precedenti memorizzati in registri
- **Stato del sistema**
	- contenuto nei registri
	- per $Z$ stati servono $P=\log_2(Z)$ bit
![[7. Reti logiche sequenziali/Immagine 13.png|600]]
### macchina di mealy
![[Pasted image 20240309161529.png|200]]
- **Rete combinatoria C2
	- $S'_i=C2(X_{i},S_{i})$
	- aggiorna lo stato in base a input e vecchio stato
- **Rete combinatoria C1**
	- $Y_i=C1(X_{i}, S_i)$
	- fornisce output in base a input e stato
### macchina di moore
![[Pasted image 20240309161836.png|200]]
- **Rete combinatoria C1'
	- $S'_i=C1'(X_{i},S_{i})$
	- aggiorna lo stato in base a input e vecchio stato
- **Rete combinatoria C2'**
	- $Y_i=C2'(S_i)$
	- fornisce output SOLO in base allo stato
