#!/bin/bash

archivo="mensaje-oculto"
diccionario="diccionario.txt"

for clave in $(cat $diccionario); do
    # Descifrar con la clave
    openssl enc -d -aes256 -iter 1000 \
        -in "$archivo" \
        -out mensaje-decifrado \
        -pass pass:$clave 2>/dev/null

    # Revisar si el archivo descifrado contiene texto ASCII
    if file mensaje-decifrado | grep -q "ASCII text"; then
        echo "Clave real encontrada: $clave"
        exit 0
    fi

    # Limpia si no era buena
    rm -f mensaje-decifrado
done

echo "No se encontró clave válida."
