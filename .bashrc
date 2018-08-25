
export M2_HOME=/Users/mac/maven/apache-maven-3.5.3
export M2=$M2_HOME/bin 
export PATH=$M2:$PATH  
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home

alias logindev14="~/dev-login-121.199.52.14.sh"
alias logindev205="~/dev-login-139.129.233.205.sh"
alias loginbetac="~/login-betac.sh"
alias jumper="ssh -p2222 luming.lv@jumpserver.corp.yaduo.com"
#alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

alias emd="/Applications/Emacs.app/Contents/MacOS/Emacs --daemon"
alias em="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -a=vim"
alias emc="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -a=vim"

LESSPIPE=`which src-hilite-lesspipe.sh`

export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '
export EDITOR="emc"

alias ismergemaster="git branch -a --merged | grep origin/master"
alias mvnc="mvn clean"
alias mvncc="mvn clean compile"
