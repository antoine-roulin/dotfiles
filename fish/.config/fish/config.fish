#set JAVA_HOME /usr/lib/jvm/java-1.11.0-openjdk-amd64
set JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
set ANDROID_HOME ~/Android/Sdk

set PATH ~/bin $PATH
set PATH ~/anaconda3/bin $PATH
set PATH ~/.cargo/bin $PATH
set PATH /usr/local/go/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/android-studio/bin $PATH
set PATH $ANDROID_HOME/platform-tools $PATH
set PATH $ANDROID_HOME/tools $PATH
set PATH $ANDROID_HOME/tools/bin $PATH
set PATH ~/android-studio/gradle/gradle-5.1.1/bin $PATH
set PATH /snap/bin $PATH
set PATH ~/flutter/bin $PATH
set PATH $JAVA_HOME/bin $PATH

set LC_CTYPE fr_FR.UTF-8

alias ll="ls --human-readable -l"

alias scala="scala -Dscala.color"

function bibOfDoi --description 'Fetch the BibTeX entry corresponding to a DOI'
    curl -LH 'Accept: application/x-bibtex' $argv
end

# opam configuration
source /home/antoine/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

