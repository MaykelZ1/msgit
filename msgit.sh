#!/bin/bash

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

while true
do
    # Comprobar si se ha presionado la tecla F1
    if [[ $- == *i* ]] && [[ -t 0 ]]; then
        read -s -n1 key
        if [ "$key" == $'\x1b' ]; then
            read -s -n2 key
            if [ "$key" == "[[A" ]; then
                echo -e "\nReiniciando el script..."
                sleep 1
                clear
                exec $0
            fi
        fi
    fi

    # Clonar el archivo mensajes.md desde el repositorio
    if [ ! -d "$repositorio" ]; then
        echo -ne "\e[36mClonando archivo mensajes.md desde el repositorio...\n\e[0m"
        git clone https://github.com/$usuario/$repositorio.git > /dev/null 2>&1
    fi
    cd $repositorio

    # Mostrar los últimos 5 mensajes
    echo -ne "\e[36mComprobando mensajes nuevos...\n\e[0m"
    git pull origin main > /dev/null 2>&1
    echo -e "\e[36mMostrando los últimos 5 mensajes:\e[0m"
    tail -n5 mensajes.md

    # Esperar 5 segundos
    sleep 5

    # Esperar a que el usuario ingrese un mensaje
    read -p $'\e[38;5;208mEscribe algo: \e[0m' mensaje

    # Si se ingresa 'exit', salir del loop
    if [ "$mensaje" == "exit" ]; then
        echo "Saliendo..."
        exit
    fi

    # Agregar el mensaje al archivo mensajes.md
    echo "$mensaje" >> $archivo

    # Esperar 1 segundo
    sleep 2

    # Hacer commit y push del archivo mensajes.md
    git add $archivo > /dev/null 2>&1
    git commit -m "Agregado mensaje" > /dev/null 2>&1
    git push -u origin main > /dev/null 2>&1

done
