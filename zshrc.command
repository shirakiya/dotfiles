# ------------------------------
# Optional command settings
# ------------------------------

# show cpan module version
pmver() {
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
        cd $(dirname $fullpath);
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


urlencode() {
    if ! exist_command nkf; then
        echo "Not found nkf command, skipped."
        return
    fi
    echo $1 | nkf -WwMQ | sed 's/=$//g' | tr = %
}


urldecode() {
    if ! exist_command nkf; then
        echo "Not found nkf command, skipped."
        return
    fi
    echo $1 | nkf --url-input
}


# ------------------------------
# peco command settings
# ------------------------------

if exist_command peco; then

    # ブランチ選択
    peco-branch() {
        local branch=$(git branch | peco --prompt "BRANCH>" | tr -d ' ' | tr -d '*' | awk '{print $0}' ORS=' ')
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
    peco-src() {
        local selected_dir=$(ghq list --full-path | sort | peco --query "$LBUFFER" --prompt "GHQ>")
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
        local filepath=$(find . | grep -vE '[_\.]pyc|venv|node_modules|vendor\/bundle|\.git\/' | peco --prompt 'PATH>')
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

    # Docker Imageの選択
    peco-docker-images() {
        local images=$(docker images | tail +2 | sort | peco --prompt 'DOCKER IMAGES>' | awk '{print $3}' ORS=' ')
        [ -z "$images" ] && return
        BUFFER="$LBUFFER$images$RBUFFER"
        CURSOR=$#BUFFER
    }
    zle -N peco-docker-images
    bindkey '^x^i' peco-docker-images

    # Docker Containerの選択
    peco-docker-containers() {
        local containers=$(docker ps -a | tail +2 | sort | peco --prompt 'DOCKER CONTAINERS>' | awk '{print $1}' ORS=' ')
        [ -z "$containers" ] && return
        BUFFER="$LBUFFER$containers$RBUFFER"
        CURSOR=$#BUFFER
    }
    zle -N peco-docker-containers
    bindkey '^x^n' peco-docker-containers

    # Kubernetes
    peco-kubectl-context() {
        local context=$(kubectl config get-contexts | peco --prompt='kubectl context>' --initial-index=1 |  sed -e 's/^\*//' | awk '{print $1}')
        [ -z $context ] && return
        kubectl config use-context $context
    }
    zle -N peco-kubectl-context
    bindkey '^x^k' peco-kubectl-context
    alias kctx="peco-kubectl-context"

    # GCP
    _peco-gcp-config() {
        gcloud config configurations list | awk '{print $1}' | grep -v NAME | peco --prompt='GCP CONFIG>'
    }
    peco-gcp-config() {
        local config=$(_peco-gcp-config)
        [ -z $config ] && return
        BUFFER="$LBUFFER$config$RBUFFER"
        CURSOR=$#BUFFER
    }
    zle -N peco-gcp-config
    bindkey '^x^g' peco-gcp-config

    chgcp() {
        local config=$(_peco-gcp-config)
        [ -z $config ] && return
        gcloud config configurations activate $config
    }

    # AWS
    _peco-aws-profile() {
        aws configure list-profiles | sort | peco --prompt 'AWS PROFILE>'
    }
    peco-aws-profile() {
        local profile=$(_peco-aws-profile)
        [ -z $profile ] && return
        BUFFER="$LBUFFER$profile $RBUFFER"
        CURSOR=$#BUFFER
    }
    zle -N peco-aws-profile
    bindkey '^x^a' peco-aws-profile

    awslogin() {
        local profile=$(_peco-aws-profile)
        [ -z $profile ] && return
        echo "Attempt SSO login to $profile"
        aws sso login --profile $profile
    }
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


# ------------------------------
# gh command settings
# ------------------------------

if exist_command gh; then

    # リポジトリを作成してghq get
    ghcr() {
        if ! exist_command ghq; then
            echo "ghq is not found."
            return 1
        fi
        gh repo create $@ -y
        ghq get git@github.com:shirakiya/${1}.git
    }
fi
