#!/bin/bash

# profile
git config --global user.name 'Lasse Nielsen'
echo "Remember to run 'git config --global user.email <email>'"

# alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# git unstage fileA
# git reset HEAD -- fileA
git config --global alias.unstage 'reset HEAD --'

# omit --set-upstream origin branch with this - allows for git push -u instead
git config --global push.default current

# enable global ignore file for all projects
git config --global core.excludesfile ~/.config/git/ignore

mkdir -p ~/.config/git
if [ ! -f ~/.config/git/ignore ]; then
  touch ~/.config/git/ignore
  echo "tags" >> ~/.config/git/ignore
  echo "tags.temp" >> ~/.config/git/ignore
else
  echo "Found ~/.config/git/ignore, leaving it alone"
fi
