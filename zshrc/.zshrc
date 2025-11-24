
#NOTE: fastfetch

#  to run fastfetch only on first opned terminal or tab

LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
if [ $LIVE_COUNTER -eq 2 ]; then
	fastfetch
fi
echo Hello user 󱠢 | lolcat

#NOTE:  powerlevel10k instant

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi





if command -v tmux &> /dev/null; then
    if [ -z "$TMUX" ]; then
        tmux attach-session -t default || tmux new-session -s default
    fi
fi
#NOTE: ZINIT

# look if XDG_DATA_HOME exists else look .local/share for the zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k # passing depth=1 to next cmd using zinit ice & light is a cmd use to load p10k lightly

#NOTE: P10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#NOTE: bindkey

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q

#bindkey '^M' autosuggest-accept
bindkey -v

#bindkey -M viins '^M' autosuggest-accept

bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward
#bindkey '^I' autosuggest-accept


# Use Ctrl+Space for fzf-tab completion
bindkey '^ ' fzf-tab-complete

#NOTE: history

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#NOTE: zstyle

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' #case insenstice
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored completions
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(fzf --zsh)"

#NOTE: fd
#

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


#NOTE: alias

alias ll='ls -l --color'
alias la='ls -a --color'
alias ls='ls --color'
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias rmdir="rmdir -v"
alias rm='~/.move-to-dust-bin.sh'
alias g++='g++-13'
alias python=python3
alias pip=pip3
alias vim="nvim"
alias oo='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/ML'
alias cat="bat"
alias conda="mamba"
alias cd="z"
#NOTE: >>> conda initialize >>>

# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
# # . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"  # commented out by conda initialize
#     else
# # export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"  # commented out by conda initialize
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


#NOTE: >>> mamba initialize >>>

# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/homebrew/bin/mamba';
export MAMBA_ROOT_PREFIX='/opt/homebrew/Caskroom/miniforge/base';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<


#NOTE: export
# export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
export PATH="$HOME:/TinyTeX/bin/universal-darwin:$PATH"
export NNN_PLUG='p:preview-tui;f:finder;d:fzcd;'
export HOMEBREW_NO_AUTO_UPDATE=1

source ~/.zsh-defer/zsh-defer.plugin.zsh

cat /Users/arnav/.config/fastfetch/macos.txt| lolcat --force > /Users/arnav/.config/fastfetch/macos_logo.txt 

#zinit ice wait lucid atinit'Fpath+=~/.zsh/conda-zsh-completion' atload'compinit'
#zinit light ~/.zsh/conda-zsh-completion

# ZVM_CURSOR_STYLE_ENABLED=false
export EDITOR="nvim"
export VI_MODE_SET_CURSOR=true
eval "$(zoxide init zsh)"

