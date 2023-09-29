#/bin/bash
#  ___           _        _ _  
# |_ _|_ __  ___| |_ __ _| | | 
#  | || '_ \/ __| __/ _` | | | 
#  | || | | \__ \ || (_| | | | 
# |___|_| |_|___/\__\__,_|_|_| 
#                              
# by Andrew Baxter (2023) 
# ----------------------------------------------------- 
# Install Script for required packages
# ------------------------------------------------------

# ------------------------------------------------------
# Load Library
# ------------------------------------------------------
source $(dirname "$0")/scripts/library.sh
clear
echo "  ___           _        _ _  "
echo " |_ _|_ __  ___| |_ __ _| | | "
echo "  | ||  _ \/ __| __/ _  | | | "
echo "  | || | | \__ \ || (_| | | | "
echo " |___|_| |_|___/\__\__,_|_|_| "
echo "                              "
echo "by Andrew Baxter (2023)"
echo "-------------------------------------"
echo ""

# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------
if sudo pacman -Qs yay > /dev/null ; then
    echo "yay is installed. You can proceed with the installation"
else
    echo "yay is not installed. Will be installed now!"
    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd ~/yay-git
    makepkg -si
    cd ~/dotfiles/
    clear
    echo "yay has been installed successfully."
fi

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo ""
echo "-> Install main packages"

packagesPacman=(
    # Apps
    "mpv" # media player
    "vlc" # Video Player

    # Utilities
    "pacman-contrib"
    "pipewire" # Audio
    "lxappearance-gtk3" # Theme Switcher
    "figlet" # Easy ASCII CLI text
    "xfce4-power-manager" # Power Manager
    "freerdp" # Remote Desktop Protocol
    "blueman" # Bluetooth Manager

    qt5-wayland #qt compatability api
    qt6-wayland #qt compatability api
    

    # Fonts
    "ttf-ms-win11-auto" # Windows 11 Fonts
    "ttf-font-awesome" # Font Awesome
    "otf-aurulent-nerd"   
    "otf-codenewroman-nerd"   
    "otf-comicshanns-nerd"    
    "otf-droid-nerd"  
    "otf-firamono-nerd"   
    "otf-hasklig-nerd"    
    "otf-hermit-nerd"     
    "otf-opendyslexic-nerd"   
    "otf-overpass-nerd"   
    "ttf-3270-nerd"   
    "ttf-agave-nerd"  
    "ttf-anonymouspro-nerd"   
    "ttf-arimo-nerd"  
    "ttf-bigblueterminal-nerd"    
    "ttf-bitstream-vera-mono-nerd"    
    "ttf-cascadia-code-nerd"  
    "ttf-cousine-nerd"    
    "ttf-daddytime-mono-nerd"     
    "ttf-dejavu-nerd"     
    "ttf-fantasque-nerd"  
    "ttf-firacode-nerd"   
    "ttf-go-nerd"     
    "ttf-hack-nerd"   
    "ttf-heavydata-nerd"  
    "ttf-iawriter-nerd"   
    "ttf-ibmplex-mono-nerd"   
    "ttf-inconsolata-go-nerd"     
    "ttf-inconsolata-lgc-nerd"    
    "ttf-inconsolata-nerd"    
    "ttf-iosevka-nerd"    
    "ttf-iosevkaterm-nerd"    
    "ttf-jetbrains-mono-nerd"     
    "ttf-lekton-nerd"     
    "ttf-liberation-mono-nerd"    
    "ttf-lilex-nerd"  
    "ttf-meslo-nerd"  
    "ttf-monofur-nerd"    
    "ttf-monoid-nerd"     
    "ttf-mononoki-nerd"   
    "ttf-mplus-nerd"  
    "ttf-nerd"-fonts-symbols  
    "ttf-nerd"-fonts-symbols-mono     
    "ttf-noto-nerd"   
    "ttf-profont-nerd"    
    "ttf-proggyclean-nerd"    
    "ttf-roboto-mono-nerd"    
    "ttf-sharetech-mono-nerd"     
    "ttf-sourcecodepro-nerd"  
    "ttf-space-mono-nerd"     
    "ttf-terminus-nerd"   
    "ttf-tinos-nerd"  
    "ttf-ubuntu-mono-nerd"    
    "ttf-ubuntu-nerd"     
    "ttf-victor-mono-nerd"    



    # Web Browsers
    "firefox" #Firefox
    "chromium" #Chromium


    # terminal
    "tmux" # Tmux
    "foot" # Foot Terminal
    "wezterm" # Wezterm Terminal

    # Shell
    "zsh" # ZSH 
    "ohmy-zsh" # Oh My ZSH
    "powerlevel10k" # Power Level 10k

    # CLI
    "eza" # LS replacement
    "lf" # CLI File Browser
    "lazygit" # CLI Git Client
 
    # Code
    "neovim" # Neo Vim


    # Visual UX
    "hyprland" # Window Manager
    "nemo" # File Browser
    "wofi" # Launcher
    "waybar" # Status bars
    "dunst" # notifications
    "swaylock" # Lock Screen
    "xautolock" # Lock after x mins
    "swayidle" # Idle Actions
    "lightdm-slick-greeter" # Greeter


    # Extras
    "xdg-desktop-portal-hyprland" #Screensharing
    "grim" # Screenshots
    "slurp" # Screenshot area selection


);

