source ./defaults.nu # load default configuration 

let-env config = {
    table_mode: compact
}

source ~/.cache/starship/init.nu
alias la = ls -la
alias ll = ls -l
alias vim = nvim
alias cat = bat

