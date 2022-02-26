#!/bin/sh

brew install neovim
brew install tmux
brew uninstall --force node
brew install nodebrew
nodebrew setup
nodebrew install-binary latest
npm install -g typescript typescript-language-server import-js

brew install ripgrep

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \                                                                             
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
brew install python3
pip3 install --user pynvim

ln -sf ~/dotfiles/.zprezto/runcoms/zshrc ~/.zshrc
ln -sf ~/dotfiles/.zprezto/runcoms/zshenv ~/.zshenv
ln -sf ~/dotfiles/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/dotfiles/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -sf ~/dotfiles/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/dotfiles/.zprezto/runcoms/zlogin ~/.zlogin

ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.tmux.powerline.conf ~/.tmux.powerline.conf

brew install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install ilancosman/tide
fisher install jethrokuan/z
fisher install jethrokuan/fzf

ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

ln -sf ~/dotfiles/.config/fish/config-osx.fish ~/.config/fish/config-osx.fish

ln -sf ~/dotfiles/hyper/.hyper.js ~/.hyper.js
ln -sf ~/dotfiles/hyper/package.json ~/.hyper_plugins/package.json


