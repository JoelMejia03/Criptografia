#!/bin/bash

# Archivo encriptado (tu archivo)
ENC_FILE="mensaje-oculto"

# Archivo donde se escribe el resultado si descifra
OUT_FILE="resultado"

# Diccionario de contraseñas
WORDLIST="diccionario.txt"

# Iteraciones permitidas por OpenSSL (puedes ajustar según como encriptaste)
ITER=1000

while IFS= read -r PASS; do
    echo "Probando: $PASS"

    # Intento de desencriptado
    if openssl enc -aes256 -iter $ITER -in "$ENC_FILE" -out "$OUT_FILE" -pass pass:"$PASS" 2>/dev/null; then
        echo "=============================="
        echo "¡Contraseña encontrada!: $PASS"
        echo "Archivo desencriptado en: $OUT_FILE"
        echo "=============================="
        exit 0
    fi

done < "$WORDLIST"

echo "No se encontró ninguna contraseña en el diccionario."
exit 1
