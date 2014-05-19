# for plenv path
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# MacVimの有効化
# Linuxの場合、これらは削除する必要がある
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
fi

# for rbenv path
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
