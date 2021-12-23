#!/bin/bash

set -ev

VERSION=${2:-"v0.6.0"}

# Get nightly release
cd /tmp
curl -LO "https://github.com/neovim/neovim/releases/download/$VERSION/nvim-linux64.tar.gz"
tar xzf nvim-linux64.tar.gz
mkdir -p ~/.local

# Remove
rm -f ~/.local/bin/nvim    || true
rm -rf ~/.local/lib/nvim   || true
rm -rf ~/.local/share/nvim || true

# Install nvim
rsync -a nvim-linux64/* ~/.local/
rm nvim-linux64.tar.gz
rm -r nvim-linux64

# Install plugins
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -E -s -u ~/.config/nvim/init.vim +PlugInstall +qall!
