# プロンプト設定
export PS1='\e[0;32m[\u@\h \w]\$\e[0m '


# カラー設定
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad


# エイリアスの設定
alias la='ls -a'
alias ll='ls -la'


# for git
alias gst='git status'
alias gci='git commit'
alias gdi='git diff'
alias gdc='git diff --cached'
alias gad='git add'


# Macvim kaoriya
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'


pmver()
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
