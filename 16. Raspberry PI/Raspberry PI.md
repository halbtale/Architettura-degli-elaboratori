## raspberry pi
### il dispositivo raspy
- Modello: Raspberry PI Model A+
- Single-board computer
	- contiene sulla stessa scheda processore, memoria, interfacce I/O
- Specifiche tecniche:
	- Processore: **Broadcom BCM2837B0**
		- architettura **ARM** (**Cortex-A53**)
		- 64 bit
		- 1.4GHz
	- Ram: 512MB SDRAM
	- Interfaccia **GPIO** (General Purpose Input/Output)
		- 40 pin
	- **Porte**
		- Micro SD con scheda 16GB
		- Single USB 2.0
		- HDMI
		- uscita audio a 4 poli
		- videocamera CSI
		- display DSI
	- **Alimentazione** 5V/2.5A DC
		- tramite Micro USB
- Dispositivi I/O presenti nella scheda
	- 6 dispositivi di input
		- 4 switch
		- 2 pulsanti
	- 5 dispositivi di output
		- 4 led
		- 1 display
### dati di accesso
- Username: pi
- Password: lab
- IP: 192.168.1.3
### Collegamento
- Tramite SSH
```
ssh pi@192.168.1.3
```
- Tramice VNC
### compilazione file assembly arm
- Compilare file
```
gcc -ggdb -o main main.s
```
- Eseguire file
```
./main
```
- Effettuare debug
```
gdbgui main
```
