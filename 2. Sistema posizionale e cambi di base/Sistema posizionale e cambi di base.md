## sistema posizionale e cambi di base
### sistema posizionale
- Cifre uguali in **posizioni** diverse hanno significato diverso
$$(\dots a_2a_1a_0.a_{-1}\dots)_b=\sum^{+\infty}_{i=-\infty}a_ib^i=\dots+a_2b^2+a_1b+a_0b^0+a_{-1}b^{-1}+....$$
- Esempio
- $4.34_{10} = (4·10^0 + 3·10^{-1} + 4·10^{-2})_{10}$
### conversione da base 10 a base b - parte intera
#### metodologia
Si prendono i resti delle divisioni successive per b
	- $a_{k+1}=a_k÷b$ (ed elimino eventuale resto)
	- se $a_k=0$ mi fermo
	- risultato dato dalla serie dei resti iniziando dall'ultimo
![[Conversione da decimale a binario.png|200]]
#### dimostrazione
$$N=\sum^{+\infty}_{i=0}a_ib^i=a_0+\sum^{+\infty}_{i=1}a_ib^i$$
- Effettuo divisone intera per b
	- rimane $a_0$ perché la sommatoria è multipla di b
$$N\bmod b=a_0$$
- Ripetendo lo stesso procedimento 
	- posso ottenere gli altri coefficienti $a_1\,a_2\dots$
ㅤ
ㅤ
ㅤ
### conversione da base 10 a base b - parte frazionaria
#### metodologia
- Metodo iterativo
	- se $a_k>1$ -> $a_{k+1}=(a_k-1)*b$ 
	- se $a_k<1$ -> $a_{k+1}=a_k*b$
	- se parte decimale di $a_k=0$ oppure ad un risultato ottenuto in precedenza -> mi fermo 
	- risultato dato dalla serie delle parti intere partendo dal primo

![[Conversione da decimale a binario dopo virgola.png|200]]
#### dimostrazione
$$\sum^{+\infty}_{i=1}a_{-i}b^{-i}=a_{-1}b^{-1}+\sum^{+\infty}_{i=2}a_{-i}b^{-i}$$
- Moltiplico per b e ottengo:
$$(\sum^{+\infty}_{i=1}a_{-i}b^{-i})b=a_{-1}+b(\sum^{+\infty}_{i=2}a_{-i}b^{-i})=a_{-1}+\sum^{+\infty}_{i=2}a_{-i}b^{-i+1}$$
- La parte intera del risultato sarà dunque data da $a_{-1}$
	- posso ottenere gli altri coefficienti frazionari procedendo ricorsivamente in questo modo

### rappresentazione esadecimale
- Rappresentazione in **base 16**
	- $A=10_{10}$
	- $B=11_{10}$
	- $C=12_{10}$
	- $D=13_{10}$
	- $E=14_{10}$
	- $F=15_{10}$
- Conversione da binaria a esadecimale
	- $16=2^4$ -> raggruppo bit 4 a 4 **da destra**
- Esempio:
	- $0111\,1111_2=7F_{16}=0x7F$

>[!warning] importante
>- Ricorda sempre di avere numero bit multiplo di 4
>- Se non è multiplo bisogna aggiungere 0 nei bit più significativi

### rappresentazione ottale
- Rappresentazione in **base 8**
- Conversione da binaria a ottale
	- $8=2^3$ -> raggruppo bit 3 a 3 **da destra**
- Esempio
	- $100\,010_2=42_8$
