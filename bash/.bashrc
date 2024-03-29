# ~/.bashrc

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

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

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# Enable history appending instead of overwriting.  #139609
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend


#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# PS1 Config ...

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

function set_virtualenv(){
	if test -z "$VIRTUAL_ENV" ; then
	    PYTHON_VIRTUALENV=""
	else
	    PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
	fi
}


__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[1;31m\]' g='\[\e[1;30m\]' h='\[\e[1;34m\]' \
    u='\[\e[1;33m\]' p='\[\e[1;34m\]' w='\[\e[1;35m\]' \
    b='\[\e[1;36m\]' x='\[\e[1;0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(uname -n):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$u($b$B$u)"

  # short="$r[$u\u$g$r$PROMPT_AT$h\h$g$p: $w$dir$r]$B$p$P$x$u[$r r $g g $h h $u u $p p $w w $b b $x x] "
  # r -> red.
  # g -> grey.
  # h -> blue1.
  # u -> orange.
  # p -> blue2.
  # w -> purple.
  # b -> green.
  # x -> white with yellowish tint.

  set_virtualenv

  short="$w$PYTHON_VIRTUALENV$r[$u\u$g$r$PROMPT_AT$h\h$g$p: $w$dir$r]$B$b$P$x "
  PS1="$short"

}

PROMPT_COMMAND="__ps1"

# autocompletion
complete -C zet zet
complete -C class class
complete -C pomo pomo

# Exports ...
export TERM='xterm-256color'
export CFLAGS='-Wall -Wextra -Werror'
export EDITOR="vim"
export LANG=en_IN.UTF-8
export LC_ALL=en_IN.UTF-8

# Path ...
export PATH="$PATH:~/repos/scripts/:~/repos/cmd-zet:~/go/bin:/opt/flutter/bin:"
export PATH="$PATH:$GOBIN:/home/hmm009/.cargo/bin:/home/hmm/.local/bin"
export CDPATH=".:~:~/learning:~/java:~/repos:~/repos/zet:~/.config:~/:~/repos/dot/:./:~/subjects:"
export GOPATH="$HOME/go"

# Colors for man pages ...
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


# USER DEFINED ENV VARAIBLES:
export SNIPS="$HOME/repos/dot/snippets"
export SCRIPTS="$HOME/repos/scripts/"
export REPOS="$HOME/repos/"
export GOBIN="$HOME/go/bin"
export ANDROID_NDK_HOME="$HOME/android-ndk/"

# Custom Aliases
alias '?'=duck
alias '??'=google
alias '???'=bing
alias brc="$EDITOR ~/.bashrc && source ~/.bashrc"
alias alac="$EDITOR ~/.config/alacritty/alacritty.yml"
alias c="clear"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias doom='emacs'
alias egrep='egrep --colour=auto'
alias emacs="emacsclient -c -a 'emacs'"
alias fgrep='fgrep --colour=auto'
alias fishes='asciiquarium'
alias free='free -m'                      # show sizes in MB
alias grep='grep --colour=auto'
alias ls='ls --color=auto -h --group-directories-first'
# alias more="less"
alias np='nano -w PKGBUILD'
alias open='xdg-open'
alias r="$EDITOR -R +Goyo "
alias rm="echo YOU ARE NOT SUPPOSE TO USE IT ..."
alias todo="cd ~/repos/TODO"
alias vrc="$EDITOR ~/.vimrc"
alias gitall="git fetch && git pull && git add . && git commit && git push"
alias shot="sleep 3 && flameshot gui"
alias ping="ping -c 3"
alias vm="virtualboxvm --seamless --startvm"
alias neofetch="neofetch --w3m $HOME/.config/neofetch/planets.jpg/"

# Importing Personal Bashrc
if [[ -z "$HOME/.bashrc-personal" ]];
then
    source "$HOME/.bashrc-personal"
fi

if [[ -z "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]];
then
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi

if [[ -z "$HOME/repos/cita" ]];
then
    cita
fi

# Misc settings ...
set -o vi
set keymap vi

PATH="/home/hmm009/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/hmm009/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hmm009/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hmm009/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hmm009/perl5"; export PERL_MM_OPT;

