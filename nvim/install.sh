#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

curl -L https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage -o ./nvim.appimage

chmod +x ./nvim.appimage

sudo mv ./nvim.appimage /usr/local/bin/nvim

mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -s "$SCRIPTDIR/init.vim" ~/.config/nvim/

nvim +PlugInstall +qall
