export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/local/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/firefox

# setup keyring
export `gnome-keyring-daemon -s -d -c pkcsll,secrets,ssh`


# Foreground colors, Normal (non-bold) is the default, so the 0; prefix is optional.
FG_DARKGRAY="\e[0;30m"
FG_BOLD_DARKGRAY="\e[1;30m"
FG_RED="\e[0;31m"
FG_BOLD_RED="\e[1;31m"
FG_GREEN="\e[0;32m"
FG_BOLD_GREEN="\e[1;32m"
FG_YELLOW="\e[0;33m"
FG_BOLD_YELLOW="\e[1;33m"
FG_BLUE="\e[0;34m"
FG_BOLD_BLUE="\e[1;34m"
FG_PURPLE="\e[0;35m"
FG_BOLD_PURPLE="\e[1;35m"
FG_TURQUOISE="\e[0;36m"
FG_BOLD_TURQUOISE="\e[1;36m"
FG_LIGHTGRAY="\e[0;37m"
FG_BOLD_LIGHTGRAY="\e[1;37m"

# Background colors
BG_DARKGRAY="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_PURPLE="\e[45m"
BG_TURQUOISE="\e[46m"
BG_LIGHTGRAY="\e[47m"

# end color
EC="\]";

# Reset color
RC="\[\e[0m\]"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="$FG_BOLD_BLUE\u@\h$EC $FG_BOLD_YELLOW\w$EC$FG_BOLD_RED$(parse_git_branch)$EC$RC \$ "
