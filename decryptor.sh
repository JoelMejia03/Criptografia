#!/bin/bash

archivo="mensaje-oculto"
diccionario="diccionario.txt"

while IFS= read -r clave || [ -n "$clave" ]; do
    
    # Intentar descifrar a un archivo temporal
    openssl enc -d -aes256 -salt -iter 1000 \
        -in "$archivo" \
        -out temp.out \
        -pass pass:"$clave" 2>/dev/null

    # Validar si abrió correctamente
    if [ $? -eq 0 ] && [ -s temp.out ]; then
        echo "Clave encontrada: $clave"
        mv temp.out mensaje-decifrado
        exit 0
    fi

    rm -f temp.out

done < "$diccionario"

echo "No se encontró ninguna clave válida."
