#!/bin/sh

set -eu

DOTDIR=$HOME/dotfiles
PECODIR=$HOME/.peco

make_dotfile_ln() {
    if [ -e ${HOME}/.$1 ]; then
        echo "Already exist ${HOME}/.$1 as symbolic link."
    else
        ln -s ${DOTDIR}/$1 ${HOME}/.$1
        echo "\033[32mexec ln -s ${DOTDIR}/$1 ${HOME}/.${1}\033[m"
    fi
}

make_ln() {
  BASE_PATH=$DOTDIR/$1
  TARGET_PATH=$2/$1

  if [ ! -e $TARGET_PATH ]; then
    ln -s $BASE_PATH $TARGET_PATH
    echo "create symlink to $TARGET_PATH"
  fi
}

check_and_mkdir() {
  if [ -e $1 ]; then
    echo "Already exists and not mkdir $1"
    return 1
  else
    mkdir -p $1
    return 0
  fi
}

setup_vim() {
  make_dotfile_ln vimrc

  VIM_DIR=$HOME/.vim
  DEIN_CONFIG_DIR=$VIM_DIR/dein/config

  check_and_mkdir $DEIN_CONFIG_DIR

  make_ln dein.toml $DEIN_CONFIG_DIR
  make_ln dein_lazy.toml $DEIN_CONFIG_DIR
}

setup_vim

make_dotfile_ln zprofile
make_dotfile_ln zshenv
make_dotfile_ln zshrc
make_dotfile_ln zshrc.Darwin
make_dotfile_ln zshrc.Linux
make_dotfile_ln zshrc.alias
make_dotfile_ln zshrc.command
make_dotfile_ln tmux.conf
make_dotfile_ln gitconfig
make_dotfile_ln gitignore
make_dotfile_ln my.cnf


# for peco setting file
if [ ! -e ${PECODIR} ]; then
    mkdir $PECODIR
    ln -s ${DOTDIR}/peco_config.json ${PECODIR}/config.json
    echo "\033[32mexec ln -s ${DOTDIR}/peco_config.json ${PECODIR}/.${1}\033[m"
fi
