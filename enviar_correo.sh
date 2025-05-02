  GNU nano 7.2                                                             enviar_correo.sh *                                                                    #!/bin/bash

# 1️⃣ Pedimos el nombre del usuario
USER=$(zenity --entry --title="Informe de Usuario" --text="Ingrese el nombre de usuario:" --width=400)

# 2️⃣ Verificamos entrada
if [[ -z "$USER" ]]; then
    zenity --error --title="Error" --text="No ingresó ningún usuario. Saliendo..." --width=300
    exit 1
fi

# 3️⃣ Verificamos existencia del usuario
if ! id "$USER" &>/dev/null; then
    zenity --error --title="Error" --text="El usuario '$USER' no existe en el sistema." --width=300
    exit 1
fi

# 4️⃣ Preparamos el informe visual
INFORME=$(mktemp)

{
    echo "🔍 *INFORME DEL USUARIO:* **$USER**"
    echo "========================================"
    echo ""
    echo "📌 *Información General:*"
    id "$USER"
    echo ""
    echo "🏠 *Directorio Home:*"
    echo "$(eval echo ~$USER)"
    echo ""
    echo "📆 *Último Acceso:*"
    lastlog -u "$USER" | tail -n 1
    echo ""
    echo "🧠 *Procesos Activos:*"
    ps -u "$USER" --sort=-%cpu | head -n 10
    echo ""
    echo "🕐 *Fecha de generación:* $(date)"
    echo "========================================"
} >> "$INFORME"

# 5️⃣ Correo fijo
EMAIL="configuraciondelsistema1@gmail.com"

# 6️⃣ Confirmación antes de enviar
zenity --question \
  --title="Confirmación de Envío" \
  --text="Se enviará el informe del usuario '$USER' a:\n$EMAIL\n\n¿Desea continuar?" \
  --width=400

if [[ $? -ne 0 ]]; then
    zenity --info --title="Cancelado" --text="El envío ha sido cancelado." --width=300
    rm "$INFORME"
    exit 0
fi

# 7️⃣ Enviamos el correo (formato de markdown/txt simple)
{
    echo "To: $EMAIL"
    echo "Subject: 🧾 Informe del usuario $USER"
    echo "Content-Type: text/plain; charset=UTF-8"
    echo ""
    cat "$INFORME"
} | ssmtp "$EMAIL"

# 8️⃣ Aviso de éxito
zenity --info --title="Informe Enviado" --text="✅ El informe ha sido enviado correctamente a:\n$EMAIL" --width=300

# 9️⃣ Limpiamos archivo temporal
rm "$INFORME"