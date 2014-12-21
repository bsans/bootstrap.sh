cwd=`pwd`;

make_dir() {
    if [ ! -d "$1" ]; then
        info "making directory $1 \n"
        mkdir $1;
        success "made directory successfully"
    fi
}

source logging.sh

keyboard_interrupt () {
    fail "Keyboard interrupt detected.  Pulling out!\n"
}

trap keyboard_interrupt SIGINT;

DOTFILE_INSTALL_PATH="$cwd/.install";
BASHRC_PATH="$DOTFILE_INSTALL_PATH/bashrc.symlink";

## check to make sure the .install path exists
info "checking dotfile install path\n"
make_dir $DOTFILE_INSTALL_PATH

info "setting up plaftorm...\n"
source platform.sh
success "platform configuration successful"

info "copying bashrc over to $BASHRC_PATH\n"
cp $cwd/bashrc $BASHRC_PATH
if [ $? != 0 ]; then
    fail "cping bashrc failed. \n"
fi

info "checking git configuration\n"
source git/bootstrap.sh
success "git configuration successful"

info "checking vim configuration\n"
source vim/bootstrap.sh
success "vim configuration successful"

info "checking ack configuration\n"
source ack/bootstrap.sh
success "ack configuration successful"

info "checking alias configuration\n"
source aliases/bootstrap.sh
success "alias configuration successful"

info "checking ssh configuation\n"
source ssh/bootstrap.sh
success "ssh configuration successful"

info "adding symlinks to dotfiles\n"
source dotfiles.sh
success "dotfiles configuration successful"

source python/bootstrap.sh
