# `$HOME/.zprofile` is read only once by using login shell.


exist_command() {
    if command -v $1 > /dev/null; then
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

    # for Homebrew
    if [[ -d "/opt/homebrew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    export HOMEBREW_DIR=${HOMEBREW_PREFIX:-"/usr/local"}

    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # for Go
    export GOPATH=$HOME/ghq
    export PATH=$HOME/ghq/bin:$PATH

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
        # The gcloud CLI depends on Python. It recommends Pythoon version as 3.5~3.8.
        # ref.) `$ gcloud topic startup`
        source "$HOMEBREW_DIR/share/google-cloud-sdk/path.zsh.inc"
        source "$HOMEBREW_DIR/share/google-cloud-sdk/completion.zsh.inc"
    fi

    if exist_command ngrok; then
        eval "$(ngrok completion)"
    fi

    if exist_command gh; then
        if gh auth status 1>/dev/null 2>&1; then
            export GITHUB_TOKEN=$(gh auth token)
        fi
    fi

    # for openjdk
    if [[ -d "${HOMEBREW_DIR}/opt/openjdk/bin" ]]; then
        export PATH="${HOMEBREW_DIR}/opt/openjdk/bin:$PATH"
        export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
    fi

    # for mysql-client
    if [[ -d "${HOMEBREW_DIR}/opt/mysql-client/bin" ]]; then
        export PATH="${HOMEBREW_DIR}/opt/mysql-client/bin:$PATH"
    fi

    # for openssl (via Homebrew)
    if [[ -d "${HOMEBREW_DIR}/opt/openssl@1.1/bin" ]]; then
        export PATH="${HOMEBREW_DIR}/opt/openssl@1.1/bin:$PATH"
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
