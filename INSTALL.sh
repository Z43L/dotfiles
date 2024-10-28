#!/bin/bash

# Actualizar el sistema
sudo pacman -Syu --noconfirm

# Paquetes necesarios para Hiperland y sus dependencias
packages=(
    "hyprland"  # Compositor principal
    "kitty"  # Emulador de terminal
    "waybar-hyprland"  # Barra de estado compatible con Hyprland
    "swww"  # Fondo de escritorio
    "swaylock-effects"  # Bloqueo de pantalla
    "wofi"  # Menú de aplicaciones
    "wlogout"  # Menú de cierre de sesión
    "mako"  # Notificaciones
    "xdg-desktop-portal-hyprland-git"  # Portal de escritorio para Hyprland
    "swappy"  # Editor de capturas de pantalla
    "grim"  # Herramienta de capturas de pantalla
    "slurp"  # Selección de área para capturas
    "thunar"  # Gestor de archivos
    "polkit-gnome"  # Autenticación gráfica
    "pamixer"  # Control de audio
    "pavucontrol"  # Control de volumen
    "brightnessctl"  # Control de brillo
    "bluez"  # Servicio de Bluetooth
    "bluez-utils"  # Utilidades de Bluetooth
    "blueman"  # Administrador gráfico de Bluetooth
    "network-manager-applet"  # Applet de red
    "gvfs"  # Soporte de sistema de archivos virtual
    "thunar-archive-plugin"  # Complemento de archivos comprimidos
    "file-roller"  # Administrador de archivos comprimidos
    "btop"  # Monitor del sistema
    "starship"  # Prompt avanzado para la terminal
    "ttf-jetbrains-mono-nerd"  # Fuente de Nerd Fonts
    "noto-fonts-emoji"  # Soporte de emoji
    "lxappearance"  # Configurador de temas GTK
    "xfce4-settings"  # Configuración de XFCE
    "sddm"  # Gestor de inicio de sesión
    "zsh"  # Shell Zsh
    "oh-my-zsh"  # Framework de configuración para Zsh
)

# Instalación de los paquetes
echo "Instalando paquetes necesarios..."
sudo pacman -S --noconfirm "${packages[@]}"

# Establecer Zsh como shell predeterminada
chsh -s /bin/zsh

# Clonar el repositorio de dotfiles y mover archivos
echo "Clonando y configurando los archivos de dotfiles..."
git clone https://github.com/Z43L/dotfiles.git ~/dotfiles_temp

# Copiar archivos de configuración a .config
cp -r ~/dotfiles_temp/.config/* ~/.config/

# Copiar el archivo .zshrc a la carpeta de usuario
cp ~/dotfiles_temp/.zshrc ~/
cp ~/dotfiles_temp/Images ~/

# Limpiar archivos temporales
rm -rf ~/dotfiles_temp

echo "Configuración completada. Reinicia la sesión para aplicar los cambios."