packagesYay=(
    "brave-bin" 
    "pfetch" 
    "bibata-cursor-theme" 
    "trizen"


    "swww" 
    "swaylock-effects" 
    "wlogout"
);
  
# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";

# ------------------------------------------------------
# Install pywal
# ------------------------------------------------------
if [ -f /usr/bin/wal ]; then
    echo "pywal already installed."
else
    yay --noconfirm -S pywal
fi

clear

# ------------------------------------------------------
# Install .zshrc
# ------------------------------------------------------
echo ""
echo "-> Install .zshrc"

_installSymLink .zshrc ~/.zshrc ~/dotfiles/.zshrc ~/.zshrc

# ------------------------------------------------------
# Install custom issue (login prompt)
# ------------------------------------------------------
echo ""
echo "-> Install login screen"
while true; do
    read -p "Do you want to install the custom login promt? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            sudo cp ~/dotfiles/login/issue /etc/issue
            echo "Login promt installed."
        break;;
        [Nn]* ) 
            echo "Custom login promt skipped."
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------
echo ""
echo "-> Install wallapers"
while true; do
    read -p "Do you want to clone the wallpapers? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            if [ -d ~/wallpaper/ ]; then
                echo "wallpaper folder already exists."
            else
                git clone https://gitlab.com/stephan-raabe/wallpaper.git ~/wallpaper
                echo "wallpaper installed."
            fi
            echo "Wallpaper installed."
        break;;
        [Nn]* ) 
            if [ -d ~/wallpaper/ ]; then
                echo "wallpaper folder already exists."
            else
                mkdir ~/wallpaper
            fi
            cp ~/dotfiles/wallpapers/* ~/wallpaper
            echo "Default wallpaper installed."
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# ------------------------------------------------------
# Init pywal
# ------------------------------------------------------
echo ""
echo "-> Init pywal"
wal -i ~/dotfiles/wallpapers/default.jpg
echo "pywal initiated."

# ------------------------------------------------------
# Create .config folder
# ------------------------------------------------------
echo ""
echo "-> Check if .config folder exists"

if [ -d ~/.config ]; then
    echo ".config folder already exists."
else
    mkdir ~/.config
    echo ".config folder created."
fi

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
echo ""
echo "-> Install dotfiles"
echo ""


_installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
_installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
_installSymLink wofi ~/.config/wofi ~/dotfiles/wofi/ ~/.config
_installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
_installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config
_installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config

_installSymLink wezterm ~/.config/wezterm ~/dotfiles/wezterm/ ~/.config
_installSymLink lf ~/.config/lf ~/dotfiles/lf/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/nvim/ ~/.

# _installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
wal -i screenshots/
echo "Pywal templates initiated!"
-------------------------------------"
echo ""


# ------------------------------------------------------
# DONE
# ------------------------------------------------------
clear
echo "DONE! Please reboot your system!"