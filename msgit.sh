#!/bin/bash

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Clonar el archivo mensajes.md desde el repositorio
git clone https://github.com/$usuario/$repositorio.git
cd $repositorio

while true
do
    # Mostrar los últimos 5 mensajes
    tail -n5 mensajes.md &

    # Esperar 5 segundos
    sleep 5

    # Limpiar la pantalla
    echo ""

    # Esperar a que el usuario ingrese un mensaje
    read -p "Escribe tu mensaje y presiona Enter. Para terminar, escribe 'exit': " mensaje

    # Si se ingresa 'exit', salir del loop
    if [ "$mensaje" == "exit" ]; then
        echo "Saliendo..."
        exit
    fi

    # Agregar el mensaje al archivo mensajes.md
    echo "$mensaje" >> $archivo

    # Esperar 3 segundos
    sleep 3

    # Hacer commit y push del archivo mensajes.md
    git add $archivo
    git commit -m "Agregado mensaje"
    git push -u origin main

    # Actualizar el archivo mensajes.md
    git pull origin main
done
