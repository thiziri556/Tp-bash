#!/bin/bash

SEUIL=${1:-80}

UTILISATION=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Espace disque utilisé : $UTILISATION%"
echo "Seuil fixé : $SEUIL%"

if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : l'espace disque utilisé a atteint ou dépassé le seuil !"
    exit 1
else
    echo "OK : l'espace disque utilisé est inférieur au seuil."
    exit 0
fi
