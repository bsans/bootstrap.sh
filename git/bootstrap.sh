GIT_CONFIG_PATH="$DOTFILE_INSTALL_PATH/gitconfig.symlink";

git_clone() {
    git clone $1 $2 >> $LOGDIR/git.log;
    if [ $? != 0 ]; then
       fail "git clone did not succeed\n"
    fi
}

install_git () {
    install "git" "git"
    GIT_PATH=$(which git);
    info "git path: $GIT_PATH\n"
}

configure_git_name() {
  info "trying to configure git name & email...\n"

  if hash git 2>/dev/null; then
      git config --global user.email "michael@mvanveen.net"
      git config --global user.name "Michael Van Veen"
  else
      fail "git is not installed!\n"
  fi
}

install_git
copy_file git/config $GIT_CONFIG_PATH;
configure_git_name
