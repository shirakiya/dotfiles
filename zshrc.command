# ------------------------------
# Optional command settings
# ------------------------------

# show cpan module version
pmver () {
    do_cd=;
    if [ "$1" = '-cd' ]; then
        do_cd=1;
        shift;
    fi;
    module=$1;
    perl -M${module} -e "print \$${module}::VERSION,\"\n\"";
    fullpath=$(
        perldoc -ml ${module} 2>/dev/null
        [ $? -eq  255 ] && perldoc -l ${module}
    );
    echo $fullpath;
    if [ "$do_cd" = '1' ]; then
        \cd $(dirname $fullpath);
    fi
}

showusers() {
    case "${OSTYPE}" in
    darwin*)
        dscl . list /Users
        ;;
    *)
        cat /etc/passwd | sed -e 's/:.*//g'
        ;;
    esac
}

showgroups() {
    case "${OSTYPE}" in
    darwin*)
        dscl . list /Groups
        ;;
    *)
        cat /etc/group | sed -e 's/:.*//g'
        ;;
    esac
}

pip-upgrade-all() {
    pip list --outdated | awk '{print $1}' | xargs pip install -U
}
alias pipupall=pip-upgrade-all


# ------------------------------
# peco command settings
# ------------------------------

if exist_command peco; then

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
	bindkey '^t' peco-src


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

if exist_command pet; then

    # petからコマンド検索
    pet-select() {
        BUFFER=$(pet search --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay
    }
    zle -N pet-select
    bindkey '^s' pet-select
fi
