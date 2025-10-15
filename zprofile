# `$HOME/.zprofile` is read only once by using login shell.

# Initialization for completion due to compdef in the following evals.
autoload -Uz compinit
compinit -C

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
  if exist_command pyenv; then
    export PYENV_ROOT="$HOME/.pyenv"
    if [ -d $PYENV_ROOT/bin ]; then
      export PATH="$PYENV_ROOT/bin:$PATH"
    fi
    eval "$(pyenv init - zsh)"
  fi
  if exist_command pyenv-virtualenv-init; then
    eval "$(pyenv virtualenv-init -)"
  fi

  # for Pipenv
  export PIPENV_VENV_IN_PROJECT=true

  # for plenv
  # if exist_command plenv; then
  #   eval "$(plenv init - zsh)"
  # fi

  # for rbenv
  if exist_command rbenv; then
    eval "$(rbenv init - zsh)"
  fi

  # for ndenv
  if exist_command nodenv; then
    eval "$(nodenv init -)"
  fi

  if exist_command gcloud; then
    export PATH="${HOMEBREW_DIR}/share/google-cloud-sdk/bin:$PATH"
  fi

  if exist_command ngrok; then
    eval "$(ngrok completion)"
  fi

  # for openjdk
  if [[ -d "${HOMEBREW_DIR}/opt/openjdk/bin" ]]; then
    export PATH="${HOMEBREW_DIR}/opt/openjdk/bin:$PATH"
    export CPPFLAGS="-I${HOMEBREW_DIR}/opt/openjdk/include"
  fi

  # for mysql-client
  if [[ -d "${HOMEBREW_DIR}/opt/mysql-client/bin" ]]; then
    export PATH="${HOMEBREW_DIR}/opt/mysql-client/bin:$PATH"
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
