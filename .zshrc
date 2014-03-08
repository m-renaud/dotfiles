export LC_MESSAGES="C"
export LESS="-rX"
export EMAIL="mrenaud92@gmail.com"

if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# if ! [[ "$PATH" =~ "/home/matt/bin" ]]; then
#     echo "DOES NOT EXIST IN PATH"
#     PATH=$PATH:/home/matt/bin
# fi 

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=200000
SAVEHIST=200000
PAGER="less"
EDITOR="emacs"

WORDCHARS=${WORDCHARS//[-&=\/;_,.!#%{}]}

##################################################
autoload colors zsh/terminfon
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

PR_RESET="$reset_color"
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

# PR_RESET="$reset_color"
# for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
#   eval PR_D$color='$reset_color$fg[${(L)color}]'
#   eval PR_L$color='$reset_color$terminfo[bold]$fg[${(L)color}]'
# done

# PR_BLACK=$PR_DGREY
# PR_DGREY=$PR_LGREY
# PR_LGREY=$PR_DWHITE
PR_NO_COLOR="%{$terminfo[sgr0]%}"


PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_MAGENTA%n$PR_GREY<=>$PR_LIGHT_YELLOW%m $PR_BLUE($PR_WHITE%{$PR_LGREY%}%35<...<%~%{$PR_DGREY%}$PR_BLUE)$PR_WHITE%# "
#RPS1="$PR_RED(%D{%m-%d %H:%M})$PR_NO_COLOR"
#RPS1="$PR_GREY[$PR_GREY]";
#export RPS1="$(print '%{\e[1;30m%}[%{%(?.\e[0;37m.\e[0;31m)%}%?%{\e[1;30m%} %T]%{\e[0m%}')"
RPS1="%{$PR_RESET$PR_GREY%}"'['"%(?..%{$PR_RED%}%?%{$PR_GREY%}e )%(1j.%{$PR_GREEN%}%j%{$PR_GREY%}j .)%T%{$PR_GREY%}"']'"%{$PR_RESET%}";

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall





################################################################################
# MANPAGE READABILITY EXPORTS                                                  #
################################################################################
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;35m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'



################################################################################
# ZSH OPTIONS                                                                  #
################################################################################
setopt EXTENDED_HISTORY  # put timestamps in the history
setopt correctall
setopt hist_verify 
setopt SHARE_HISTORY
setopt print_exit_value
setopt completealiases
setopt autopushd


################################################################################
# ADDITIONAL ZSH MODULES                                                       #
################################################################################
zmodload zsh/mathfunc           # math

################################################################################
# COMPLETION COMMANDS                                                          #
################################################################################


# Cache Tab Expansions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ...EXCEPT for CVS
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# Fuzzy match fat fingered commands
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only

# Expanding error tolerance
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Ignore completion for nonexistant functions
zstyle ':completion:*:functions' ignored-patterns '_*'


# Menu selection for PIDS in kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/metasploit:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/root/.gem/ruby/1.9.1/bin

# Proper key behaviour
#bindkey "[3~" delete-char
#bindkey "[1~" beginning-of-line
#bindkey "[4~" end-of-line
#bindkey "[2~" quoted-insert

# History search
bindkey "[A" history-beginning-search-backward
bindkey "[B" history-beginning-search-forward


autoload -U compinit
compinit
bindkey -e
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[w' backward-delete-word
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'



##################################################
# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle '*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6-) 

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort


source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh


if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
