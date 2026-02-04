#!/bin/sh

# npm, cargo, fisher, and other tools installation

npm install -g typescript typescript-language-server import-js
npm install -g prettier

pip3 install --user pynvim

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

curl -fsSL https://get.pnpm.io/install.sh | sh -

cargo install stylua

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish -c "fisher install ilancosman/tide"
fish -c "fisher install jethrokuan/z"
fish -c "fisher install jethrokuan/fzf"
