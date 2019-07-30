# alias
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias la='ls -a'
alias ll='ls -l'

alias rs='rails s'
alias rc='rails c'
alias bi='bundle install --path vendor/bundle '
alias be='bundle exec'

# React
alias cra='create-react-app'
alias ns='npm start'
alias crna='create-react-native-app'
alias rni='react-native init'

# git
source ~/dotfiles/.git-prompt.sh
source ~/dotfiles/.git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# Docker
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcb='docker-compose build'


# Hyper Terminal
function title {
    export TITLE_OVERRIDDEN=1
    PROMPT_COMMAND=''
    echo -ne "\033]0;"$*"\007"
}

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    show_command_in_title_bar()
    {
        if [[ "$TITLE_OVERRIDDEN" == 1 ]]; then return; fi
        case "$BASH_COMMAND" in
            *\033]0*)
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND} - ${PWD##*/}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

