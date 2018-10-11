set PATH ~/bin $PATH
set PATH ~/anaconda3/bin $PATH
set PATH ~/.cargo/bin $PATH
set PATH /usr/local/go/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/android-studio/bin $PATH
set PATH ~/Android/Sdk/platform-tools $PATH
set PATH ~/Android/Sdk/tools $PATH
set PATH ~/android-studio/gradle/gradle-4.4/bin $PATH

alias ll="ls --human-readable -l"

alias scala="scala -Dscala.color"

function bibOfDoi --description 'Fetch the BibTeX entry corresponding to a DOI'
    curl -LH 'Accept: application/x-bibtex' $argv
end

