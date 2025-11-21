#!/bin/bash

WORDLIST="500-worst-passwords.txt"
ENC_FILE="mensaje-oculto"
OUT_FILE="mensaje-decifrado"

while IFS= read -r passwd; do
    echo "Probando: $passwd"

    openssl enc -d -aes256 -iter 1000 \
        -in "$ENC_FILE" \
        -out "$OUT_FILE" \
        -pass pass:"$passwd" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo ""
        echo "===================================="
        echo "[+] CONTRASEÑA ENCONTRADA: $passwd"
        echo "[+] Archivo descifrado en $OUT_FILE"
        echo "===================================="
        exit 0
    fi

done < "$WORDLIST"

echo "No se encontró la contraseña en el diccionario."
