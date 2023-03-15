#!/usr/bin/env bash
# shellcheck disable=SC1087

# <-- Variables -->
# Colors
green="\033[32m"
red="\033[31m"
reset="\033[0m"

#

# <-- Functions -->
function log() {
    msg=$1
    echo -e "\n$green[+]$reset $msg\n"
}

function error() {
    msg=$1
    echo -e "\n$green[!]$reset $msg\n"
}

# <-- Main -->
log "Configuring grub"
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 udev.log_level=0 vt.global_cursor_default==0 console=tty2"/g' /etc/default/grub
sudo sed -i 's/GRUB_TIMEOUT="3"/GRUB_TIMEOUT="0"/g' /etc/default/grub
sudo sed -i 's/GRUB_GFXMODE="1024x768,800x600"/GRUB_GFXMODE=1920x1080/g' /etc/default/grub
sudo update-grub

log "Initiating pacman key"
sudo pacman-key --init
sudo pacman-key --populate artix

log "Fetching arch mirrorlist"
sudo curl -s "https://archlinux.org/mirrorlist/?country=NZ&protocol=https&ip_version=4&use_mirror_status=on" | sed -e "s/^#Server/Server/" -e "/^#/d" | sudo tee /etc/pacman.d/mirrorlist-arch

log "Fetching pacman config"
sudo curl -s "https://raw.githubusercontent.com/paintingofblue/Artix/main/pacman/pacman.conf" -o /etc/pacman.conf

log "Installing Chaotic"
sudo pacman -Syyu
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman-key --populate artix # Populating artix again because it fucks itself for some reason
sudo pacman -U "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst" "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"
echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

log "Updating pacman after installing Chaotic"
sudo pacman -Syyu

log "Installing dependencies"
sudo pacman -S base-devel git wget artix-archlinux-support
sudo pacman-key --populate archlinux

log "Installing yay"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

log "Installing programs"
yay -S kitty flameshot discord spotify telegram-desktop-bin visual-studio-code-bin github-desktop-bin brave-bin minecraft-launcher vlc obs-studio-git bleachbit-git cleanerml-git fabric-installer spicetify-cli steam neovim

log "Install programming languages"
yay -S rustup
rustup default stable

log "Installing dependencies"
yay -S appmenu-gtk-module gtk-engines

log "Installing lightly application style"
sudo pacman -S lightly-qt

log "Installing fonts"
yay -S ttf-apple-emoji

log "Installing adblock"
yay -S blokator
sudo blokator --sync
sudo blokator --apply

log "Installing dotfiles"
yay -S betterlockscreen brightnessctl bspwm cava chezmoi dunst eww feh file-roller gvfs inter-font jq kripton-theme-git lxappearance maim moreutils pamixer picom picom-animations-git playerctl polybar recode rofi sxhkd thunar ttf-firacode-nerd ttf-ubuntu-mono-nerd xdg-user-dirs xdo xorg xqp

log "Uninstalling unwanted programs"
sudo pacman -R falkon konqueror plasma-workspace-wallpapers gwenview okular mpv

log "Clear cache"
sudo rm -rf ~/.cache/*