alias gfrh='git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard'
alias grm-merged="git branch --merged | egrep -v 'master|develop' | xargs git branch -d"
alias gcd='git checkout develop'
