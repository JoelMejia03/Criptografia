#!/bin/bash

archivo="mensaje-oculto"
diccionario="diccionario.txt"

# Limpiar caracteres CR (si vienen de Windows)
sed -i 's/\r$//' "$diccionario"

while IFS= read -r clave || [ -n "$clave" ]; do
    echo "Probando clave: $clave"

    # Intentar descifrar el archivo
    openssl enc -d -aes256 -salt -iter 1000 \
        -in "$archivo" \
        -out temp.zip \
        -pass pass:"$clave" 2>/dev/null

    # Validar si el ZIP es válido
    if unzip -p temp.zip >/dev/null 2>&1; then
        echo "🎉 Clave REAL encontrada: '$clave'"
        mv temp.zip mensaje-decifrado.zip
        exit 0
    fi

    rm -f temp.zip
done < "$diccionario"

echo "❌ No se encontró ninguna clave válida."

