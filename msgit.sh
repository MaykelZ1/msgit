#!/bin/bash

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"
temp="temp.md"

# Clonar el archivo mensajes.md desde el repositorio
echo "Clonando archivo mensajes.md desde el repositorio..."
git clone https://github.com/$usuario/$repositorio.git
cd $repositorio

while true
do
    # Actualizar el archivo mensajes.md cada 5 segundos
    tail -n 5 $archivo > $temp
    clear
    echo "Últimos 5 mensajes:"
    cat $temp
    rm $temp
    sleep 5

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
    git push -u origin main > /dev/null

    # Actualizar el archivo mensajes.md
    git pull origin main > /dev/null
done
