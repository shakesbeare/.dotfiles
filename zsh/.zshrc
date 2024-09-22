[[ -r ~/.zsh-plugins/znap/znap.zsh ]] || 
	git clone --depth 1 -- \
		https://github.com/marlonrichert/zsh-snap.git ~/.zsh-plugins/znap
source ~/.zsh-plugins/znap/znap.zsh

path+=(/usr/local/bin)
path+=($HOME/.scripts)
path+=($HOME/.local/share/bob/nvim-bin)
path+=(/usr/local/go/bin)
path+=(/opt/homebrew/bin)
path+=($HOME/.cargo/bin)
path+=($HOME/go/bin)
path+=($HOME/.local/bin)
path+=(/usr/local/texlive/2023/bin/universal-darwin)

for p in ${(z)NIX_PROFILES}; do
  fpath+=($p/share/zsh/site-functions $p/share/zsh/$ZSH_VERSION/functions $p/share/zsh/vendor-completions)
done

mkdir -p $HOME/.zfunc
fpath+=$HOME/.zfunc

# old school brew shit
# if [[ "$OSTYPE" == "darwin"* ]]; then
#     fpath+=("$(brew --prefix)/share/zsh/site-functions")
# fi

HISTFILE=~/.histfile
HISTSIZE=25000
SAVEHIST=25000
setopt autocd
unsetopt beep

# key bindings
bindkey -e
bindkey "^[[A" up-line-or-history
# End of lines configured by zsh-newuser-install

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' list-colors '=*=94'

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
znap prompt

# Configure language tooling
[[ ! -r /Users/bmoffett/.opam/opam-init/init.zsh ]] || source /Users/bmoffett/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
[[ ! -r /Users/bmoffett/.rye/env ]] || source "$HOME/.rye/env" > /dev/null 2> /dev/null
[ -f "/Users/bmoffett/.ghcup/env" ] && . "/Users/bmoffett/.ghcup/env" # ghcup-env

alias l="exa --long --git --tree --level=1 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git|.bare'"
alias ll="exa --long --git --tree --level=2 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git|.bare'"
alias lll="exa --long --git --tree --level=3 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git|.bare'"
alias llll="exa --long --git --tree --level=4 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git|.bare'"
alias lllll="exa --long --git --tree --level=5 --classify --all \
  --group-directories-first --header --group \
  --ignore-glob='node_modules*|dist*|.parcel-cache*|.git|.bare'"
alias la="l"

alias vim="nvim"
alias vi="nvim"
alias python="python3.12"
alias py="python"
alias pip="python -m pip"
alias cat="bat"
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete;"
alias cd="z" # zoxide

eval "$(zoxide init zsh)"

export TERM=alacritty
export DOTNET_ROOT=/usr/local/share/dotnet
export path
