if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH /Users/priyanshu/.proto/tools/node/24.9.0/bin $PATH

zoxide init fish | source

proto activate fish | source

starship init fish | source

fzf --fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda3/bin/conda
    eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

set -x JAVA_HOME /opt/homebrew/opt/openjdk@17
set -x PATH $JAVA_HOME/bin $PATH
