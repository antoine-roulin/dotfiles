set PATH ~/anaconda3/bin $PATH
set PATH ~/.cargo/bin $PATH

function ll
	ls --human-readable -l $argv
end

function scala
	scala -Dscala.color $argv
end

