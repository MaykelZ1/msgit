#!/bin/bash

# Datos del usuario
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Función para guardar el mensaje en el archivo mensajes.md
function guardar_mensaje {
    echo "$1" >> $archivo
}

# Clonar el archivo mensajes.md del repositorio
git clone --quiet "https://github.com/$usuario/$repositorio.git" 2>&1 >/dev/null

# Loop infinito para leer mensajes desde la entrada estándar
while true; do
    # Leer mensaje desde entrada estándar
    read -t 3 mensaje

    # Si no se ha leído nada, continuar esperando
    if [ -z "$mensaje" ]; then
        continue
    fi

    # Si se ha leído algo, guardar el mensaje en el archivo mensajes.md
    guardar_mensaje "$mensaje"

    # Mensaje de confirmación
    echo "Mensaje guardado."

done
