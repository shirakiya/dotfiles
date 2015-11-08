#!/bin/sh

DOTDIR=$HOME/dotfiles
VIMDIR=$HOME/.vim
VIMBUNDLEDIR=$VIMDIR/bundle
PECODIR=$HOME/.peco

function make_ln() {
    if [ -e ${HOME}/.${1} ]; then
        echo "\033[31mAlready exist ${HOME}/.${1} as symbolic link.\033[m"
    else
        ln -s ${DOTDIR}/${1} ${HOME}/.${1}
        echo "\033[32mexec ln -s ${DOTDIR}/${1} ${HOME}/.${1}\033[m"
    fi
}

make_ln vimrc

if ! [ -e ${VIMDIR} ]; then
    mkdir $VIMDIR
fi

if [ ! -e ${VIMBUNDLEDIR} ]; then
    mkdir ${VIMBUNDLEDIR}
    git clone https://github.com/Shougo/neobundle.vim ${VIMBUNDLEDIR}/neobundle.vim
    ${VIMBUNDLEDIR}/neobundle.vim/bin/neoinstall
fi

make_ln zprofile
make_ln zshenv
make_ln zshrc
make_ln zshrc.MacOS
make_ln zshrc.Linux
make_ln zshrc.alias
make_ln zshrc.peco
make_ln tmux.conf
make_ln gitconfig
make_ln gitignore
make_ln my.cnf


# for peco setting file
if [ ! -e ${PECODIR} ]; then
    mkdir $PECODIR
    ln -s ${DOTDIR}/scripts/peco_config.json ${PECODIR}/config.json
    echo "\033[32mexec ln -s ${DOTDIR}/script/peco_config.json ${PECODIR}/.${1}\033[m"
fi
