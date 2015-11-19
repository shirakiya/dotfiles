if [[ `uname` == 'Darwin' ]]; then
    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

    # for pyenv path
    # https://github.com/yyuu/pyenv#basic-github-checkout
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    # for Go
    export GOPATH=$HOME/.go
    export PATH=$PATH:$HOME/.go/bin

    # for Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # for plenv path
    # https://github.com/tokuhirom/plenv#basic-github-checkout
    if which plenv > /dev/null; then
        eval "$(plenv init -)"
    fi

    # for rbenv path
    # https://github.com/sstephenson/rbenv#basic-github-checkout
    if which rbenv > /dev/null; then
        eval "$(rbenv init - --no-rehash)";
    fi
fi

# for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
