## metodi di indirizzamento
### tabella tipologie di indirizzamento
![[12. Metodi di indirizzamento/Immagine 9.png]]
### indirizzamento Immediato
![[12. Metodi di indirizzamento/Immagine 1.png|200]]
- Il valore da utilizzare è indicato nel **campo operando**
- Utilizzi
	- definire costanti
	- definire valore iniziale di una variabile
- Vantaggi
	- Indirizzamento + semplice
	- Non è necessario accedere alla memoria
- Svantaggi
	- dimensione numero limitata (6/8 bit)
```arm
MOV R0, #5
MOV R1, R0, #0xD
```

>[!warning] Attenzione
>In ARM solo l'ultimo operando può avere indirizzamento Immediato

### indirizzamento diretto
![[12. Metodi di indirizzamento/Immagine 2.png|300]]
- Il valore si trova in memoria
- Dentro l'istruzione si trova l'indirizzo di memoria del valore
- Vantaggi
	- permette di rappresentare valori + grandi
	- abbastanza veloce da calcolare
		- IR -> MAR -> memoria -> MBR -> R0
- Svantaggi
	- spazio limitato di indirizzamento
```
MOV R0, (0x00AA)
```

>[!failure] Non esiste in ARM

### indirizzamento indiretto
![[12. Metodi di indirizzamento/Immagine 4.png|200]]
- Contiene l'indirizzo di memoria di una word contenente l'indirizzo dell'operando
- Vantaggi
	- ampio spazio di indirizzamento
- Svantaggi
	- richiede 2 accessi di memoria -> + lento
```
MOV R0, ((0x00AA))
```

>[!failure] Non esiste in ARM

### diretto di registro
![[12. Metodi di indirizzamento/Immagine 5.png|200]]
- Il campo indirizzo R indica un registro che contiene il valore
- Vantaggi
	- posso indicizzare tutti i registri
	- non devo accedere alla memoria
- Svantaggi
	- ci sono pochi registri quindi posso indicizzare pochi valori
```
MOV R0, R1
```
<div style="page-break-after: always;"></div>

### indiretto di registro
![[12. Metodi di indirizzamento/Immagine 6.png|300]]
- Il campo R contiene l'indirizzo del registro che contiene l'indirizzo di memoria del valore
- Vantaggi
	- ampio spazio di indirizzamenti
- Svantaggi
	- richiede 1 accesso in memoria
```
LDR R0, [R1]
```

### indirizzamento con offset
![[12. Metodi di indirizzamento/Immagine 7.png|300]]
- Istruzione contiene indirizzo R a cui verrà sommato A (offset)

#### indirizzamento con registro base
- I campi contengono
	- R -> registro che contiene indirizzo in memoria
	- A -> offset da quell'indirizzo
```
LDR R1, [R0, #4]
```

#### indirizzo (auto)relativo
- I campi contengono
	- R (implicito) -> PC
	- A -> offset dall'indirizzo base, in complemento a 2
- Viene sfruttato internamente per le istruzioni di salto o le pseudoistruzioni
```
LDR R1, [PC, #4]
LDR R1, =variabile @avviene internamente con questa istruzione
```

#### indirizzamento indice
- I campi contengono
	- R -> registro indice che contiene offset
	- A -> contiene indirizzo di memoria di partenza
- È l'inverso dell'indirizzamento con registro base
```
MOV R0, [R1, (0x00AA)]
```

>[!failure] Non esiste in ARM
>- L'unica alternativa è usare due registri: uno per l'indirizzo base e l'altro per l'offset
>- ```LDR R2, [R0, R1]```
#### autoindicizzazione
- Automaticamente aumenta o decrementa il contenuto del registro indice
- **Pre-incremento**
	- prima incrementa R0 di un offset e copia in R1 la word al nuovo indirizzo di R0
```
LDR R1, [R0, #1]! @R1=[++R0]
```
- **Post-incremento**
	- copia in R1 la word contenuta all'indirizzo di R0 e poi incrementa R0 di un offset
```
LDR R1, [R0], #1 @R1=[R0++]
```

### indicizzamento con stack
![[12. Metodi di indirizzamento/Immagine 8.png|200]]
- Il valore viene preso dallo stack della memoria
```
PUSH {R0, R2-R4} @inserisce R4, R3, R2, R0 nello stack
POP {R0, R2-R4} @copia gli elementi dallo stack in R0, R1, R2, R3, R4
```