check_python() {
info "checking for Python\n"

if hash python 2>/dev/null; then
    PYTHON_PATH=`which python`;
    success "python found at $PYTHON_PATH"
    PYTHON_VERSION=` python -c 'import sys; print(sys.version_info[:])'`;
    info "python version: $PYTHON_VERSION\n"

else
    user "Python not detected.  OK to install python2.7? [Y/n]"
    read -n 1 action
    case "$action" in
     Y)
       install=true;;
     n)
       install=false;;
     *)
       ;;
    esac
fi

if [[ $install == true ]]; then
    install "python27"
fi

}

check_python;

install "pip" "python-pip";

install "virtualenv" "python-virtualenv"
if hash mkvirtualenv 2> /dev/null; then
    info "virtualenvwrapper is already installed"
else
    user "Install virtualenvwrapper? [Y/n]"
    read -n 1 action
    case "$action" in
      Y)
        vwrapinstall=true;;
      n)
        vwrapinstall=false;;
      *)
        ;;
    esac
    if [[ $vwrapinstall == true ]]; then
      sudo pip install virtualenvwrapper >> $LOGDIR/pip.log;
      if [ $? != 0 ]; then
          fail "installing virtualenvwrapper failed. \n"
      fi
      make_dir "$HOME/.virtualenvs"
    fi
fi

success "configured python successfully"
