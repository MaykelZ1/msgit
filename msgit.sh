#!/bin/bash

usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

echo "Mensajes existentes:"
curl -H "Authorization: token $token" -s "https://api.github.com/repos/$usuario/$repositorio/contents/$archivo" | grep -oP '(?<="download_url": ")[^"]*' | xargs curl -s | base64 --decode

while true; do
    read -p "Escribe tu mensaje y presiona Enter. Para terminar, escribe \"exit\": " mensaje

    if [ "$mensaje" == "exit" ]; then
        echo "Adios."
        break
    fi

    echo "$mensaje" >> $archivo
    git add $archivo
    git commit -m "{\"message\":\"Agregando mensaje: $mensaje\",\"content\":\"$(base64 $archivo)\",\"branch\":\"main\"}" >/dev/null 2>&1
    git push --set-upstream origin main >/dev/null 2>&1

    echo "Mensaje guardado y subido al repositorio en GitHub."
done
