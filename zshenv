if [ `uname` = 'Darwin' ]; then
    # for plenv path
    export PATH="$HOME/.plenv/bin:$PATH"
    eval "$(plenv init -)"

    # for rbenv path
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

    # for pyenv path
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    # for Go
    export GOPATH=$HOME/.go
    export PATH=$PATH:$HOME/.go/bin
fi

# for PHP55 path
export PATH="/usr/local/bin:$PATH"

# for php-fpm
export PATH="/usr/local/sbin:$PATH"

# for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
