#!/bin/bash

for clave in $(cat diccionario.txt); do
    if openssl enc -d -aes256 -iter 1000 \
        -in mensaje-oculto \
        -out mensaje-decifrado \
        -pass pass:$clave 2>/dev/null; then
        
        echo "Clave encontrada: $clave"
        break
    fi
done


