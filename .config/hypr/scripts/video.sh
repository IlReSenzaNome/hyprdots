#!/bin/bash

VIDEO_FILE="output_video.mp4"
DESKTOP_AUDIO_FILE="output_desktop_audio.wav"
COMBINED_FILE="output_combined.mp4"
VIDEO_PID_FILE="/tmp/video_pid.txt"
AUDIO_PID_FILE="/tmp/audio_pid.txt"

function start_recording() {
    # Iniciar la grabación de video con wf-recorder
    wf-recorder -f "$VIDEO_FILE" &
    echo $! > "$VIDEO_PID_FILE"

    # Iniciar la grabación de audio del escritorio con pw-record
    pw-record --monitor=alsa_output.pci-0000_00_09.2.analog-stereo.monitor --format=s16le --channels=2 --rate=44100 "$DESKTOP_AUDIO_FILE" &
    echo $! > "$AUDIO_PID_FILE"

    echo "Grabación de video y audio iniciada."
}

function stop_recording() {
    # Detener la grabación de video
    if [ -f "$VIDEO_PID_FILE" ]; then
        VIDEO_PID=$(cat "$VIDEO_PID_FILE")
        if ps -p $VIDEO_PID > /dev/null; then
            kill $VIDEO_PID
        fi
    fi

    # Detener la grabación de audio del escritorio
    if [ -f "$AUDIO_PID_FILE" ]; then
        AUDIO_PID=$(cat "$AUDIO_PID_FILE")
        if ps -p $AUDIO_PID > /dev/null; then
            kill $AUDIO_PID
        fi
    fi

    # Esperar un momento después de detener la grabación
    sleep 2

    # Verificar si los archivos existen
    if [ ! -f "$VIDEO_FILE" ] || [ ! -f "$DESKTOP_AUDIO_FILE" ]; then
        echo "Error: Archivos de video o audio faltantes."
        exit 1
    fi

    # Combinar video y audio
    ffmpeg -i "$VIDEO_FILE" -i "$DESKTOP_AUDIO_FILE" -c:v copy -c:a aac -strict experimental "$COMBINED_FILE"

    # Mover el archivo combinado a la carpeta de videos
    mkdir -p ~/videos
    mv "$COMBINED_FILE" ~/videos/

    # Eliminar los archivos de video y audio originales
    rm "$VIDEO_FILE" "$DESKTOP_AUDIO_FILE"

    echo "Grabación detenida. Archivo combinado guardado en ~/videos/$COMBINED_FILE"
}

# Verificar si la grabación está en curso o no
if [ -f "$VIDEO_PID_FILE" ] && [ -f "$AUDIO_PID_FILE" ]; then
    stop_recording
else
    start_recording
fi

