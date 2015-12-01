#!/bin/sh

# OS はRedhat系であること

# 既にVimをインストールしている場合はreturn
if type vim > /dev/null; then
  echo 'already vim installed'
  exit 0
fi

# コンパイルに必要なパッケージ
sudo yum install -y make gcc
# 基本で必要なパッケージをインストール
sudo yum install -y ncurses-devel gtk2-devel atk-devel libX11-devel libXt-devel
# Lua拡張を使いたい場合
sudo yum install -y lua-devel

cd /usr/local/src
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xf vim-7.4.tar.bz2
cd vim74

# Configure
sudo ./configure \
  --prefix=/usr/local \
  --with-features=huge \
  --disable-selinux \
  --enable-multibyte \
  --enable-xim \
  --enable-fontset \
  --enable-luainterp \
  --enable-luainterp=yes \
  --with-lua-prefix=/usr/local/bin \
  --enable-rubyinterp=yes  \
  --enable-pythoninterp=yes \
  --with-python-config-dir=/usr/lib/python2.6/config  # Pythonのバージョンに注意

# Compile
sudo make
sudo make install

# 終了宣言
echo '---- Vim Compiled!! ---'
