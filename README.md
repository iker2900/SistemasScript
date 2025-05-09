Proyecto: Panle de administrador con Zenity  
Autores: Laura, Iker, David y Sergio

Descripción:
Este proyecto es un conjunto de scripts en Bash diseñados para facilitar tareas básicas de administración de sistemas en un entorno Ubuntu (WSL), utilizando interfaces gráficas simples con Zenity.

Requisitos:
- Ubuntu con WSL (Windows Subsystem for Linux)
- Zenity instalado: sudo apt install zenity
- Permisos de ejecución para los scripts: chmod +x *.sh

Instrucciones de uso:
1. Abre una terminal en el directorio del proyecto.
2. Asegúrate de tener Zenity instalado.
3. Otorga permisos de ejecución con:  
   chmod +x *.sh
4. Ejecuta el menú principal con:  
   ./menu.sh

Scripts incluidos:

- **menu.sh**  
  Script principal que muestra una interfaz gráfica para acceder a las distintas funcionalidades del sistema.

- **crear_usuario.sh**  
  Permite crear un nuevo usuario en el sistema a través de un diálogo interactivo.

- **baja_usuario.sh**  
  Permite eliminar un usuario del sistema utilizando Zenity para seleccionar y confirmar la acción.

- **enviar_correo.sh**  
  Simula o realiza el envío de un correo electrónico, dependiendo de la configuración del sistema.

Notas:
- Este proyecto está orientado al aprendizaje de administración básica en sistemas Linux y uso de Zenity.
- El script `menu.sh` actúa como lanzador y organiza la interacción entre los demás scripts.

Versión: 1.0  
Licencia: MIT (puede modificarse según preferencias)
