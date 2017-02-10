# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true


if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    # The PS1 was changed to show in prompt git branch name in user or root
    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[0;37m\]\342\224\214${debian_chroot:+[$debian_chroot]}\342\224\200[$(
            if [[ ${EUID} == 0 ]];
                then echo "\[\033[0;31m\]\h";
                else echo "\[\033[01;32m\]\u@\h";
            fi)\[\033[0;37m\]]\342\224\200[\[\033[01;34m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\225\274\[\033[01;30m\]$(
            __git_ps1 " [%s]") \[\033[01;34m\]\$ \[\033[0m\]'
    else
        PS1='\[\033[0;37m\]\342\224\214${debian_chroot:+[$debian_chroot]}\342\224\200[$(
            if [[ ${EUID} == 0 ]];
                then echo "\[\033[0;31m\]\h";
                else echo "\[\033[01;32m\]\u@\h";
            fi)\[\033[0;37m\]]\342\224\200[\[\033[01;34m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\225\274\[\033[01;30m\]$(
            __git_ps1 " [%s]") \[\033[01;34m\]\$ \[\033[0m\]'
    fi

else
    if [[ ${EUID} == 0 ]] ; then
            # show root@ when we don't have colors
            PS1='\u@\h \W \$ '
    else
            PS1='\u@\h \w \$ '
    fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs


# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
    function command_not_found_handle {
        # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
           /usr/bin/python /usr/lib/command-not-found -- $1
           return $?
        else
           return 127
        fi
    }
fi

genpasswd() {
    local LENGTH=${1}
    local CHARS_SET=${2}
    [ -z "${LENGTH}" ] && LENGTH=12
    [ -z "${CHARS_SET}" ] && CHARS_SET="print"
    tr -cd "[:${CHARS_SET}:]" < /dev/urandom | head -n1 -c${LENGTH} | xargs -0
}

to64() {
    local USER=${1}
    local PASSWORD=${2}
    printf "${USER}:${PASSWORD}" | base64
}

decode64() {
    local BASE64_STR=${1}
    printf "${BASE64_STR}" | base64 -d && echo
}

# to show fortune cookies
cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $(fortune)

# to show date and time in bash history
export HISTTIMEFORMAT="%d/%m/%y %T "
