# for plenv path
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# for rbenv path
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
