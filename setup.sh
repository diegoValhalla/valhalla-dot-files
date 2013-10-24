# !/bin/bash

echo '================================'
echo -e '## Installing necessary packages\n'
sudo apt-get install vim tmux git exuberant-ctags\
                     build-essential cmake python-dev cowsay fortune

echo -e '\n\n================================'
echo -e '## Downloading NeoBundle for Vim\n'
git submodule update --init
git submodule foreach 'git checkout master'

echo -e '\n\n================'
echo -e '## Linking files\n'
for file in `ls -A -I README.md -I setup.sh -I .git -I .gitmodules`;
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

echo -e '\n\n======================================'
echo -e '## Download and Installing Vim plugins\n'
vim +NeoBundleInstall +q

# install YouCompleteMe plugin
echo -e '\n\n==========================='
echo -e '## Installing YouCompleteMe\n'
cd $HOME/.vim/bundle/plugins/programming/YouCompleteMe/
./install.sh --clang-completer
