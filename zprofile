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

    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # for Go
    export GOPATH=$HOME/.go
    export PATH=$PATH:$HOME/.go/bin

    # for Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # for pyenv path
    # https://github.com/yyuu/pyenv
    if exist_command pyenv; then
        eval "$(pyenv init -)"
    fi
	if exist_command pyenv-virtualenv-init; then
        eval "$(pyenv virtualenv-init -)"
	fi

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
    if exist_command ndenv; then
        export PATH="$HOME/.ndenv/bin:$PATH"
        eval "$(ndenv init -)"
    fi

    # for direnv
    export EDITOR='vim'
    eval "$(direnv hook zsh)"

    # for MySQL5.6 (via Homebrew)
    export PATH=/usr/local/opt/mysql@5.6/bin:$PATH

elif [[ `uname` == 'Linux' ]]; then

    # for rbenv
    if which rbenv > /dev/null; then
        export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims
        eval "$(rbenv init -)"
    fi

fi
