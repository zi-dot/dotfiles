set fish_greeting "Hello! I am a fish."

set -gx TERM xterm-256color

# theme
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
abbr g git
abbr v nvim
abbr gc "git commit"
abbr gs "git status"
abbr gsw "git switch"
abbr gswms "git switch master"
abbr gswm "git switch main"
abbr gst "git stash"
abbr gomen "git commit --amend"
abbr gpl "git pull"
abbr gps "git push"
abbr master "git fetch && git rebase origin/master"
abbr mcp "pnpm format && git add . && git commit -m 'make code `prettier`' && git push"
abbr "pci" "pnpm clean && pnpm install"
abbr ghpr "gh pr create --assignee zi-dot --draft --fill"

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
end

set -gx DENO_INSTALL $HOME/.deno
set -gx PATH $DENO_INSTALL/bin $PATH

set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH $PNPM_HOME $PATH

# status --is-interactive; and rbenv init - fish | source

# cargo
set -gx PATH $HOME/.cargo/bin $PATH
mise activate fish | source

# Gemini
set -gx GOOGLE_GENAI_USE_VERTEXAI true
set -gx GOOGLE_CLOUD_PROJECT kwit-gemini-api
set -gx GOOGLE_CLOUD_LOCATION us-central1
