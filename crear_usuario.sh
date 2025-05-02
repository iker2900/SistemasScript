#!/bin/bash


# Archivo para almacenar usuarios y fechas de baja
archivo_usuarios="/ruta/a/archivo_usuarios.txt"

while true; do
    opcion=$(zenity --list --title="👤 Administración de Usuarios" \
        --column="Opción" --column="Descripción" \
        1 "Añadir usuario convencional" \
        2 "Administración de usuarios (Solo administradores)" \
        3 "Generar informe de usuarios" \
        4 "Enviar informe por correo" \
        5 "Salir" \
        --width=500 --height=300)

    case $opcion in
        1)
            # Crear usuario convencional
            usuario=$(zenity --entry --title="🆕 Crear Usuario" --text="Introduce el nombre de usuario:")

            if [[ -z "$usuario" ]]; then
                zenity --error --text="❌ No ingresaste un nombre de usuario."
                continue
            fi

            # Verificar si el usuario ya existe
            if id "$usuario" &>/dev/null; then
                           zenity --error --text="❌ El usuario '$usuario' ya existe."
                continue
            fi

            sudo useradd -m "$usuario" && \
            zenity --info --text="✅ Usuario '$usuario' creado como Convencional." || \
            zenity --error --text="❌ Error al crear el usuario Convencional."
            ;;
       
        2)
            # Administración de usuarios (solo para administradores)
            admin_check=$(zenity --password --title="🔑 Autenticación" --text="Introduce tu contraseña de administrador:" --hide-text)

            # Verificar si la autenticación es correcta (ajustar según sistema)
            echo "$admin_check" | sudo -S whoami &>/dev/null
            if [[ $? -ne 0 ]]; then
                zenity --error --text="❌ Autenticación fallida. No tienes permisos de administrador."
                continue
            fi

            admin_opcion=$(zenity --list --title="🛠 Administración de Usuarios" \
                --column="Opción" --column="Descripción" \
                1 "Dar de baja a un usuario antes de la fecha" \
                2 "Visualizar fechas de baja registradas" \
                3 "Regresar al menú principal" \
                --width=500 --height=300)

            case $admin_opcion in
             1)
                    # Dar de baja a un usuario antes de la fecha estipulada
                    usuario_baja=$(zenity --entry --title="🗑 Dar de Baja Usuario" --text="Introduce el nombre de usuario a dar de baja antes de la fecha:")      

                    if [[ -z "$usuario_baja" ]]; then
                        zenity --error --text="❌ No ingresaste un nombre de usuario."
                        continue
                    fi

                    # Verificar si el usuario existe
                    if ! id "$usuario_baja" &>/dev/null; then
                        zenity --error --text="❌ El usuario '$usuario_baja' no existe."
                        continue
                    fi

                    # Eliminar usuario y actualizar el archivo de bajas
                    sudo userdel -r "$usuario_baja" && \
                    sed -i "/^$usuario_baja,/d" "$archivo_usuarios" && \
                    zenity --info --text="✅ Usuario '$usuario_baja' dado de baja inmediatamente." || \
                    zenity --error --text="❌ Error al dar de baja al usuario '$usuario_baja'."
                    ;;

                2)
                    # Mostrar todas las bajas registradas en un calendario
                    if [[ -f "$archivo_usuarios" ]]; then
                        bajas=$(awk -F',' '{print $2}' "$archivo_usuarios" | tr '\n' ' ')
                                               zenity --calendar --title="📅 Fechas de Baja Registradas" --text="Fechas de baja registradas:\n$bajas" --date-format="%Y-%m-%d"
                    else
                        zenity --error --text="❌ No hay bajas registradas."
                    fi
                    ;;

                3)
                    continue
                    ;;
            esac
            ;;

        3)
            # Generar informe de usuarios
            if [[ ! -f "$archivo_usuarios" ]]; then
                zenity --error --text="❌ No hay usuarios registrados."
                continue
            fi

            informe=$(cat "$archivo_usuarios")
            zenity --info --title="📄 Informe de Usuarios" --text="$informe"
            ;;
       
        4)
            zenity --info --text="📧 Funcionalidad de enviar correo no implementada en este ejemplo."
            ;;
                   ;;
       
        5)
            exit 0
            ;;
       
        *)
            zenity --error --text="❌ Opción no válida."
            ;;
    esac
done