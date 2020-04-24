#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

mkdir -p ~/.vim
ln -s "$SCRIPTDIR/init.vim" ~/.vim/vimrc

vim +PlugInstall +qall
