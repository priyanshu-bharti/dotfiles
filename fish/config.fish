if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

proto activate fish | source

starship init fish | source

fzf --fish | source
