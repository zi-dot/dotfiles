#!/bin/bash

# PreToolUse Hook Script
# This script validates tool usage before execution

# Read JSON input from stdin
input=$(cat)

# Extract tool name and command (for Bash tool)
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# match function: blocks command if pattern matches
# Usage: match "$command" "pattern" "error message"
match() {
    local cmd="$1"
    local pattern="$2"
    local message="$3"

    if [[ "$cmd" == $pattern ]]; then
        echo "{\"error\": \"$message\"}" >&2
        exit 2
    fi
}

# Only check Bash commands
if [[ "$tool_name" == "Bash" ]]; then
    # Git dangerous commands
    match "$command" "git push --force*" "Do not use 'git push --force'. Use 'git push --force-with-lease' instead."
    match "$command" "git push -f *" "Do not use 'git push -f'. Use 'git push --force-with-lease' instead."
    match "$command" "git reset --hard*" "Do not use 'git reset --hard' without explicit user approval."
    match "$command" "git clean -f*" "Do not use 'git clean -f' without explicit user approval."

    # Destructive file operations
    match "$command" "rm -rf /*" "Do not use 'rm -rf /' - this is a destructive operation."
    match "$command" "rm -rf ~*" "Do not use 'rm -rf ~' - this is a destructive operation."

    # Disallow cd command - stay at monorepo root and use pnpm -F or absolute paths
    match "$command" "cd *" "Do not use 'cd'. Stay at the monorepo root and use 'pnpm -F <package>' to run scripts in specific packages, or use absolute paths for other commands."
    match "$command" "cd" "Do not use 'cd'. Stay at the monorepo root and use 'pnpm -F <package>' to run scripts in specific packages."

    # Disallow npx - use npm scripts defined in package.json instead
    match "$command" "npx *" "Do not use 'npx'. Use npm scripts defined in package.json instead (e.g., 'pnpm -F <package> <script>')."
    match "$command" "*| npx *" "Do not use 'npx'. Use npm scripts defined in package.json instead."
    match "$command" "*&& npx *" "Do not use 'npx'. Use npm scripts defined in package.json instead."

    # Production environment protection (examples - customize as needed)
    # match "$command" "*--target*prd*" "Permission denied in 'prd' environment."
    # match "$command" "terraform apply*" "Do not use 'terraform apply' command."
    # match "$command" "terraform destroy*" "Do not use 'terraform destroy' command."
fi

# Allow the tool to proceed
exit 0
