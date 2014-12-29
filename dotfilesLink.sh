#! /bin/sh

DOTDIR=$HOME/dotfiles
VIMDIR=$HOME/.vim
VIMBUNDLEDIR=$VIMDIR/bundle

ln -s $DOTDIR/vimrc $HOME/.vimrc
if ! [ -e $VIMDIR ]; then
    mkdir $VIMDIR
fi

if [ ! -e $VIMBUNDLEDIR ]; then
    mkdir $VIMBUNDLEDIR
    git clone https://github.com/Shougo/neobundle.vim $VIMBUNDLEDIR/neobundle.vim
    $VIMBUNDLEDIR/neobundle.vim/bin/neoinstall
fi

ln -s $DOTDIR/zshrc        $HOME/.zshrc
ln -s $DOTDIR/zshenv       $HOME/.zshenv
ln -s $DOTDIR/zshrc.alias  $HOME/.zshrc.alias
ln -s $DOTDIR/zshrc.peco   $HOME/.zshrc.peco
ln -s $DOTDIR/bashrc       $HOME/.bashrc
ln -s $DOTDIR/bash_profile $HOME/.bash_profile
ln -s $DOTDIR/tmux.conf    $HOME/.tmux.conf
ln -s $DOTDIR/gitconfig    $HOME/.gitconfig
