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

readable-path() {
    echo $PATH | tr ':' '\n'
}

pip-upgrade-all() {
    pip list --outdated | awk '{print $1}' | xargs pip install -U
}
alias pipupall=pip-upgrade-all


# 権限をディレクトリは755, ファイルは644に変更する
chmod_basic() {
    find $1 -type d -exec chmod 755 {} +
    find $1 -type f -exec chmod 644 {} +
}


datetime_to_unixtime() {
    case "${OSTYPE}" in
    darwin*)
        date -j -f "%Y-%m-%d %H:%M:%S" "${1}" "+%s"
        ;;
    esac
}


unixtime_to_datetime() {
    case "${OSTYPE}" in
    darwin*)
        date -r $1 +"%Y-%m-%d %H:%M:%S"
        ;;
    *)
        date --date "@${1}"
        ;;
    esac
}


# ------------------------------
# peco command settings
# ------------------------------

if exist_command peco; then

	# ブランチ選択
	peco-branch () {
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
	peco-src () {
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
	peco-history() {
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
	peco-path() {
	    local filepath="$(find . | grep -vE '/[_\.]pyc|venv|node_modules|vendor\/bundle' | peco --prompt 'PATH>')"
	    [ -z "$filepath" ] && return

	    if [ -d "$filepath" ]; then
	      BUFFER="cd $filepath"
	    elif [ -f "$filepath" ]; then
	      BUFFER="$EDITOR $filepath"
	    fi
	    CURSOR=$#BUFFER
	}
	zle -N peco-path
	bindkey '^f' peco-path


	# SSHのホスト名選択
	peco-ssh() {
	    local SSH=$(grep "^\s*Host " ~/.ssh/config | sed s/"[\s ]*Host "// | grep -v "^\*$" | sort | peco --prompt "SSH>")
	    [ -z "$SSH" ] && return
        if [ -n "$1" ];  then
            ssh  $1@$SSH
	    else
	        ssh $SSH
	    fi
	}
	alias ss="peco-ssh"
fi


# ------------------------------
# pet command settings
# ------------------------------

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
