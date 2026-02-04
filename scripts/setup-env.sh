#!/bin/sh

# zellij-send-keys environment setup
# Source: https://github.com/atani/zellij-send-keys

# Helper function to send text to a specific pane
send-to-pane() {
    local pane_id="$1"
    local text="$2"

    if [ -z "$pane_id" ] || [ -z "$text" ]; then
        echo "Usage: send-to-pane <pane_id> <text>"
        return 1
    fi

    zellij action write-chars --target-pane "$pane_id" "$text"
}

# Export the function for use in subshells
export -f send-to-pane 2>/dev/null || true
