#!/bin/bash

for passwd in $(500-worst-passwords.txt); do
	openssl enc -d -aes256 -iter 1000 -k "$passwd" -in mensaje-oculto -out mensaje.decifrado 2>/dev/null

if [$? -eq 0]; then
	echo -e "[+] La password correcta es: $passwd"
	break
fi
done

