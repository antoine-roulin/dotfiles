set PATH ~/bin ~/.local/bin $PATH
set PATH ~/.emacs.d/bin $PATH

set -x PATH "/home/coopengo/.pyenv/bin" $PATH
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

set -x DIRENV_LOG_FORMAT ""
eval (direnv hook fish)

set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --vimgrep'
set FZF_DEFAULT_OPTS '--color fg:-1,bg:-1,hl:33,fg+:235,bg+:254,hl+:33
		      --color info:136,prompt:136,pointer:234,marker:234,spinner:136'
