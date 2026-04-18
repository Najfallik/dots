# Keybindings (Zsh)
# Enable emacs-style keybindings (needed for word movement)
bindkey -e

# Word style (affects Ctrl+← / Ctrl+→ behavior)
autoload -U select-word-style
select-word-style bash

# Ctrl+Backspace → delete previous word
bindkey '^H' backward-kill-word

# Ctrl+Delete → delete next word
bindkey '^[[3;5~' kill-word

# Ctrl + Left Arrow → move backward by word
bindkey '^[[1;5D' backward-word

# Ctrl + Right Arrow → move forward by word
bindkey '^[[1;5C' forward-word

# Alt + Backspace (extra compatibility)
bindkey '^[^?' backward-kill-word

# Aliases
# eza (replacement for ls)
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.='eza -a | grep -e "^\."'

# System
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update='sudo pacman -Syu'

# Archive
alias tarnow='tar -acf'
alias untar='tar -zxvf'

# Utils
alias wget='wget -c'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Colorized tools
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Info
alias hw='hwinfo --short'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias ff='fastfetch'

# Convenience
alias q='exit'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Arch helpers
alias apt='man pacman'
alias apt-get='man pacman'

# Cleanup (FIXED for zsh)
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Logs
alias jctl="journalctl -p 3 -xb"

# Recent installs
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
