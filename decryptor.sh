#!/bin/bash

archivo="mensaje-oculto"
diccionario="diccionario.txt"

# Limpiar posibles CR al final de cada línea (Windows)
sed -i 's/\r$//' "$diccionario"

while IFS= read -r clave || [ -n "$clave" ]; do
    # Intentar descifrar con la clave
    openssl enc -d -aes256 -salt -iter 1000 \
        -in "$archivo" \
        -out temp.out \
        -pass pass:"$clave" 2>/dev/null

    # Validar que el archivo tenga contenido
    if [ $? -eq 0 ] && [ -s temp.out ]; then
        echo "Clave REAL encontrada: '$clave'"
        mv temp.out mensaje-decifrado
        exit 0
    fi

    rm -f temp.out
done < "$diccionario"

echo "No se encontró ninguna clave válida."
