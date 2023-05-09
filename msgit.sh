#!/bin/bash

usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Clonar el repositorio si no existe
if [ ! -d "msgit" ]; then
  git clone "https://github.com/$usuario/$repositorio.git" msgit
fi

while true
do
  echo "Escribe tu mensaje y presiona Enter. Para terminar, escribe 'exit': "
  read mensaje

  if [ "$mensaje" == "exit" ]; then
    break
  else
    echo "$mensaje" >> msgit/$archivo
    echo "Mensaje guardado en $archivo."
  fi

  # Esperar 3 segundos antes de hacer el commit y push
  sleep 3

  # Hacer commit y push del archivo
  cd msgit
  git add $archivo
  git commit -m "Actualización de mensajes"
  git push origin main
  cd ..

  echo "Mensaje subido al repositorio en GitHub."

  # Descargar la versión más reciente del archivo mensajes.md
  curl -s "https://raw.githubusercontent.com/$usuario/$repositorio/main/$archivo" | jq -sR '.' > $archivo

  # Mostrar el contenido del archivo mensajes.md
  if [ -s "$archivo" ]; then
    echo "Mensajes existentes:"
    cat $archivo
  else
    echo "No hay mensajes nuevos."
  fi
done
