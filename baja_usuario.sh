#!/bin/bash

# Pedir usuario a dar de baja
usuario=$(zenity --entry --title="⛔ Baja Usuario" --text="Introduce el nombre de usuario:")

# Pedir fecha de baja (YYYY-MM-DD)
fecha_baja=$(zenity --calendar --title="📅 Fecha de Baja" --date-format="%Y-%m-%d")

# Programar la baja del usuario
sudo chage -E $fecha_baja $usuario && \
zenity --info --text="✅ Usuario $usuario será dado de baja el $fecha_baja." || \
zenity --error --text="❌ Error al programar la baja del usuario."




