GIT_REPO="https://github.com/mvanveen/bootstrap.sh.git";
BOOTSTRAP_ZIP="https://github.com/mvanveen/bootstrap.sh/archive/master.zip";
BOOTSTRAP_DIR="$HOME/.bootstrap.sh";

cwd="$HOME"
LOGDIR="$cwd/.logs"

make_dir() {
    if [ ! -d "$1" ]; then
        info "making directory $1 \n"
        mkdir $1;
        success "made directory successfully"
    fi
}

copy_file() {
    cp $1 $2;
    if [ $? != 0 ]; then
        fail "cping bashrc failed. \n"
    fi
    success "copied $1 to $2"
}



bootstrap () {
    curl "https://raw.githubusercontent.com/mvanveen/bootstrap.sh/master/logging.sh" > /tmp/logging.sh
    bash "/tmp/logging.sh"

    curl "https://raw.githubusercontent.com/mvanveen/bootstrap.sh/master/ubuntu" > ubuntu.sh

    curl "https://raw.githubusercontent.com/mvanveen/bootstrap.sh/master/platform.sh" > /tmp/platform.sh
    bash "/tmp/platform.sh"
}
bootstrap

warning () {
  printf "\r\033[2K  [\033[0;31mWARN\033[0m] $1\n"
  echo ''
}

if [ -d $BOOTSTRAP_DIR ]; then
    warning "removing old .bootstrap.sh dir";
    rm -rf $BOOTSTRAP_DIR ;
fi

if hash git 2>/dev/null; then
    info "cloning bootstrap into $BOOTSTRAP_DIR\n";
    git clone $GIT_REPO $BOOTSTRAP_DIR
else
    warning "git is not installed\n";
    curl "https://raw.githubusercontent.com/mvanveen/bootstrap.sh/master/git/bootstrap.sh" > /tmp/git.sh
    source /tmp/git.sh
    install_git
fi

BOOTSTRAP_SCRIPT="$BOOTSTRAP_DIR/bootstrap.sh";

if [ ! -f $BOOTSTRAP_SCRIPT ]; then
    fail "could not find bootstrap.sh"
fi

echo $BOOTSTRAP_SCRIPT
cd $BOOTSTRAP_DIR;
PWD=$BOOTSTRAP_DIR
bash bootstrap.sh;
