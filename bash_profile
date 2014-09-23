if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

# for plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# for rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
