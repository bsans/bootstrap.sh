# TODO (bsans): setup install functions and brew for OSX packages

link_files () {
  ln -s $1 $2
  success "linked $1 to $2"
}
