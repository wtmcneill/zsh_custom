# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto -h'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -F'
fi

# Misc Aliases
alias cp='cp -i'
alias chown='chown -h'
alias ll='ls -la' # replaced by shell func
#alias lla='ls -la'
#alias la='ls -A' # replaced by shell func
#alias l='ls -CF'
alias lsa='ls -ls .*' ## list only file beginning with "."
alias lsd='ls -ld *(-/DN)' ## list only dirs
alias du1='du -hs *(/) | sort -h' ## du with depth 1
alias pl='echo $PWD: && ls -CF'
alias pla='echo $PWD: && ls -A'
alias pll='echo $PWD: && ls -la'
alias ps='ps uwxf'
alias psa='ps auwxf'
alias top='htop'
alias grep='egrep'
alias grn='egrep -Hrn'
alias treenb='tree -F -I build'

alias cdsi='cd src include'
alias cdis='cd include src'

alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gs='git status'
alias gl='git pull'
#alias gp='git push'
alias gpo='git push origin'
alias gd='git diff'
alias gst='git stash'
alias gm='git merge'
alias gsa="find -L . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status && echo)' \;" # same as forall git status
alias cmaked='cmake -DCMAKE_BUILD_TYPE=Debug'

# execute a command inside each dir in $PWD
function forall () {
    #shift 1 # shift to remove $0 from $*
    dirs=$(find -L . -maxdepth 1 -mindepth 1 -type d)
    for d in $dirs; do
        echo $d
        (cd $d && eval $*)
        echo
    done
}

export ASTYLE_OPTIONS="--style=kr --convert-tabs --indent=spaces=4 --add-one-line-brackets --align-pointer=type --lineend=linux --indent-switches --indent-col1-comments --keep-one-line-blocks --keep-one-line-statements"

alias ast='astyle $ASTYLE_OPTIONS -n'
alias py3='python3'
alias ipy='ipython3'

alias please='sudo $(fc -ln -1)'


function cdl  () cd "$1" && ls
function cld  () cd "$1" && ls
function cdll () cd "$1" && ls -la

# display processes tree in less
function pst () { pstree -p $* | less -S }

#Shell functions
unalias l 2>/dev/null
function l {
    if [[ "$#" -eq 0 ]]; then
        ls -C
    elif [[ -f "$1" ]]; then
        less "$1"
    else
        ls -C "$1"
    fi
}

function mkcd {
    mkdir -p "$1" && cd "$1"
}

