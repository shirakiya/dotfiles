# `$HOME/.zprofile` is read only once by using login shell.
zmodload zsh/datetime
__zprofile_start=$EPOCHREALTIME

printtime() {
  name=$1
  base_time=$__zprofile_start
  if [[ -n $__zprofile_start ]]; then
    now=$EPOCHREALTIME
    echo "$name: $(($now - $base_time))s"
  fi
}

# path_helper: 0.040494203567504883s
# shellenv: 0.089651107788085938s
# pyenv: 0.49128198623657227s
# plenv: 0.57828903198242188s
# rbenv: 0.67188501358032227s
# nodenv: 0.86107110977172852s
# ngrok: 0.9383690357208252s
# zprofile: 0.93868517875671387s

# Initialization for completion due to compdef in the following evals.
autoload -Uz compinit
compinit -C

if [[ `uname` == 'Darwin' ]]; then
  export EDITOR='vim'

  if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
  fi
  printtime "path_helper"

  # for Homebrew
  if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  printtime "shellenv"

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
  printtime "pyenv"

  # for Pipenv
  export PIPENV_VENV_IN_PROJECT=true

  # for plenv
  if exist_command plenv; then
    eval "$(plenv init - zsh)"
  fi
  printtime "plenv"

  # for rbenv
  # https://github.com/sstephenson/rbenv#basic-github-checkout
  if exist_command rbenv; then
    eval "$(rbenv init - --no-rehash)";
  fi
  printtime "rbenv"

  # for ndenv
  if exist_command nodenv; then
    eval "$(nodenv init -)"
  fi
  printtime "nodenv"

  if exist_command gcloud; then
    export PATH="${HOMEBREW_DIR}/share/google-cloud-sdk/bin:$PATH"
  fi

  if exist_command ngrok; then
    eval "$(ngrok completion)"
  fi
  printtime "ngrok"

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

printtime "zprofile"
