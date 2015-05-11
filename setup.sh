# !/bin/bash

echo '================================'
echo -e '## Installing necessary packages\n'
sudo apt-get install vim tmux git exuberant-ctags\
                     build-essential cmake python-dev cowsay fortune\
                     npm nodejs-legacy

echo -e '\n\n================================'
echo -e '## Downloading NeoBundle for Vim\n'
git submodule update --init
git submodule foreach 'git checkout master'

echo -e '\n\n================'
echo -e '## Linking files\n'
for file in `ls -A -I README.md -I setup.sh -I .git -I .gitconfig -I .gitmodules -I .fonts/`;
do
    echo -n $PWD/$file

    if [ $PWD/$file == `readlink -f $HOME/$file` ]; then
        echo " .......skipping"
        continue
    else
        echo " .......linking"
    fi

    ln -sb --suffix='-backup' $PWD/$file $HOME
done

# TODO find a better way to link .gitconfig to $HOME
echo ".gitconfig.......hard linking"
ln .gitconfig $HOME

echo -e '\n\n======================================'
echo -e '## Download and Installing Vim plugins\n'
vim +NeoBundleInstall +q

# install DejaVu Sans Mono font for Powerline
echo -e '\n\n==========================='
echo -e '## Installing DejaVu Sans Mono font for Powerline\n'
if [ -d $HOME/.fonts/ ]; then
    cp -pr .fonts/* $HOME/.fonts/
else
    ln -sb --suffix='-backup' $PWD/.fonts/ $HOME/.fonts/
fi
cd $HOME/.fonts/
fc-cache -fv

# install YouCompleteMe plugin
echo -e '\n\n==========================='
echo -e '## Installing YouCompleteMe\n'
cd $HOME/.vim/bundle/plugins/programming/YouCompleteMe/
./install.sh --clang-completer

source ~/.bashrc
