#!/bin/bash

# Variables de configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Clonar el repositorio si aún no existe en la carpeta actual
if [ ! -d "./$repositorio" ]; then
  git clone "https://github.com/$usuario/$repositorio.git"
fi

# Función para guardar mensaje en el archivo mensajes.md
function guardar_mensaje {
  echo "$1" >> "./$repositorio/$archivo"
  echo "Mensaje guardado."
}

# Función para hacer commit y push al repositorio
function push_repo {
  cd "./$repositorio"
  git add "$archivo"
  git commit -m "Actualización automática de mensajes"
  git push -u origin main
  cd ..
  echo "Mensaje guardado y subido al repositorio en GitHub."
}

# Loop para guardar mensajes indefinidamente
while true; do
  read -r mensaje
  if [ "$mensaje" = "exit" ]; then
    break
  fi
  guardar_mensaje "$mensaje"
  hay_cambios=$(git -C "./$repositorio" status --porcelain)
  if [ -n "$hay_cambios" ]; then
    echo "Hay mensajes nuevos."
    sleep 3
    push_repo
  else
    echo "No hay mensajes nuevos."
  fi
done
