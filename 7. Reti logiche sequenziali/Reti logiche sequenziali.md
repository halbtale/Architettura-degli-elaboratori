## reti logiche sequenziali
### definizione
- Rete logica
- Output determinati da:
	- valori presenti agli ingressi
	- valori dello stato in cui si trova il sistema
### circuiti sequenziali
#### latch
- Dipendono dal livello dei segnali in ingresso
- Guarda se segnale è 0 o 1
#### flip-flop
- Sensibili ai fronti dei segnali d'ingresso
- È sensibile ai passaggi (da 0 a 1 o da 1 a 0)
### latch r-s
![[Pasted image 20240308130147.png|200]]
- Meccanismo
	- R=1 -> Reset: Q=0
	- S=1 -> Set: Q=1
- Implementazione
	![[Pasted image 20240308130512.png|300]]
### clock
- Circuito ==asincrono==
	- l'output è determinato da come cambiano i segnali in ogni istante di tempo
- Circuito ==sincrono==
	- l'output è determinato dai valori dei segnali in certi istanti di tempo
	- instanti di tempo sono dati dal segnale di clock
### flip-flop r-s con clock
![[Pasted image 20240308131621.png]]
- Clock assume valori: 0/1
- Se clock=0 -> propaga (0,0) -> non cambia output
- Se clock=1 -> propaga (R,S)
- Il clock è in grado di congelare lo stato del sistema
### flip-flop di tipo d
![[Pasted image 20240308132008.png]]
- Invece di avere R ed S distinte, ho solo una linea D
	- così evito (1,1)
- D = dato
	- viene memorizzato
### flip-flop j-k
![[Pasted image 20240308132504.png]]
- La coppia (K=1, J=1) inverte il valore di Q di continuo
	- il clock può bloccare l'inversione
### registro
![[Pasted image 20240308133117.png|200]]
- In grado di memorizzare nel tempo un valore logico
- Può essere implementato, ad esempio, con un flip-flop D
### registri a più bit
- Registri paralleli
	- passo clock e load (segnale di controllo)
- Registri a scorrimento