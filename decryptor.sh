#!/bin/bash

for clave in $(cat diccionario.txt); do

    # Intentar descifrar
    openssl enc -d -aes256 -iter 1000 \
        -in mensaje-oculto \
        -out mensaje-decifrado \
        -pass pass:$clave 2>/dev/null

    # Verificar si el resultado es TEXTO real
    if file mensaje-decifrado | grep -qi "text"; then
        echo "Clave REAL encontrada: $clave"
        exit 0
    fi

    # Si no es texto, eliminarlo
    rm -f mensaje-decifrado

done

echo "No se encontró ninguna clave válida."
