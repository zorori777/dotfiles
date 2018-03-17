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

# git
source ~/dotfiles/.git-prompt.sh
source ~/dotfiles/.git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
