# ------------------------------
# Path settings
# cf.) https://github.com/thoughtbot/dotfiles/issues/420
# ------------------------------

if [[ `uname` == 'Darwin' ]]; then
    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # for Intaractive shell
    # http://qiita.com/toshihr/items/0a941fc4f8e9f6932729
    if which brew > /dev/null && brew list | grep readline > /dev/null; then
        export LDFLAGS="-L/usr/local/opt/readline/lib $LDFLAGS"
        export CPPFLAGS="-I/usr/local/opt/readline/include $CPPFLAGS"
    fi

    # for pyenv path
    # https://github.com/yyuu/pyenv#basic-github-checkout
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
        export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include $CFLAGS"
    fi
	if which pyenv-virtualenv-init > /dev/null; then
        eval "$(pyenv virtualenv-init -)"
	fi

    # for Go
    export GOPATH=$HOME/.go
    export PATH=$PATH:$HOME/.go/bin

    # for Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # for plenv
    # https://github.com/tokuhirom/plenv#basic-github-checkout
    if which plenv > /dev/null; then
        eval "$(plenv init -)"
    fi

    # for rbenv
    # https://github.com/sstephenson/rbenv#basic-github-checkout
    if which rbenv > /dev/null; then
        eval "$(rbenv init - --no-rehash)";
    fi

    # for scalaenv
    # https://github.com/mazgi/scalaenv
    export SCALAENV_ROOT=/usr/local/var/scalaenv
    if which scalaenv > /dev/null; then
        eval "$(scalaenv init -)"
    fi

	# for nodebrew
	export PATH=$HOME/.nodebrew/current/bin:$PATH

	# for composer(global required)
	export PATH=$PATH:$HOME/.composer/vendor/bin

	# for direnv
	export EDITOR='vim'
	eval "$(direnv hook zsh)"
fi
