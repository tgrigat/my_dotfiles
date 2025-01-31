if status is-interactive
    # Commands to run in interactive sessions can go here
    if command -v zoxide >/dev/null
        zoxide init fish | source
    end
end
