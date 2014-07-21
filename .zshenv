# for plenv path
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# for rbenv path
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for PHP55 path
export PATH="/usr/local/bin:$PATH"

# for php-fpm
export PATH="/usr/local/sbin:$PATH"
