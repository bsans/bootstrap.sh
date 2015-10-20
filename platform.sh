platform='unknown';
unamestr=`uname`;

if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
   #TODO(mvv): install things other than ubuntu
   source ubuntu.sh
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
   source osx.sh
fi

success "detected & configured platform: $platform"
