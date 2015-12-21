# !/bin/bash

DOT_FILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo '================================'
echo -e '## Installing necessary packages\n'
sudo apt-get install vim tmux git exuberant-ctags\
                     build-essential cmake python-dev cowsay fortune\
                     npm nodejs-legacy

# for javascript:
#   - jshint: to Syntastic vim plugin check javascript syntax
#   - jsctags: to TagBar vim plugin works properly with javascript
sudo npm -g install jshint
sudo npm -g install git://github.com/ramitos/jsctags.git

echo -e '\n\n================================'
echo -e '## Downloading NeoBundle for Vim\n'
git submodule update --init
git submodule foreach 'git checkout master'

echo -e '\n\n================'
echo -e '## Linking files\n'
for file in `ls -A -I README.md -I setup.sh -I .git -I .gitmodules -I .fonts \
    -I .config`;
do
    echo -e $PWD/$file

    if [ $PWD/$file == `readlink -f $HOME/$file` ]; then
        echo " .......skipping"
        continue
    else
        echo " .......linking"
    fi

    ln -sb --suffix='.bak' $PWD/$file $HOME
done

echo -e '\n\n======================================'
echo -e '## Download and Installing Vim plugins\n'
vim +NeoBundleInstall +qall

# install Hack Regular font with size 10 for Powerline
echo -e '\n\n==========================='
echo -e '## Installing Hack Regular font with size 10 for Powerline\n'
if [ -d $HOME/.fonts/ ]; then
    ln -s $PWD/.fonts/* $HOME/.fonts/
else
    ln -s $PWD/.fonts/ $HOME
fi
cd $HOME/.fonts/
fc-cache -fv

# install YouCompleteMe plugin
echo -e '\n\n==========================='
echo -e '## Installing YouCompleteMe\n'
cd $HOME/.vim/bundle/plugins/programming/YouCompleteMe/
./install.sh --clang-completer

# set gnome terminal profile which is based on Ubuntu's Terminal color
echo -e '\n\n==========================='
echo -e '## Set GNOME terminal profile based on:'
echo -e 'git@github.com:chriskempson/base16-gnome-terminal.git\n'
ln -sf $DOT_FILES_DIR/.config/base16-gnome-terminal/ $HOME/.config/
source $HOME/.config/base16-gnome-terminal/base16-paraiso.dark.sh

source ~/.bashrc
echo -e '**Open a new terminal**'
