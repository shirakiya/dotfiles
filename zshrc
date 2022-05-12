# ------------------------------
# General Settings
# ------------------------------

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ビープ音を無効にする
setopt no_beep

# cdしたら自動的にpushdする
setopt auto_pushd

# cdをつけなくてもディレクトリならcdする
setopt auto_cd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# 重複を記録しない
setopt hist_ignore_dups

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 履歴ファイルに時刻情報を記録
setopt extended_history

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000

# Ctrl+D で強制ログアウトしないようにする
setopt ignoreeof

# もしかして機能
setopt correct

# グロブ展開させない
setopt nonomatch

# ctrl-s による端末ロックを無効化
stty stop undef

# Emacs keybind
bindkey -e

# 重複した環境変数を取り除く
typeset -U path

# 文字の一部と認識する記号
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


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

# zsh-completions
# compinit の実行よりも前に記述する
if [ -e ${HOMEBREW_DIR}/share/zsh-completions ]; then
    fpath=(${HOMEBREW_DIR}/share/zsh-completions $fpath)
fi

# 補完機能を有効にする
autoload -Uz compinit
compinit -C

# 補完候補を一覧で表示する
setopt auto_list

# 補完候補がディレクトリの場合, 末尾に/を追加
setopt auto_param_slash

# カッコの対応も補完
setopt auto_param_keys

# 補完キー連打で補完候補を順に表示する
setopt auto_menu

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
setopt list_types

# 曖昧補完も有効化
setopt rec_exact

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# pip zsh completion start
_pip_completion() {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end


exist_command() {
    if which $1 > /dev/null; then
        return 0
    else
        return 1
    fi
}


# ------------------------------
# Prompt setting
# ------------------------------

# gitのブランチ名
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats "[%b%c%u]"
zstyle ':vcs_info:*' actionformats "[%b%c%u|%a]"

load_current_gcp_config() {
  local config_path="$HOME/.config/gcloud/active_config"
  if [ -f $config_path ]; then
    GCP_PROFILE=$(cat $config_path)
  fi
}

precmd() {
    psvar=()

    LANG=en_U.UTF-8 vcs_info
    psvar[1]="$vcs_info_msg_0_"

    load_current_gcp_config
    psvar[2]=$GCP_PROFILE
}

local p_info="%F{green}[%n@%m${WINDOW:+"($WINDOW)"}]%f"
local p_cdir="%B%F{yellow}(%~)%f%b"
local p_git="%1v"
local p_gcp="[gcp:%2v]"
local p_mark="%(?,%F{green},%F{red})%(!,#,$)%f"

PROMPT="$p_info $p_cdir $p_git$p_gcp
$p_mark "
RPROMPT=""
SPROMPT="'%r' is correct? ([n]o, [y]es, [a]bort, [e]dit):"


# ------------------------------
# compile zsh setting files
# ------------------------------

if [[ ! -f ${HOME}/.zprofile.zwc || ${HOME}/.zprofile -nt ${HOME}/.zprofile.zwc ]]; then
   zcompile ~/.zprofile
fi
if [[ ! -f ${HOME}/.zshenv.zwc || ${HOME}/.zshenv -nt ${HOME}/.zshenv.zwc ]]; then
   zcompile ~/.zshenv
fi
if [[ ! -f ${HOME}/.zshrc.zwc || ${HOME}/.zshrc -nt ${HOME}/.zshrc.zwc ]]; then
   zcompile ~/.zshrc
fi


# ------------------------------
# read External file
# ------------------------------

# zsh関連ファイルの読み込み
[[ -f ~/.zshrc.alias ]] && source ~/.zshrc.alias
[[ -f ~/.zshrc.command ]] && source ~/.zshrc.command
[[ -f ~/.zshrc.`uname` ]] && source ~/.zshrc.`uname`


# ------------------------------
# iTerm2
# ------------------------------
if [[ -f ${HOME}/.iterm2_shell_integration.zsh ]]; then
    source ${HOME}/.iterm2_shell_integration.zsh
fi

# ------------------------------
# pyenv
# ------------------------------
if exist_command pyenv; then
    eval "$(pyenv init -)"
fi
