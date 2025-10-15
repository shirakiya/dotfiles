# `$HOME/.zshenv` is read for all invocations of the shell at first.

exist_command() {
    if command -v $1 > /dev/null; then
        return 0
    else
        return 1
    fi
}

if exist_command gh; then
    if gh auth status 1>/dev/null 2>&1; then
        export GITHUB_TOKEN=$(gh auth token)
    fi
fi
