#!/bin/bash

# Rutas de salida para el video y el audio
VIDEO_FILE="output_video.mp4"
AUDIO_FILE="output_audio.wav"

# Inicia la grabación de video en segundo plano
wf-recorder -f "$VIDEO_FILE" &

# Guarda el PID del proceso de wf-recorder
WF_RECORDER_PID=$!

# Inicia la grabación de audio en segundo plano (usando parecord para PulseAudio o pw-record para PipeWire)
# Si estás usando PipeWire, cambia 'parecord' por 'pw-record'
parecord "$AUDIO_FILE" &

# Guarda el PID del proceso de parecord
PARECORD_PID=$!
