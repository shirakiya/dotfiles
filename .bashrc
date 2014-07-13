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
