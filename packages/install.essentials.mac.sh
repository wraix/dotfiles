#!/bin/bash

PATHFILE=/etc/paths
HOMEBREW="/opt/homebrew"
HOMEBREW_BIN="$HOMEBREW/bin"
HOMEBREW_SBIN="$HOMEBREW/sbin"
COREUTILS_GNUBIN="/opt/homebrew/opt/coreutils/libexec/gnubin"

# Install Homebrew
if [ ! -d $HOMEBREW ] ; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! grep -q $HOMEBREW_BIN "$PATHFILE" ; then
	echo $HOMEBREW_BIN | sudo tee -a $PATHFILE
fi

if ! grep -q $HOMEBREW_SBIN "$PATHFILE" ; then
	echo $HOMEBREW_SBIN | sudo tee -a $PATHFILE
fi

# Setup env variables for (script runtime only)
eval "$(brew shellenv)"

# Install coreutils (realpath etc)
brew install coreutils
if ! grep -q $COREUTILS_GNUBIN "$PATHFILE" ; then
	echo $COREUTILS_GNUBIN | sudo tee -a $PATHFILE
fi

# Install GPG
brew install gnupg
