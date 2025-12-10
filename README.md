#  my Dotfiles

My personal macOS configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## ✨ What's Included

### Shell
- **Zsh** - Main shell with [Zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- **Powerlevel10k** - Fast, customizable prompt
- **zsh-vi-mode** - Vim keybindings in the terminal
- **fzf** + **fzf-tab** - Fuzzy finding everywhere
- **zoxide** - Smarter `cd` command

### Terminal & Editors
- **Neovim** - Primary editor
- **Ghostty** / **Kitty** - Terminal emulators
- **tmux** - Terminal multiplexer

### Window Management
- **yabai** - Tiling window manager
- **skhd** - Hotkey daemon
- **SketchyBar** - Custom menu bar
- **Borders** - Window borders

### CLI Tools
- **yazi** - Terminal file manager
- **fastfetch** - System info display
- **bat** - Better `cat`
- **fd** - Better `find`

### Other
- **Karabiner** - Keyboard customization

## 🚀 Installation

```bash
# Clone the repo
git clone https://github.com/arnav/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Use GNU Stow to symlink configs
stow .
```



```

## ⚡ Key Features

- **Vi-mode** in shell with blinking cursor indicators
- **Fuzzy completion** for everything with fzf-tab
- **Smart directory jumping** with zoxide (`cd` → `z`)
- **Safe rm** - moves files to trash instead of deleting
- **Mamba/Conda** for Python environment management
- **Fastfetch** greeting on first terminal open

## 📝 License

Feel free to use and modify as you like!
