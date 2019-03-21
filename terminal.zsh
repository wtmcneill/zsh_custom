bindkey -v
# Set color prompt
setopt prompt_subst
autoload colors && colors

#version control info
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git cvs
#zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%}"

# evaluate vcs info before each prompt
#precmd () { vcs_info }

setopt HIST_IGNORE_DUPS
unsetopt share_history # oh-my-zsh enables this by default - grrr
setopt shwordsplit # bash-like behavior when splitting words inside variables

setopt NO_NOMATCH # dont bail on a command if glob-matching fails eg git checkout HEAD^1

# Colors change on command exit
#PROMPT="\`if [ \$? = 0 ]; then echo \"%{${fg_bold[white]}%}[%{${fg_bold[cyan]}%}%m %{${fg_bold[red]}%}%c%{${fg_bold[white]}%}]%# %{${reset_color}%}\"; else echo \"%{${fg_bold[white]}%}[%{${fg_bold[red]}%}%m %{${fg_bold[cyan]}%}%c%{${fg_bold[white]}%}]%# %{${reset_color}%}\"; fi \`"

# turn off autocompletion stuff
autoload -U compinit && compinit
#setopt no_auto_menu
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

## stolen from http://free-po.htnet.hr/MarijanPeh/files/zshrc
## add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
## completions ####
## General completion technique
## complete as much u can ..
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
## complete less
#zstyle ':completion:*' completer _expand _complete _list _ignored _approximate
## complete minimal
#zstyle ':completion:*' completer _complete _ignored

#want zsh's pager (<) to use less
export READNULLCMD=less


#export LD_LIBRARY_PATH=/usr/lib:/usr/lib64:/usr/local/lib:/usr/local/lib64

export LS_COLORS="no=00:fi=00:di=00;94:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

export EDITOR=vim
export VISUAL=vim
export CC=$(which gcc 2&> /dev/null)
export CXX=$(which g++ 2&> /dev/null)
export PYTHONSTARTUP=$HOME/.pyrc

# Auto Correct spelling mistakes
#setopt correct
#export SPROMPT="Did you mean \"%r\", dude? [yes, no, abort, edit] "
# Never correct these
# alias foobar="nocorrect foobar"


#typeset -g -A key
#bindkey ''    backward-delete-char
# Fix up key behavior on command line
#bindkey '[A'  up-line-or-history
#bindkey '[B'  down-line-or-history
#bindkey '[H' beginning-of-line
#bindkey '[3~' delete-char
#bindkey '[F' end-of-line
#bindkey '^[[2~' delete-char
#bindkey '^R' history-incremental-search-backward


typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   backward-word
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" forward-word


# Set ctrl-u to remove line and save what it removes
# Undo ctrl-u with ctrl-y
#bindkey '' kill-whole-line
#bindkey '' yank
bindkey '^R' history-incremental-search-backward

# The following lines were added by compinstall

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''

# End of lines added by compinstall
setopt appendhistory autocd extendedglob notify

# Prepend sudo on Alt-s
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


if [[ -f ~/.proxy ]]; then
    source ~/.proxy
fi

if [[ -d ~/.zsh_extras ]]; then
    source ~/.zsh_extras/*
fi

