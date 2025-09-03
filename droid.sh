#!/bin/bash

IMAGE_NAME="droid_6.9.4-jre_21"
DATA_DIR="$(pwd)/data"
CONTAINER_NAME="droid_container"

declare -A commands
commands=(
    [build]="docker build -t $IMAGE_NAME ."
    [remove]="docker rmi $IMAGE_NAME"
    [run]="docker run --rm -it -v \"$DATA_DIR\":/home/data -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name $CONTAINER_NAME $IMAGE_NAME ./droid.sh"
)

function show_help() {
    echo "Uso:"
    echo "  ./droid.sh build        # Construir la imagen docker"
    echo "  ./droid.sh remove       # Eliminar la imagen docker"
    echo "  ./droid.sh run [args]   # Ejecutar droid con interfaz gráfica y parámetros opcionales"
    echo "    Ejemplo: ./droid.sh run -r /data/miarchivo.xml"
}

# Permitir conexiones X11 para Docker (una vez por sesión)
function allow_x11() {
    xhost +local:docker > /dev/null 2>&1
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

action=$1
shift

if [[ -n ${commands[$action]} ]]; then
    if [[ "$action" == "run" ]]; then
        allow_x11
        eval ${commands[$action]} "$@"
    else
        eval ${commands[$action]}
    fi
else
    echo "Comando desconocido: $action"
    show_help
    exit 1
fi