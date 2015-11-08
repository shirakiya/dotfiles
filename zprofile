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
