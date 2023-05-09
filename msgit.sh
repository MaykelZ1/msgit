#!/bin/bash

function limpiar_pantalla {
    sleep 1
    clear
}

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Verificar si el repositorio ya está clonado
if [ ! -d "$repositorio" ]; then
    echo -e "\nClonando archivo mensajes.md desde el repositorio..." >&2
    git clone https://github.com/$usuario/$repositorio.git >&2
    limpiar_pantalla
fi

# Verificar que el directorio msgit existe
if [ ! -d "$repositorio" ]; then
    echo "El directorio $repositorio no existe. Saliendo..."
    exit
fi

cd $repositorio

while true
do
    # Mostrar los últimos 5 mensajes
    echo -e "\n\e[36mMostrando los últimos 5 mensajes:\e[0m" >&2
    tail -n5 mensajes.md

    # Comprobar mensajes nuevos
    echo -e "\n\e[36mComprobando mensajes nuevos...\e[0m" >&2
    git pull origin main > /dev/null 2>&1

    # Esperar a que el usuario ingrese un mensaje
    read -p $'\e[38;5;202m'"Escribe algo: "$'\e[0m' mensaje

    # Si se presiona Enter, ocultar los mensajes de clonación
    if [ -z "$mensaje" ]; then
        limpiar_pantalla
        continue
    fi

    # Si se ingresa 'exit', salir del loop
    if [ "$mensaje" == "exit" ]; then
        echo "Saliendo..." >&2
        exit
    fi

    # Agregar el mensaje al archivo mensajes.md
    echo "$mensaje" >> $archivo

    # Hacer commit y push del archivo mensajes.md
    git add $archivo > /dev/null 2>&1
    git commit -m "Agregado mensaje" > /dev/null 2>&1
    git push -u origin main > /dev/null 2>&1
done
