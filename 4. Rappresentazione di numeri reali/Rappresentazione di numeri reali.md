## rappresentazione di numeri reali
### fixed point
$$R=(I.F)_2$$
$$R'=R\cdot2^{k_F}$$
- $R$=numero reale
	- $I$=parte intera -> si utilizzano $k_I$ bits
	- $F$=parte frazionaria -> si utilizzano $k_F$ bits
- $k_I$ e $K_F$ sono ==fissi==
- Si utilizza ==complemento a due==
- Approssimazione:
	- per troncamento o arrotondamento
	- funzione $int()$
#### encoding
$$R_{Fix,k,k_F}=R_{C2,k}(int(q\cdot2^{k_F}))=(x_{k-1}\dots x_0)$$
#### decoding
$$
R^{-1}_{Fix,k,k_F}(x)=\frac{R^{-1}_{C2,k}(x)}{2^{k_F}}
$$
#### errore assoluto
$$err_a=|R'-R|:
\begin{cases}
\leq 2^{-\frac{k_{F}}{2}} \text{con arrotondamento} \\
\leq 2^{-2^{k_{F}}} \text{con troncamento}
\end{cases}
$$
- Fisso
#### errore relativo
$$
err_r=\frac{err_a}{|R|}\leq \frac{1}{|R|\cdot2^{k_F}}
$$
- Molto grande per numeri vicini allo zero
![[Immagine 1.png]]
### floating point
- Rappresentazione a virgola mobile
- Standard IEEE 754
$$R=M\cdot2^E=(1.\widetilde{M})_2\cdot2^E$$
- $M=(1.\widetilde{M})_2\cdot2^E$: ==mantissa normalizzata==
- $E$: ==caratteristica==
#### encoding
$$R_{Float}(q)=(x_{31}\dots x_0)$$
![[Immagine 2.png]]
- ==s==: 1 bit segno
- ==e==: 8 bit esponente (codifica eccesso P=127)
	- $e=R_{E,127,8}(E)=R_{N,8}(E+127)$
- ==m==: 23 bit parte frazionaria mantissa normalizzata ($\widetilde{M}$)
#### decoding
$$R^{-1}_{Float}(x)=(1-2s)\cdot(1.m)\cdot 2^{(e)_2-127}$$
#### casi speciali
- $e=0, m=0$
	- $E=-127$
	- numero 0
- $e=0, m≠0$
	- $E=-127$
	- numero non normalizzato moltiplicato per $2^{-126}$
	- $R^{-1}_{Float}(x)=(1-2s)\cdot0.m\cdot2^{-126}$
- $e=255,\,m=0$
	- E=128
	- $\infty$
- $e=255, m≠0$
	- NaN
#### intervallo numeri rappresentabili
- Mantissa: 
	- $M=1.m$
	- $[(1.00\dots0)_2, (1.11\dots1)_2]=[1,2-2^{-23}]$
- Esponente:
	- $E=e-(2^7-1)$
	- $e: ]0, 2^8-1[$
	- $E: ]-(2^7-1), 2^7[$
- Numero più piccolo
	- $|P|=1\cdot2^{-126}\approx10^{-38}$ (mantissa normalizzata)
	- $|P|=0.00\dots1\cdot2^{-126}\approx10^{-45}$ (mantissa non normalizzata)
- Numero più grande
	- $|G|=(2-2^{-23})\cdot2^{127}\approx10^{38}$
#### errore assoluto
- Varia in base alla dimensione del numero rappresentato
- Distanza tra due numeri consecutivi
$$
d=|(1.\widetilde{M})_2\cdot2^E-((1.\widetilde{M})_2+2^{-23})\cdot2^E|=2^{E-23}
$$$$
err_{a}\leq\frac{d}{2}
$$![[Immagine 3.png]]
#### errore relativo
$$
err_r=\frac{err_a}{|R|}\leq2^{-23}
$$
- Non dipende dalla dimensione del numero
ㅤ
ㅤ
ㅤ

ㅤ
ㅤㅤ

ㅤ
ㅤㅤ
ㅤ
### double precision floating point
- 64 bit, precisione doppia
$$R=M\cdot2^E$$
![[Immagine 4.png]]