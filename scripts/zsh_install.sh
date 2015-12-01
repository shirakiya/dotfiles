#!/bin/sh

#su -

cd /usr/local/src/

yum install -y ncurses-devel
wget http://downloads.sourceforge.net/project/zsh/zsh/5.1.1/zsh-5.1.1.tar.gz
tar zxvf zsh-5.1.1.tar.gz
cd zsh-5.1.1

./configure
make && make install

# cat /etc/shells
# sudo -e /etc/shells
# chsh
