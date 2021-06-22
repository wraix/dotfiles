#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

echo $SCRIPT
echo $SCRIPTDIR

curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGSRegularPowerline.ttf

#sudo pacman -S zsh powerline-fonts

# instasll oh-my-zsh
OMZ_DIR=~/.oh-my-zsh
if [ ! -d $OMZ_DIR ]; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# install theme
if [ ! -d $OMZ_DIR/custom/themes/powerlevel10k ]; then
  git clone https://github.com/romkatv/powerlevel10k.git $OMZ_DIR/custom/themes/powerlevel10k
else
  git -C $OMZ_DIR/custom/themes/powerlevel10k pull
fi

ln -i -v -s "$SCRIPTDIR/zshrc" ~/.zshrc
ln -i -v -s "$SCRIPTDIR/p10k.zsh" ~/.p10k.zsh

# Mac Only FIXME
osascript -e 'tell application "Terminal"
    set ProfilesNames to name of every settings set
    repeat with ProfileName in ProfilesNames
        set font name of settings set ProfileName to "MesloLGS-NF-Regular"
        set font size of settings set ProfileName to 11
    end repeat
end tell
'

chsh -s $(which zsh)
