# this will disable greeting message
function fish_greeting
fastfetch
end

starship init fish | source

# Created by `pipx` on 2026-02-07 05:45:33
set PATH $PATH /home/feline/.local/bin

zoxide init --cmd cd fish | source

set -x QT_QPA_PLATFORMTHEME qt5ct

set -x PATH /opt/cuda/bin $PATH
set -x LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

thefuck --alias | source
