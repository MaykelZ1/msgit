#!/bin/bash

# Nombre de usuario y nombre del repositorio en GitHub
usuario="MaykelZ1"
repositorio="msgit"

# Ruta del archivo que se creará con los mensajes
archivo="mensajes.md"

# Función para subir los mensajes al repositorio en GitHub
upload_messages_to_github() {
  mensaje_commit="Agregando mensajes"
  contenido=$(base64 $archivo)
  json="{\"message\":\"$mensaje_commit\",\"content\":\"$contenido\"}"
  respuesta=$(curl -s -H "Authorization: token $token" -H "Content-Type: application/json" -X PUT -d "$json" "https://api.github.com/repos/$usuario/$repositorio/contents/$archivo?ref=main")
  echo "Mensajes subidos al repositorio en GitHub"
}

# Token de acceso personal de GitHub
token="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"

echo "Escribe tu mensaje y presiona Enter. Para terminar, escribe 'exit'"
while true; do
  read mensaje
  if [ "$mensaje" == "exit" ]; then
    break
  else
    echo "$mensaje" >> $archivo
    upload_messages_to_github
  fi
done

echo "Fin del programa"
