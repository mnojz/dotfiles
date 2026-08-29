### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -Uz compinit && compinit
### End of Zinit's installer chunk

## starship theme added 
eval "$(starship init zsh)"

## zoxide 
eval "$(zoxide init zsh --cmd cd)"

## keybinds
bindkey -v

## history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

## completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

## Aliases
alias ls='eza'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tree='eza --tree'

alias i='yay -Sy'
alias iy='yay -Sy --noconfirm'
alias s='yay -Ss'
alias r='yay -Rns'
alias u='yay -Syu --noconfirm'
alias gc='git clone --depth 1'

alias open='xdg-open'
alias fetch='fastfetch --logo "$(find ~/.config/fastfetch/logo -type f | shuf -n 1)"'
alias matrix='unimatrix'

if [[ -o interactive ]]; then
    fetch
fi

## custom functions
palette() {
    local e="\e["
    local r="${e}0m"
    local c0="${e}1;30m"
    local c1="${e}1;31m"
    local c2="${e}1;32m"
    local c3="${e}1;33m"
    local c4="${e}1;34m"
    local c5="${e}1;35m"
    local c6="${e}1;36m"
    local c7="${e}1;37m"

    echo ""
    echo " ${c6}     ) )${r}"
    echo " ${c6}     ( (${r}"
    echo " ${c7}    ╭───╮${r}"
    echo " ${c7}    │ ${c0}▄${c7} │─╮${r}"
    echo " ${c7}    ╰───╯─╯${r}"
    echo ""
    echo " ${c1}██ ${c2}██ ${c3}██ ${c4}██ ${c5}██${r}"
    echo ""
}