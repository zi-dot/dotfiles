#!/bin/sh

brew install neovim
brew install tmux
brew uninstall --force node
brew tap homebrew/cask-fonts
brew install --cask homebrew/cask-fonts/font-hackgen
brew install --cask font-hack-nerd-font
brew install --cask slack
brew install starship
npm install -g typescript typescript-language-server import-js

brew install ripgrep

brew install deno
brew install peco jq
brew install --cask 1password
brew tap wez/wezterm; brew install --cask wezterm-nightly --no-quarantine
brew install --cask raycast
brew install --cask docker
brew install --cask visual-studio-code
brew install --cask google-chrome
brew install --cask firefox
brew install --cask google-drive

brew install direnv

brew install asdf

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \                                                                             
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
brew install python3
pip3 install --user pynvim

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

brew install lsd
brew install wget
brew install rust

ln -sf ~/dotfiles/.zprezto/runcoms/zshrc ~/.zshrc
ln -sf ~/dotfiles/.zprezto/runcoms/zshenv ~/.zshenv
ln -sf ~/dotfiles/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/dotfiles/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -sf ~/dotfiles/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/dotfiles/.zprezto/runcoms/zlogin ~/.zlogin

ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.tmux.powerline.conf ~/.tmux.powerline.conf

npm install -g prettier
cargo install stylua

brew install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish -c "fisher install ilancosman/tide"
fish -c "fisher install jethrokuan/z"
fish -c "fisher install jethrokuan/fzf"

ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

ln -sf ~/dotfiles/.config/fish/config-osx.fish ~/.config/fish/config-osx.fish

ln -sf ~/dotfiles/hyper/.hyper.js ~/.hyper.js
ln -sf ~/dotfiles/hyper/package.json ~/.hyper_plugins/package.json

ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

