source ~/.zsh-plugins/zsh-snap/znap.zsh
export ZSH=$HOME/.oh-my-zsh

fpath+=$HOME/.zsh/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
path+=($HOME/.scripts)
path+=($HOME/.local/share/bob/nvim-bin)


alias goto="tmux attach -t"
alias tlist="tmux list-sessions"
alias vimrc="cd ~/.config/nvim && nvim . && cd -"
alias vim="nvim"
alias py="python3.11"
alias pip="python3.11 -m pip"
alias ll="ls"
alias la="ls -la"
alias obsidian="cd ~/Dropbox/Documents/0-obsidian-notes/ && nvim . && cd -"

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :prompt:pure:user color green
zstyle :prompt:pure:host color green
zstyle :prompt:pure:path color green
# zstyle ':completion:*' format '"Completing %d"'
zstyle ':completion:*' list-colors '=*=94'
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' max-errors 2
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' original false
#zstyle :compinstall filename '/home/yes/.zshrc'

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
#zstyle :compinstall filename '/home/dwr/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=25000
SAVEHIST=25000
setopt autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

znap source marlonrichert/zsh-autocomplete
znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance,prompt_info_functions}

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    )
autoload -U promptinit; promptinit
prompt pure

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' list-colors '=*=94'

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export path
