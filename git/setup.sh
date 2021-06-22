#!/bin/bash

# profile
NAME="Lasse Nielsen"
EMAIL="charmixer@users.noreply.github.com"
GNAME=$(git config --global user.name)
GEMAIL=$(git config --global user.email)
GSIGNING_KEY=$(git config --global user.signingkey)
GAUTO_SIGN_COMMIT=$(git config --global commit.gpgSign)
GAUTO_SIGN_TAG=$(git config --global tag.gpgSign)

if [ -z "$GNAME" ]; then
  echo "Global user.name not set, using $NAME"
  git config --global user.name "$NAME"
else
  echo "Global name already set to $GNAME, skipping"
fi

if [ -z "$GEMAIL" ]; then
  echo "Global user.email not set, using $EMAIL"
  git config --global user.email "$EMAIL"
else
  echo "Global email already set to $GEMAIL, skipping"
fi

# alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.tree "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an> %Creset' --abbrev-commit"

# git unstage fileA
# git reset HEAD -- fileA
git config --global alias.unstage 'reset HEAD --'

git config --global pull.rebase false

# omit --set-upstream origin branch with this - allows for git push -u instead
git config --global push.default current

# enable global ignore file for all projects
git config --global core.excludesfile ~/.config/git/ignore

# GPG signing
if [ -z "$GSIGNING_KEY" ]; then
  echo "Global user.signingkey not set"
  read -p "Set signingkey (empty for skip): " SIGNING_KEY
  if [ ! -z "$SIGNING_KEY" ]; then
    git config --global user.signingkey $SIGNING_KEY
    echo "user.signingkey set to $SIGNING_KEY"
    GSIGNING_KEY=$SIGNING_KEY
  else
    echo "Skipping user.signingkey"
  fi
else
  echo "Global signingkey already set to $GSIGNING_KEY, skipping"
fi

# Auto sign commits
if [[ ! -z "$GSIGNING_KEY" ]]; then
  if [[ -z "$GAUTO_SIGN_COMMIT" || "$GAUTO_SIGN_COMMIT" == "false" ]]; then
    echo "Global commit.gpgSign not set or set to false"
    read -p "Should git auto sign commits with gpg key? (y/n): " AUTO_SIGN_COMMIT
    if [ "$AUTO_SIGN_COMMIT" == "y" ]; then
      git config --global commit.gpgSign true
      echo "commit.gpgSign set to true"
    else
      git config --global commit.gpgSign false
      echo "commit.gpgSign set to false"
    fi
  else
    echo "Global commit.gpgSign already set to $GAUTO_SIGN_COMMIT, skipping"
  fi
fi

# Auto sign tags
if [[ ! -z "$GSIGNING_KEY" ]]; then
  if [[ -z "$GAUTO_SIGN_TAG" || "$GAUTO_SIGN_TAG" == "false" ]]; then
    echo "Global tag.gpgSign not set or set to false"
    read -p "Should git auto sign tag with gpg key? (y/n): " AUTO_SIGN_TAG
    if [ "$AUTO_SIGN_TAG" == "y" ]; then
      git config --global tag.gpgSign true
      echo "tag.gpgSign set to true"
    else
      git config --global tag.gpgSign false
      echo "tag.gpgSign set to false"
    fi
  else
    echo "Global tag.gpgSign already set to $GAUTO_SIGN_TAG, skipping"
  fi
fi

mkdir -p ~/.config/git
if [ ! -f ~/.config/git/ignore ]; then
  touch ~/.config/git/ignore
  echo "tags" >> ~/.config/git/ignore
  echo "tags.temp" >> ~/.config/git/ignore
else
  echo "Found ~/.config/git/ignore, leaving it alone"
fi
