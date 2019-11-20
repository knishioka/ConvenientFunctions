alias dc='docker container'
alias dca='docker container ls -a'
alias dce='docker container exec'
alias dcl='docker container ls'
alias dcm='docker container rm'
alias dcp='docker container cp'
alias di='docker image'
alias dia='docker image ls -a'
alias dil='docker image ls'
alias dn='docker network'
alias dnl='docker network ls'
alias dv='docker volume'
alias dvl='docker volume ls'
alias get-job-queues="aws batch describe-job-queues | jq '.jobQueues[] | {jobQueueName, jobQueueArn}'"
alias gfrh='git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard'
alias k='kubectl'
alias sls='s3cmd ls'
alias ta='tmux attach'
alias tl='tmux ls'
alias today='date "+%Y%m%d"'
