export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/local/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/firefox

# setup keyring
if ! pgrep -x ssh-agent -u $(id -u) >/dev/null; then
  # This sets SSH_AUTH_SOCK and SSH_AGENT_PID variables
  eval "$(ssh-agent -s)"
  export SSH_AUTH_SOCK SSH_AGENT_PID
  cat <<EOT > $XDG_RUNTIME_DIR/ssh-agent-env
export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
export SSH_AGENT_PID=$SSH_AGENT_PID
EOT
else
  if [ -s "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
    . $XDG_RUNTIME_DIR/ssh-agent-env
  fi
fi

#eval `keychain --agents ssh --eval id_rsa prv_rsa`
#export `gnome-keyring-daemon -s -d -c ssh`

# Foreground colors, Normal (non-bold) is the default, so the 0; prefix is optional.
FG_DARKGRAY="\[0;30m"
FG_BOLD_DARKGRAY="\[1;30m"
FG_RED="\[0;31m"
FG_BOLD_RED="\[1;31m"
FG_GREEN="\[0;32m"
FG_BOLD_GREEN="\[1;32m"
FG_YELLOW="\[0;33m"
FG_BOLD_YELLOW="\[1;33m"
FG_BLUE="\[0;34m"
FG_BOLD_BLUE="\[1;34m"
FG_PURPLE="\[0;35m"
FG_BOLD_PURPLE="\[1;35m"
FG_TURQUOISE="\[0;36m"
FG_BOLD_TURQUOISE="\[1;36m"
FG_LIGHTGRAY="\[0;37m"
FG_BOLD_LIGHTGRAY="\[1;37m"

# Background colors
BG_DARKGRAY="\[40m"
BG_RED="\[41m"
BG_GREEN="\[42m"
BG_YELLOW="\[43m"
BG_BLUE="\[44m"
BG_PURPLE="\[45m"
BG_TURQUOISE="\[46m"
BG_LIGHTGRAY="\[47m"

# end color
EC="\]";

# Reset color
RC="\[\[0m\]"

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

#parse_git_branch() {
     #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#}
# export PS1="$FG_BOLD_BLUE\u@\h$EC $FG_BOLD_YELLOW\w$EC$FG_BOLD_RED\$(parse_git_branch)$EC$RC \$ "
