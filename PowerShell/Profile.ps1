# Path stuff!
$env:PATH += ";C:\Users\berin\AppData\local\bob\nvim-bin\"
$env:PATH += ";F:\Program Files\Visual Studio\2022\MSBuild\Current\Bin"

# Aliases
New-Alias vim nvim
New-Alias vi nvim
New-Alias exa eza # exa is dead :(
New-Alias la l
Set-Alias cat bat
New-Alias which where.exe

# powershell doesn't support aliases with options, so we use functions instead
function l {
    exa --long --git --tree --level=1 --classify --all --group-directories-first --header --group --ignore-glob 'node_modules*|dist*|.parcel-cache*|.git'
}
function ll {
    exa --long --git --tree --level=2 --classify --all --group-directories-first --header --group --ignore-glob 'node_modules*|dist*|.parcel-cache*|.git'
}
function lll {
    exa --long --git --tree --level=3 --classify --all --group-directories-first --header --group --ignore-glob 'node_modules*|dist*|.parcel-cache*|.git'
}
function llll {
    exa --long --git --tree --level=4 --classify --all --group-directories-first --header --group --ignore-glob 'node_modules*|dist*|.parcel-cache*|.git'
}
function lllll {
    exa --long --git --tree --level=5 --classify --all --group-directories-first --header --group --ignore-glob 'node_modules*|dist*|.parcel-cache*|.git'
}

Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)
