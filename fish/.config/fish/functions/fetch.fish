function fetch
    set logo (find ~/.config/fastfetch/logo -type f | shuf -n 1)
    fastfetch --logo "$logo"
end
