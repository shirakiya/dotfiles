# ------------------------------
# Path settings
# cf.) https://github.com/thoughtbot/dotfiles/issues/420
# ------------------------------

exist_command() {
    if which $1 > /dev/null; then
        return 0
    else
        return 1
    fi
}

if [[ `uname` == 'Darwin' ]]; then
    export EDITOR='vim'

    if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
    fi
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH

    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # for Go
    export GOPATH=$HOME/ghq
    export PATH=$HOME/ghq/bin:$PATH

    # for Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # for pyenv path
    # https://github.com/yyuu/pyenv
    if exist_command pyenv; then
        eval "$(pyenv init --path)"
    fi
    if exist_command pyenv-virtualenv-init; then
        eval "$(pyenv virtualenv-init -)"
    fi

    # for Pipenv
    export PIPENV_VENV_IN_PROJECT=true

    # for plenv
    # https://github.com/tokuhirom/plenv#basic-github-checkout
    if exist_command plenv; then
        eval "$(plenv init -)"
    fi

    # for rbenv
    # https://github.com/sstephenson/rbenv#basic-github-checkout
    if exist_command rbenv; then
        eval "$(rbenv init - --no-rehash)";
    fi

    # for ndenv
    if exist_command nodenv; then
        eval "$(nodenv init -)"
    fi

    if exist_command gcloud; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    fi

    # for openssl (via Homebrew)
    if [[ -d "/usr/local/opt/openssl@1.1/bin:$PATH" ]]; then
        export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
    fi

    # for MySQL5.6 (via Homebrew)
    if [[ -d "/usr/local/opt/mysql@5.6/bin" ]]; then
        export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
    fi

    # for sqlite3
    if [[ -d "/usr/local/opt/sqlite/bin" ]]; then
        export PATH="/usr/local/opt/sqlite/bin:$PATH"
    fi

    if [ -d ~/flutter/bin ]; then
        export PATH="$HOME/flutter/bin:$PATH"
        export PATH="$HOME/flutter/bin/cache/dart-sdk/bin:$PATH"
        export PATH="$HOME/flutter/.pub-cache/bin:$PATH"
    fi

elif [[ `uname` == 'Linux' ]]; then

    # for rbenv
    if which rbenv > /dev/null; then
        export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims
        eval "$(rbenv init -)"
    fi

fi
