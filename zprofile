# ------------------------------
# Path settings for MacOSX
# cf.) https://github.com/thoughtbot/dotfiles/issues/420
# ------------------------------

if [[ `uname` == 'Darwin' ]]; then
    # for Homebrew-cask
    # https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md
    export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

    # for pyenv path
    # https://github.com/yyuu/pyenv#basic-github-checkout
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
	if which pyenv-virtualenv-init > /dev/null; then
        eval "$(pyenv virtualenv-init -)"
	fi

    # for Go
    export GOPATH=$HOME/.go
    export PATH=$PATH:$HOME/.go/bin

    # for Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # for plenv
    # https://github.com/tokuhirom/plenv#basic-github-checkout
    if which plenv > /dev/null; then
        eval "$(plenv init -)"
    fi

    # for rbenv
    # https://github.com/sstephenson/rbenv#basic-github-checkout
    if which rbenv > /dev/null; then
        eval "$(rbenv init - --no-rehash)";
    fi

    # for scalaenv
    # https://github.com/mazgi/scalaenv
    export SCALAENV_ROOT=/usr/local/var/scalaenv
    if which scalaenv > /dev/null; then
        eval "$(scalaenv init -)"
    fi

	# for composer(global required)
	export PATH=$PATH:$HOME/.composer/vendor/bin

	# for direnv
	export EDITOR='vim'
	eval "$(direnv hook zsh)"
fi


# ------------------------------
# peco command settings
# ------------------------------

if which peco > /dev/null; then

	# ブランチ選択
	function peco-branch () {
	    local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
	    if [ -n "$branch" ]; then
	      if [ -n "$LBUFFER" ]; then
	        local new_left="${LBUFFER%\ } $branch"
	      else
	        local new_left="$branch"
	      fi
	      BUFFER=${new_left}${RBUFFER}
	      CURSOR=${#new_left}
	    fi
	}
	zle -N peco-branch
	bindkey '^b' peco-branch

	# ghqによるリポジトリ一覧&移動
	function peco-src () {
	    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER" --prompt "GHQ>")
	    if [ -n "$selected_dir" ]; then
	        BUFFER="cd ${selected_dir}"
	        zle accept-line
	    fi
	    zle clear-screen
	}
	zle -N peco-src
	bindkey '^s' peco-src


	# 履歴のインクリメンタルサーチ
	function peco-history() {
	    local tac
	    type tac &> /dev/null \
	        && tac="tac" \
	        || tac="tail -r"
	    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER" --prompt "HISTORY>")
	    CURSOR=$#BUFFER
	}
	zle -N peco-history
	bindkey '^r' peco-history


	# ファイル選択
	function peco-path() {
	    local filepath="$(find . | grep -v '/\.' | peco --prompt 'PATH>')"
	    [ -z "$filepath" ] && return
	    if [ -n "$LBUFFER" ]; then
	        BUFFER="$LBUFFER$filepath"
	    else
	        if [ -d "$filepath" ]; then
	          BUFFER="cd $filepath"
	        elif [ -f "$filepath" ]; then
	          BUFFER="$EDITOR $filepath"
	        fi
	    fi
	    CURSOR=$#BUFFER
	}
	zle -N peco-path
	bindkey '^f' peco-path


	# SSHのホスト名選択
	function peco-ssh() {
	    local SSH=$(grep "^\s*Host " ~/.ssh/config | sed s/"[\s ]*Host "// | grep -v "^\*$" | sort | peco --prompt "SSH>")
	    [ -z "$SSH" ] && return
	    if [ "$1" = "root" ]; then
	        ssh 'root@'$SSH
	    else
	        ssh $SSH
	    fi
	}
	alias ss="peco-ssh"
	alias ssr="peco-ssh root"


	# プロセス一覧を表示
	function peco-ps() {
	    \ps $@ | peco --prompt 'PROCESS>'
	}
	alias psp=peco-ps
fi
