# ------------------------------
# Alias Settings
# ------------------------------

# for unix
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -al"
alias pag="ps aux | grep"

# for vim 
alias v="vim"
alias vi="vim"

# for tmux
alias tm="tmux"
alias tmx="tmuxx"
alias tmls="tmux ls"
alias tmrn="tmux rename -t"
alias tma="tmux a -t"
alias tmkss="tmux kill-session -t"
alias tmksv="tmux kill-server"

# for git
alias g="git"
alias gst="git status"
alias gsh="git show"
alias gad="git add ."
alias gcm="git commit"
alias gps="git push"
alias gdf="git diff"
alias gsta="git stash"
alias gsts="git stash save"
alias gstp="git stash pop"
alias gstl="git stash list"
alias gbr="git branch"
alias gco="git checkout"
alias gft="git fetch"
alias grb="git rebase"
alias glg="git log"
alias ggr="git grep"
alias gmv="git mv"
alias grm="git rm"
alias grs="git reset"
alias gmg="git merge"
alias gcp="git cherry-pick"


# ------------------------------
# General Settings
# ------------------------------

# zsh関連ファイルの読み込み
#[[ -f ~/.zshrc.alias ]] && source ~/.zshrc.alias
#[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ビープ音を無効にする
setopt no_beep

# cdしたら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000



# ------------------------------
# Color settings
# ------------------------------

# 色を使用出来るようにする
autoload -Uz colors
colors

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS

# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true

# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}



# ------------------------------
# complement settings
# ------------------------------

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完候補を一覧で表示する
setopt auto_list

# 補完キー連打で補完候補を順に表示する
setopt auto_menu

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
setopt list_types

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'



# ------------------------------
# Prompt setting
# ------------------------------

# リモート接続時のホスト名
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rhost=`who am i|sed 's/.*\(.*\)).*\1/'`
    rhost=${rhost#localhost:}
    rhost=${rhost%%.*}
    p_rhst="%B%F{magenta}($rhost)%f%b"
fi

# gitのブランチ名
autoload -Uz vcs_info
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}

local p_git="%1v"
local p_cdir="%B%F{yellow}(%~)%f%b"
local p_info="%F{green}[%n@%m${WINDOW:+"($WINDOW)"}]%f"
local p_mark="%(?,%F{green},%F{red})%(!,#,$)%f"

PROMPT="$p_rhst$p_info $p_cdir
$p_mark "
RPROMPT="$p_git"
SPROMPT="'%r' is correct? ([n]o, [y]es, [a]bort, [e]dit):"


# ------------------------------
# Optional package settings
# ------------------------------

# for Homebrew
path=(/usr/local/bin ${path})
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# pmver {{{
pmver ()
{
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
# }}}

# for tmux auto-starting
#if [ -z "$TMUX" -a -z "$STY" ]; then
#    if type tmuxx >/dev/null 2>&1; then
#        tmuxx
#    elif type tmux >/dev/null 2>&1; then
#        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
#            tmux attach && echo "tmux attached session "
#        else
#            tmux new-session && echo "tmux created new session"
#        fi
#    elif type screen >/dev/null 2>&1; then
#        screen -rx || screen -D -RR
#    fi
#fi
