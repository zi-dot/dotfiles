#!/bin/sh

# Dotfiles setup script
# Usage: ./setup.sh [options]
#   --all           Run all scripts (default)
#   --packages      Install Homebrew packages only
#   --tools         Install npm, cargo, fisher tools only
#   --symlinks      Create symbolic links only
#   --git           Configure git only

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

run_script() {
    local script="$1"
    echo "Running $script..."
    sh "$SCRIPT_DIR/scripts/$script"
}

case "${1:-all}" in
    --all|all)
        run_script "install-packages.sh"
        run_script "install-tools.sh"
        run_script "create-symlinks.sh"
        run_script "configure-git.sh"
        ;;
    --packages)
        run_script "install-packages.sh"
        ;;
    --tools)
        run_script "install-tools.sh"
        ;;
    --symlinks)
        run_script "create-symlinks.sh"
        ;;
    --git)
        run_script "configure-git.sh"
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: ./setup.sh [--all|--packages|--tools|--symlinks|--git]"
        exit 1
        ;;
esac

echo "Setup completed!"
