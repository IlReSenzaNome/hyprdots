#!/bin/bash

# Obtener la fecha y hora actual en un formato legible
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Definir la ruta completa del archivo de video con el nombre basado en la fecha y hora
video_dir="$HOME/Videos"
video_path="$video_dir/screen_$timestamp.mp4"

# Ejecutar wf-recorder con la ruta del archivo de video
wf-recorder -f "$video_path"
