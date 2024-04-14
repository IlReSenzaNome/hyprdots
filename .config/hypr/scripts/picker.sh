#!/bin/bash

# Captura el contenido deseado y lo copia al portapapeles
hyprpicker -a

# Espera un poco para asegurarse de que el contenido esté en el portapapeles
sleep 0.5

# Obtiene el contenido del portapapeles
CLIPBOARD_CONTENT=$(wl-paste)

# Muestra una notificación con el contenido del portapapeles
notify-send -t 2000 -i $HOME/.config/mako/icons/picker.ico "Hyprpicker" "The color is: $CLIPBOARD_CONTENT copied to clipboard"

