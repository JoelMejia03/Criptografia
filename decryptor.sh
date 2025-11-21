#!/bin/bash

archivo="mensaje-oculto"
diccionario="diccionario.txt"

# Limpiar espacios finales en el diccionario
sed -i 's/[ \t]*$//' "$diccionario"

while IFS= read -r clave; do
    # Intentar descifrar con la clave actual
    openssl enc -d -aes256 -iter 1000 \
        -in "$archivo" \
        -out mensaje-decifrado \
        -pass pass:"$clave" 2>/dev/null

    # Verificar si el descifrado produjo un archivo válido
    # Para archivos binarios o texto, revisamos que el tamaño sea mayor a 0
    if [ -s mensaje-decifrado ]; then
        echo "Clave REAL encontrada: '$clave'"
        exit 0
    fi

    # Si no es válido, borramos el archivo generado
    rm -f mensaje-decifrado

done < "$diccionario"

echo "No se encontró ninguna clave válida."
