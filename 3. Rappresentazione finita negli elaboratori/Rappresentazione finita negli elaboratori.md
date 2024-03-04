## rappresentazione finita negli elaboratori
### introduzione
- **bit** = elemento base rappresentazione informazione
- Le quantità teoriche sono infinite mentre nei computer si possono rappresentare con un numero **finito** di bit
	- SOLO sequenze di bit
	- NO simboli (virgola, punto, cifre, ecc)
	- NON si possono rappresentare numeri la cui rappresentazione eccede numero bit disponibili
![[Numeri 4 bit rappresentazione.png]]

### rappresentazione numeri naturali
#### encoding
$$R_{N,k}(n)=(x_{k-1},...,x_0)$$
- Esempio:
	- $R_{N,3}(1\cdot2^2+0\cdot2^1+1\cdot2^0)=101$

#### decoding
$$R^{-1}_{N,k}(x)=\sum^{k-1}_{i=0}a_i2^i$$
- Esempio:
	- $R^{-1}_{N,3}(101)=1\cdot2^2+0\cdot2^1+1\cdot2^0$

>[!summary] In generale
>- $k$ bits
>- Numeri rappresentabili:  $n\in[0, 2^{k}-1] \cap \mathbb{N}$

### Rappresentazione numeri interi - ampiezza e segno
#### codifica
- Primo **bit** (**+ significativo**): indica **segno**
	- 0 -> +
	-  1 -> -
	- Altri bit: indicano modulo del numero
![[Esempio 4.png|100]]
#### encoding
$$
\begin{cases}
R_{AS,k}(q)=(x_{k-1},\dots,x_0) \\\\
x_{k-1}=
\begin{cases}
1,\text{ se }q<0\\
0,\text{ se }q\geq0 \\
\end{cases}\\ 
x_{k-2}\dots x_0=R_{N,k-1}(|q|)
\end{cases}
$$
#### decoding
$$R^{-1}_{AS,k}(x)=(1-2\cdot x_{k-1})\cdot\sum_{i=0}^{k-2}x_{i\cdot}2^i$$
#### pro e contro
- Due codifiche diverse per dire 0 (+0, -0) -> spreco
- Algoritmo di addizione
	- troppo **lento** per una semplice somma
	- difficile da implementare a livello circuitale

#### estensione numero bit
- Basta aggiungere zeri dopo il bit di segno

> [!summary] In generale
> - k bits
> - $q\in[-(2^{k-1}-1),+(2^{k-1}-1)] \cap \mathbb{Z}$


### rappresentazione eccesso p
#### codifica
- Sposto il range dei numeri da rappresentare sommando a tutti una quantità $P$
	- faccio in modo che il numero più piccolo sia uguale a zero
	- di norma $P=2^{k-1}$
![[Esempio 2.png|250]]
#### encoding
$$
R_{E,P,k}(q)=R_{N,k}(q+P)=(x_{k-1}\dots x_0)
$$
- Esempio:
	- $R_{E,8,4}(-1)=R_{N,4}(-1+8)=R_{N,4}(7)=0111$
#### decoding
$$R^{-1}_{E,P,k}(x)=(\sum_{i=0}^{k-1}x_{i\cdot}2^i)-P$$
- Esempio:
	- $R^{-1}_{E,8,4}(0111)=(2^3+2^2+2^1)-8=7-8=-1$
#### pro e contro
- Se effettuo la somma di due numeri con eccesso P, il risultato mi viene spostato di un offset = P
	- implementazione circuitale della somma risulta quindi più complessa

>[!summary] In generale
>- k bits
>- $q\in[-P,P-1] \cap \mathbb{Z}$

### complemento a 1
#### codifica
- La rappresentazione di un numero negativo si ottiene con il **complemento bit a bit** del suo valore assoluto
	- prendo valore assoluto e inverto tutti i bit
![[Esempio 5.png|150]]
#### encoding
$$
R_{C1,k}(q)=
\begin{cases}
R_{N,k}(q)\text{ se }q\geq0 \\
NOT(R_{N,k}(|q|))\text{ se }q<0
\end{cases}
$$
- Esempio:
	- $R_{C1,4}(-1)=NOT(R_{N,4}(1))=NOT(0001)=1110$
#### decoding
$$
R^{-1}_{C1,k}(x)=(\sum^{k-2}_{i=0}x_{i}\cdot2^i)-x_{k-1}(2^{k-1}-1)
$$
- Esempio:
	- $R^{-1}_{C1,4}(1110)=(1\cdot2^2+1\cdot2^1+0\cdot2^0)-1(2^3-1)=6-1(8-1)=6-7=-1$
#### pro e contro
- Ci sono due codifiche per lo zero
- La somma diventa di difficile realizzazione
>[!summary] In generale
>- k bits
>- $q\in[-(2^{k-1}-1),2^{k-1}-1] \cap \mathbb{Z}$

### complemento a 2
#### codifica
- Per i numeri negativi si somma 1 al complemento a 1
![[Esempio 3.png|200]]
#### encoding
$$
R_{C2,k}(q)=
\begin{cases}
R_{N,k}(q)\text{ se }q\geq0 \\
R_{C1,k}(q)+1\text{ se }q<0
\end{cases}
$$
- Esempio:
	- $R^{-1}_{C2,4}(-1)=R_{C1,4}(-1)+1=1110+1=1111$
#### decoding
$$R^{-1}_{C2,k}=(\sum^{k-2}_{i=0}x_i2^i)-x_{k-1}2^{k-1}$$
- Esempio:
	- $R^{-1}_{C2,4}(1111)=(1\cdot2^2+1\cdot2^1+1\cdot2^0)-1\cdot2^3=7-8=-1$
#### pro e contro
- Ha una sola rappresentazione dello 0
- Il bit più significativo indica il segno
- Ha una struttura ciclica: max + 1 = min
- Somma 2 numeri = somma rappresentazione 2 numeri
#### overflow
- Facile da riconoscere nelle somme guardando le due cifre + significative:
	- NO OVERFLOW: nessun riporto o entrambi
	- SI OVERFLOW: riporto in una delle due
#### estensione numero bit
- Nuovi bit vengono impostati come il bit di segno

>[!summary] In generale
>- k bits
>- $q\in[-2^{k-1},2^{k-1}-1] \cap \mathbb{Z}$