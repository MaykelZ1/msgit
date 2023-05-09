#!/bin/bash

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Clonar el archivo mensajes.md desde el repositorio
echo "Clonando archivo mensajes.md desde el repositorio..."
git clone -q https://github.com/$usuario/$repositorio.git
cd $repositorio

while true
do
    # Clonar el archivo mensajes.md cada 5 segundos
    sleep 5
    git pull -q

    # Limpiar la pantalla y mostrar los últimos 5 renglones del archivo mensajes.md
    clear
    echo "Últimos 5 mensajes:"
    tail -n 5 $archivo

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
    git push -q -u origin main

    # Actualizar el archivo mensajes.md
    git pull -q
done
