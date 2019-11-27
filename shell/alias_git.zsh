alias gfrh='git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard'
alias grmmerged="git branch --merged | egrep -v '\\*master' | xargs git branch -d"
alias gcd='git checkout develop'
