#!/bin/bash

ENC_FILE="mensaje-oculto"
OUT_FILE="resultado"
WORDLIST="diccionario.txt"
ITER=1000

# Validaciones
if [ ! -f "$ENC_FILE" ]; then
    echo "ERROR: No existe el archivo encriptado: $ENC_FILE"
    exit 1
fi

if [ ! -f "$WORDLIST" ]; then
    echo "ERROR: No existe el diccionario: $WORDLIST"
    exit 1
fi

while IFS= read -r PASS; do
    echo "Probando: $PASS"

    if openssl enc -aes256 -d -iter "$ITER" \
        -in "$ENC_FILE" -out "$OUT_FILE" \
        -pass pass:"$PASS" 2>/dev/null; then

        echo "=============================="
        echo "¡Contraseña encontrada!: $PASS"
        echo "=============================="
        exit 0
    fi

done < "$WORDLIST"

echo "No se encontró la contraseña en el diccionario."
exit 1
