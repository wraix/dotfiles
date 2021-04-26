#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

# install zsh and fonts
sudo pacman -S zsh powerline-fonts

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

chsh -s $(which zsh)
