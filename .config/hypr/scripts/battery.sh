#!/bin/bash

# Directorio donde están almacenados los iconos
iDIR="$HOME/.config/mako/icons"
#!/bin/sh

while true; do
    # Obtener el estado de la batería y el nivel de carga
    estado=$(acpi -b | awk '{print $3}' | sed 's/,$//')
    nivel_carga=$(acpi -b | grep -Eo "[0-9]+%" | grep -Eo "[0-9]+")

    if [ $estado == "Discharging" ] && [ $nivel_carga -eq 10 ]; then
        dunstify -a "Bateria baja" -i $iDIR/battery-low.png "Nivel de bateria: $nivel_carga%"
        canberra-gtk-play -i dialog-error -d "error"
    fi

    if [ $estado == "Discharging" ] && [ $nivel_carga -eq 20 ]; then
        echo "pff tiramos de bateria, conectameeeee"
        dunstify -a "Bateria baja" -i $iDIR/battery-mid "Nivel de bateria: $nivel_carga%"
        canberra-gtk-play -i dialog-error -d "error"
    fi

    if [ $estado == "Charging" ] && [ $nivel_carga -eq 100 ]; then
        dunstify -a "Bateria cargada" -i $iDIR/battery-high.png "Bateria cargada completamente"
        canberra-gtk-play -i dialog-error -d "error"
    fi
    # Esperar un tiempo antes de volver a verificar (ajusta el tiempo como desees)
    sleep 120  # 120 segundos
done
