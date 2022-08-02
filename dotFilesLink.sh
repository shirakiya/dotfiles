#!/bin/bash

set -eu

DOTDIR=$HOME/dotfiles

make_dotfile_ln() {
  BASE_PATH=$DOTDIR/$1
  TARGET_PATH=$HOME/.$1

  if [ ! -e $TARGET_PATH ]; then
    ln -s $BASE_PATH $TARGET_PATH
    echo "create symlink to ${TARGET_PATH}"
  fi
}

make_ln() {
  BASE_PATH=$DOTDIR/$1
  TARGET_PATH=$2

  if [ ! -e $TARGET_PATH ]; then
    ln -s $BASE_PATH $TARGET_PATH
    echo "create symlink to $TARGET_PATH"
  fi
}

check_and_mkdir() {
  if [ ! -e $1 ]; then
    mkdir -p $1
  fi
}

setup_vim() {
  make_dotfile_ln vimrc

  DEIN_CONFIG_DIR=$HOME/.vim/dein/config
  check_and_mkdir $DEIN_CONFIG_DIR
  make_ln dein_vim/dein.toml $DEIN_CONFIG_DIR/dein.toml
  make_ln dein_vim/dein_lazy.toml $DEIN_CONFIG_DIR/dein_lazy.toml
}

setup_neovim() {
  NVIM_DIR=$HOME/.config/nvim
  check_and_mkdir $NVIM_DIR
  make_ln init.vim $NVIM_DIR/init.vim

  DEIN_CONFIG_DIR=$HOME/.config/dein/config
  check_and_mkdir $DEIN_CONFIG_DIR
  make_ln dein_nvim/dein.toml $DEIN_CONFIG_DIR/dein.toml
  make_ln dein_nvim/dein_lazy.toml $DEIN_CONFIG_DIR/dein_lazy.toml
}

setup_peco() {
  PECO_DIR=$HOME/.peco

  check_and_mkdir $PECO_DIR
  make_ln peco_config.json $PECO_DIR/config.json
}

setup_karabiner() {
  KARABINER_DIR=$HOME/.config/karabiner
  COMPLEX_MODIFICATIONS=$HOME/.config/karabiner/assets/complex_modifications

  check_and_mkdir $KARABINER_DIR
  check_and_mkdir $COMPLEX_MODIFICATIONS

  make_ln karabiner/karabiner.json $KARABINER_DIR/karabiner.json
  make_ln karabiner/assets/complex_modifications/1659331752.json $COMPLEX_MODIFICATIONS/1659331752.json
}

make_dotfile_ln zprofile
make_dotfile_ln zshenv
make_dotfile_ln zshrc
make_dotfile_ln zshrc.Darwin
make_dotfile_ln zshrc.Linux
make_dotfile_ln zshrc.alias
make_dotfile_ln zshrc.command
make_dotfile_ln _assumer
make_dotfile_ln tmux.conf
make_dotfile_ln gitconfig
make_dotfile_ln gitignore
make_dotfile_ln my.cnf
make_dotfile_ln isort.cfg

setup_vim
setup_neovim
setup_peco
setup_karabiner
