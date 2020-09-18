#!/bin/bash

# Deklaration von Variablen
n=0
IMGS=36
BUTTON_NOT_PRESSED=1400
BUTTON_PRESSED=1750

# pigpiod starten und Ausgang konfigurieren
pigpiod
pigs pfs 14 50

# Schleife zum Aufnehmen der Fotos

while [ $n -le $IMGS ]
do
        echo "Getting image $n"

        # Druckknopf auslösen
        pigs servo 14 $BUTTON_PRESSED

        # 0.5 Sekunden warten
        sleep 0.5

        # Servo wieder in Neutralstellung bringen
        pigs servo 14 $BUTTON_NOT_PRESSED
     
        # Foto mit gphoto2 aufnehmen
        gphoto2 --trigger-capture
        
        # Zählervariable erhöhen
        n=$(( n+1 ))     # increments $n
done

# pigpiod wieder beenden
pkill pigiod