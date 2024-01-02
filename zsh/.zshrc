source ~/.zsh-plugins/zsh-snap/znap.zsh
export ZSH=$HOME/.oh-my-zsh

path+=(/usr/local/bin)
path+=($HOME/.scripts)
path+=($HOME/.local/share/bob/nvim-bin)
path+=(/usr/local/go/bin)
path+=(/opt/homebrew/bin)
path+=($HOME/.cargo/bin)

fpath+=$HOME/.zsh/pure
if [[ "$OSTYPE" == "darwin"* ]]; then
    fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle :prompt:pure:user color green
# zstyle :prompt:pure:host color green
# zstyle :prompt:pure:path color green
zstyle ':completion:*' list-colors '=*=94'
autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=25000
SAVEHIST=25000
setopt autocd extendedglob
unsetopt beep

# key bindings
bindkey -e
# End of lines configured by zsh-newuser-install

znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance,prompt_info_functions}
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' list-colors '=*=94'

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export path

autoload -U promptinit; promptinit

eval "$(starship init zsh)"

# opam configuration
[[ ! -r /Users/bmoffett/.opam/opam-init/init.zsh ]] || source /Users/bmoffett/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

alias vim="nvim"
alias py="python3.11"
alias pip="python3.11 -m pip"
alias ls="exa"
alias la="ls -la"
alias ll="ls -l"
alias lr="ls -R --git-ignore"
alias cat="bat"

export TERM=alacritty
