#!/bin/bash

while IFS= read -r clave; do

    openssl enc -d -aes256 -iter 1000 \
        -in mensaje-oculto \
        -out mensaje-decifrado \
        -pass pass:"$clave" 2>/dev/null

    if file mensaje-decifrado | grep -qi "text"; then
        echo "Clave REAL encontrada: '$clave'"
        exit 0
    fi

    rm -f mensaje-decifrado

done < diccionario.txt

echo "No se encontró ninguna clave válida."
