source ~/.zsh-plugins/zsh-snap/znap.zsh
export ZSH=$HOME/.oh-my-zsh

path+=(/usr/local/bin)
path+=($HOME/.scripts)
path+=($HOME/.local/share/bob/nvim-bin)
path+=(/usr/local/go/bin)
path+=(/opt/homebrew/bin)
path+=($HOME/.cargo/bin)
path+=($HOME/go/bin)
path+=($HOME/.local/bin)
path+=(/usr/local/texlive/2023/bin/universal-darwin)

mkdir -p $HOME/.zfunc
fpath+=$HOME/.zfunc

fpath+=$HOME/.zsh/pure
if [[ "$OSTYPE" == "darwin"* ]]; then
    fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors '=*=94'
autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=25000
SAVEHIST=25000
setopt autocd
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

alias l="exa --long --git --tree --level=1 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git'"
alias ll="exa --long --git --tree --level=2 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git'"
alias lll="exa --long --git --tree --level=3 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git'"
alias llll="exa --long --git --tree --level=4 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git'"
alias lllll="exa --long --git --tree --level=5 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git'"
alias la="l"

alias vim="nvim"
alias vi="nvim"
alias python="python3.12"
alias py="python"
alias pip="python -m pip"
alias cat="bat"
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete;"
alias cd="z" # zoxide

export TERM=alacritty
eval "$(zoxide init zsh)"
