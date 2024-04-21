#!/bin/bash

# Detiene la grabación de video
kill $(pgrep wf-recorder)

# Detiene la grabación de audio (parecord para PulseAudio o pw-record para PipeWire)
kill $(pgrep parecord)

# Rutas de los archivos de video y audio
VIDEO_FILE="output_video.mp4"
AUDIO_FILE="output_audio.wav"

# Nombre del archivo combinado de salida
OUTPUT_FILE="output_combined.mp4"

# Combina el video y el audio utilizando ffmpeg
ffmpeg -i "$VIDEO_FILE" -i "$AUDIO_FILE" -c:v copy -c:a aac -strict experimental "$OUTPUT_FILE"

# Mueve el archivo combinado a la carpeta 'videos' en tu directorio de inicio
mkdir -p ~/videos
mv "$OUTPUT_FILE" ~/videos/

echo "Grabación detenida. Archivo combinado guardado en ~/videos/$OUTPUT_FILE"

