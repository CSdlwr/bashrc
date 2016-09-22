#export TERM=xterm-256color
export OpenCV_DIR="/Users/luminglv/openCV/opencv-2.4.11/build"
export PYTHONPATH="/Users/luminglv/openCV/opencv-2.4.11/lib/:$PYTHONPATH"
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias qscript="cd /Users/luminglv/q/idea_project/mobile_hotel/parse_git/offline-script"
alias qllmscript="cd /Users/luminglv/q/luming.lv_gitlab/offline-script"
#alias updatefromgitrepo="sh /Users/luminglv/q/idea_project/mobile_hotel/parse_git/offline-script/script/sh_pack/update_from_local_git_repo.sh"
alias updatefromgitrepo="update_from_git_repo"
#alias qlg="sh /Users/luminglv/lg.sh"
#alias qlg=qlg
alias emacs="/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw"
alias gitaddmodify=gitaddmodify
#alias gitcommit="git commit -m"
#alias gcit="git commit -m"
#alias gcit=gcit
alias glog="git log --graph --format=\"%C(green)%h%Creset %C(yellow)%d%Creset - %an @ %C(blue)%ad%Creset --> %s\" --date=iso8601"
alias gp=gitpush
alias gpcurrent=git_push_current
alias gau="git add -u"
alias gitautocommit=git_auto_commit
alias gitautopush=git_auto_push

function qlg {
    if [[ $# != 1 ]]; then
	echo "which rtools do you want to login ?"
	echo "Usage: qlg [1-8], function return 100"
    fi

    ssh luming.lv@host.name
}

function gitaddmodify() {
    gst | grep "modified" | awk -F ":   " '{print $2}' | xargs git add
}

function gitpush {
    if [[ $# != 1 ]];then
	echo "which remote branch do you want to push ?"
	echo "Usage gitpush \"remote/branch/name\"; function return 100"
	return 100
    fi
    #curr_branch=$(gb | grep "*" | awk '{print $2}')
    local local_branch_name=$(git symbolic-ref --short HEAD)
    git push origin $local_branch_name:$1
}

function gitpushcurrent() {
    if [[ $# != 0 ]];then
	echo "args format error"
	return
    fi
    #current_origin_branch=$(gb -vv | grep "*" | awk -F "origin/" '{print $2}' | awk -F "]" '{print $1}')
    current_origin_branch=$(gb -vv | awk '{print $4}' | awk -F "origin/" '{print $2}' | awk -F ":" '{print $1}')
    if [[ ${current_origin_branch: -1} == "]" ]];then
	current_origin_branch=${current_origin_branch%?}
    fi
    gitpush "$current_origin_branch"
}

function git_push_current {
    local local_branch_upstream=$(git rev-parse --abbrev-ref @{upstream} | awk -F "origin/" '{print $2}')
    gitpush $local_branch_upstream
}

function update_from_git_repo {
    if [[ $# < 1 ]]; then
	echo "which files would you want to update from local git repo ?"
	echo "Usage: updatefromgitrepo file1 [file2 ...], function return 100"
	return 100
    fi

    local dest_path=$(pwd)
    local branch=master

    qllmscript
    git checkout $branch
    git pull
    local file
    for file in "$@"
    do
	find . -type f -name "$file" -exec /bin/cp -f {} $dest_path \;
    done
    cd $dest_path
}

function gcit {
    if [[ $# < 1 ]]; then
	echo "commit message string is expected"
	echo "Usage: gcit \"commit message\", function return 100"
	return 100
    fi

    local msg="$*"
    local local_branch_name=$(git symbolic-ref --short HEAD)
    git commit -m "$local_branch_name: $msg"
}

function git_auto_commit {
    if [[ $# < 1 ]]; then
	echo "commit message string is expected"
	echo "Usage: git_auto_commit \"commit message\"; function return 100 now"
	return 100
    fi
    gaa
    local msg="$*"
    gcit $msg
}

function git_auto_push {
    git_auto_commit "$*"
    if [[ $? == 100 ]]; then
	return 100
    fi
    gpcurrent
}