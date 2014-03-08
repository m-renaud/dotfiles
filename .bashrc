if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/bin/git-completion.bash ]; then
    . ~/bin/git-completion.bash
fi

if [ -f ~/.Xdefaults ]; then
    xrdb ~/.Xdefaults
fi

if [ -f ~/.xinitrc ]; then
    source ~/.xinitrc
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

export LESS="-erX"

shopt -s extglob
shopt -s autocd

# from Zak Blacher
setPS1 ()
{
    # COLOUR DEFINITIONS

    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    #PS1
    case $TERM in
	zsh)
	    PS1="${W}[${EMB}%n${W}@${R}%m ${G}($?:0) ${M}%d${W}]${NONE}\$ "
	    ;;
	xterm|*rxvt*|linux)
	    PS1="${W}[${B}\u${W}@${R}\h ${G}($?:\j) ${M}\W${W}]${NONE}\$ "
	    ;;
	screen)
	    PS1='\[\033k\033\\\]\[\033[0;37m\][\[\033[0;33m\]($?) \[\033[0;35m\]\W\[\033[0;37m\]]\[\033[0m\]% '
	    ;;
    esac
}


PROMPT_DIRTRIM=2
PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`[\[\033[1;36m\]\u\[\033[0m\]@\[\033[1;31m\]\h \[\033[1;32m\]($?:\j) \[\033[1;35m\]\W\[\033[0m\]]\[\033[0m\]% "

#==========================================================================

#System Info

function psg
{
    ps eaux | match $*
}

function mrpath    # adds ~/bin/ to path
{
    PATH=$HOME/bin:$PATH
}

function label # from uncle roland
{
    save_PS1=$PS1
    lbl=$*
    case $TERM in
	xterm*)
	    local TITLEBAR='\[\033]0;$lbl\007\]'
	    ;;
	*)
	    local TITLEBAR=''
	    ;;
    esac

    PS1="${TITLEBAR}$save_PS1"
}

function lst   #from uncle roland
{
    ls -ltr $* | tail
}

function g
{
    getmail
    getmail -v -l -ruwindsormail
}

##############################
## SCHOOL



#########################
## Pictures

function p_find
{
    find /home/u1/pics/ -name *.pnote | match $*
}

#########################
## Xml indent

function xml_indent
{
    xmlstarlet tr ~/bin/xml-indent.xsl $1
}

#########################
## java compile

function j
{
    javac $1.java && java $1
}


function g++gl
{
    g++ -lglut -lGL -lGLU $1
}



# Local Variables:
# eval: (shell-script-mode)
# End:
