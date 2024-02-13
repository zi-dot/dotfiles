set fish_greeting "Hello! I am a fish."

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
abbr ls "ls -p -G"
abbr la "ls -A"
abbr ll "ls -l"
abbr lla "ll -A"
abbr g git
abbr v nvim
abbr gc "git commit"
abbr gs "git status"
abbr gsw "git switch"
abbr gst "git stash"
abbr gomen "git commit --amend"
abbr "git pull" "git pull -p"

command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return

    if test -f .nvmrc; and test -r .nvmrc
        nvm use
    else
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x PATH ~/dotfiles/commands/ $PATH
end

set -gx DENO_INSTALL $HOME/.deno
set -gx PATH $DENO_INSTALL/bin $PATH

set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH $PNPM_HOME $PATH


source /opt/homebrew/opt/asdf/libexec/asdf.fish
# status --is-interactive; and rbenv init - fish | source

# cargo
set -gx PATH $HOME/.cargo/bin $PATH
