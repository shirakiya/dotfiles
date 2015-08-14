#!/bin/sh

# OS  はRedhat系であること
# Git はインストールされているものとする
# TODO: 自動判別し、インストールされていない場合は実行しないようにする

# コンパイルに必要なパッケージ
sudo yum install -y make gcc
# 基本で必要なパッケージをインストール
sudo yum install -y ncurses-devel gtk2-devel atk-devel libX11-devel libXt-devel
# Lua拡張を使いたい場合
sudo yum install -y lua-devel

# Vim のインストール
cd /usr/local/src
sudo hg clone https://vim.googlecode.com/hg/ vim
cd /usr/local/src/vim
sudo hg pull

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
