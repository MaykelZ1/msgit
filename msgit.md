#!/bin/bash

# Nombre de usuario y nombre del repositorio en GitHub
usuario="tu_usuario"
repositorio="tu_repositorio"

# Ruta del archivo que se creará con los mensajes
archivo="mensajes.md"

# URL para subir el archivo al repositorio en GitHub
url="https://api.github.com/repos/MaykelZ1/msgit/contents/msgit.md"

# Token de acceso personal de GitHub
token="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"

echo "Escribe tu mensaje y presiona Enter. Para terminar, escribe 'exit'"
while true; do
  read mensaje
  if [ "$mensaje" == "exit" ]; then
    break
  else
    echo "$mensaje" >> $archivo
  fi
done

echo "Subiendo mensajes al repositorio en GitHub..."

# Codificar el contenido del archivo en Base64
contenido=$(base64 $archivo)

# Crear el JSON para la solicitud POST
json=$(printf '{"message":"Agregando mensajes","content":"%s"}' "$contenido")

# Enviar la solicitud POST para subir el archivo al repositorio
curl --header "Authorization: token $token" --header "Content-Type: application/json" --data "$json" $url

echo "Mensajes subidos al repositorio en GitHub"
