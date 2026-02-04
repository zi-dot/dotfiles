#!/bin/sh

# Create symbolic links for dotfiles

# zsh
ln -sf ~/dotfiles/.zprezto/runcoms/zshrc ~/.zshrc
ln -sf ~/dotfiles/.zprezto/runcoms/zshenv ~/.zshenv
ln -sf ~/dotfiles/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/dotfiles/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -sf ~/dotfiles/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/dotfiles/.zprezto/runcoms/zlogin ~/.zlogin

# fish
mkdir -p ~/.config/fish
ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish

# neovim
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# wezterm
mkdir -p ~/.config/wezterm
ln -sf ~/dotfiles/.config/wezterm ~/.config/wezterm

# zellij
mkdir -p ~/.config/zellij/layouts
ln -sf ~/dotfiles/.config/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf ~/dotfiles/.config/zellij/layouts/default.kdl ~/.config/zellij/layouts/default.kdl

# ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config

# claude
mkdir -p ~/.claude
ln -sf ~/dotfiles/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/.config/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.config/claude/statusline.js ~/.claude/statusline.js
ln -sf ~/dotfiles/.config/claude/skills ~/.claude/skills
ln -sf ~/dotfiles/.config/claude/commands ~/.claude/commands
ln -sf ~/dotfiles/.config/claude/hooks ~/.claude/hooks
