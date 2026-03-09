#!/usr/bin/env bash

set -e

ask() {
    read -rp "$1 [y/N]: " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

echo "🚀 Dotfiles Setup for Linux"
echo "============================"
echo ""

# Detect package manager
if command -v apt &> /dev/null; then
    PKG="apt"
    INSTALL="sudo apt install -y"
    sudo apt update
elif command -v dnf &> /dev/null; then
    PKG="dnf"
    INSTALL="sudo dnf install -y"
elif command -v pacman &> /dev/null; then
    PKG="pacman"
    INSTALL="sudo pacman -S --noconfirm"
else
    echo "❌ Unsupported package manager"
    exit 1
fi

echo "Detected package manager: $PKG"
echo ""

# Package list: "display_name:package_name" (use apt name, we'll handle exceptions)
PACKAGES=(
    "stow:stow"
    "zsh:zsh"
    "neovim:neovim"
    "tmux:tmux"
    "fzf:fzf"
    "fd (fast find):fd"
    "zoxide (smart cd):zoxide"
    "bat (better cat):bat"
    "fastfetch:fastfetch"
    "git:git"
)

for pkg in "${PACKAGES[@]}"; do
    name="${pkg%%:*}"
    package="${pkg##*:}"
    
    if ask "Install $name?"; then
        # Handle package name differences
        if [[ "$PKG" == "apt" ]]; then
            [[ "$package" == "fd" ]] && package="fd-find"
        fi
        
        # Special cases
        if [[ "$package" == "fastfetch" && "$PKG" == "apt" ]]; then
            sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
            sudo apt update
        fi
        
        $INSTALL "$package"
        
        # Create symlinks for apt quirks
        if [[ "$PKG" == "apt" ]]; then
            [[ "$package" == "fd-find" ]] && sudo ln -sf "$(which fdfind)" /usr/local/bin/fd 2>/dev/null || true
            [[ "$package" == "bat" ]] && sudo ln -sf "$(which batcat)" /usr/local/bin/bat 2>/dev/null || true
        fi
    fi
done

# Non-package installs
if ask "Install lolcat (requires ruby)?"; then
    command -v gem &> /dev/null || $INSTALL ruby
    sudo gem install lolcat
fi

if ask "Install yazi (requires cargo)?"; then
    if command -v cargo &> /dev/null; then
        cargo install yazi-fm yazi-cli
    else
        echo "⚠️  Install Rust first: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    fi
fi

if ask "Install Miniforge (mamba/conda)?"; then
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh"
    bash "Miniforge3-Linux-$(uname -m).sh" -b -p "$HOME/miniforge3"
    rm "Miniforge3-Linux-$(uname -m).sh"
fi

if ask "Install zsh-defer?"; then
    mkdir -p ~/.zsh-defer
    curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-defer/master/zsh-defer.plugin.zsh -o ~/.zsh-defer/zsh-defer.plugin.zsh
fi

if ask "Change default shell to zsh?"; then
    chsh -s "$(which zsh)"
fi

if ask "Symlink dotfiles with stow?"; then
    cd "$(dirname "$0")"
    stow . --adopt
fi

echo ""
echo "✅ Setup complete! Restart terminal or run: exec zsh"
