function log() {
    msg=$1
    echo -e "\n\033[32m[+]\033[0m $msg\n"
}

log "Initiating pacman key"
sudo pacman-key --init
sudo pacman-key --populate artix

log "Fetching arch mirrorlist"
sudo curl -s "https://archlinux.org/mirrorlist/?country=NZ&protocol=https&ip_version=4&use_mirror_status=on" | sed -e "s/^#Server/Server/" -e "/^#/d" | sudo tee /etc/pacman.d/mirrorlist-arch

log "Fetching pacman config"
sudo curl -s "https://pastebin.com/raw/1JrtGtKn" -o /etc/pacman.conf

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
sudo pacman -S base-devel git wget appmenu-gtk-module 

log "Installing yay"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

log "Installing programs"
yay -S kitty flameshot discord spotify telegram-desktop-bin visual-studio-code-bin github-desktop-bin brave-bin minecraft-launcher spicetify-cli ffmpeg4.4 zenity

log "Install Tela Circle icons"
git clone "https://github.com/vinceliuice/Tela-circle-icon-theme" && cd Tela-circle-icon-theme && chmod +x install.sh && ./install.sh -a && cd .. && rm -rf Tela-circle-icon-theme

log "Installing themes"
yay -S catppuccin-kde-theme-git catppuccin-gtk-theme-mocha catppuccin-mocha-dark-cursors 

log "Installing lightly application style"
sudo pacman -S lightly-qt

log "Installing fonts"
yay -S nerd-fonts-complete ttf-apple-emoji

log "Configuring grub"
sudo curl -s "https://pastebin.com/raw/bsSPHejP" -o /etc/default/grub
sudo update-grub