#!/bin/bash

# Configuración
usuario="MaykelZ1"
token="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"
repositorio="msgit"
archivo="mensajes.md"

# Función para clonar el archivo mensajes.md desde el repositorio
clonar_archivo() {
    echo "Clonando archivo mensajes.md desde el repositorio..."
    git clone https://github.com/$usuario/$repositorio.git > /dev/null 2>&1
    cd $repositorio
}

# Función para mostrar los últimos 5 mensajes del archivo mensajes.md
mostrar_ultimos_mensajes() {
    echo "Últimos mensajes:"
    tail -n 5 $archivo
}

# Clonar el archivo mensajes.md desde el repositorio
clonar_archivo
# Mostrar los últimos 5 mensajes del archivo mensajes.md
mostrar_ultimos_mensajes

# Loop infinito para agregar mensajes al archivo mensajes.md y subirlos al repositorio
while true
do
    # Esperar 5 segundos antes de clonar el archivo mensajes.md
    sleep 5
    clonar_archivo

    # Esperar a que el usuario ingrese un mensaje
    read -p "Escribe tu mensaje y presiona Enter. Para terminar, escribe 'exit': " mensaje

    # Si se ingresa 'exit', salir del loop
    if [ "$mensaje" == "exit" ]; then
        echo "Saliendo..."
        exit
    fi

    # Agregar el mensaje al archivo mensajes.md
    echo "$mensaje" >> $archivo

    # Hacer commit y push del archivo mensajes.md
    echo "Subiendo mensaje al repositorio..."
    git add $archivo > /dev/null 2>&1
    git commit -m "Agregado mensaje" > /dev/null 2>&1
    git push -u origin main > /dev/null 2>&1

    # Actualizar el archivo mensajes.md
    echo "Actualizando archivo mensajes.md desde el repositorio..."
    git pull origin main > /dev/null 2>&1

    # Mostrar los últimos 5 mensajes del archivo mensajes.md
    mostrar_ultimos_mensajes
done
