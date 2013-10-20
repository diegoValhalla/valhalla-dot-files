# !/bin/bash

echo '================================'
echo -e '## Installing necessary packages\n'
sudo apt-get install vim tmux git exuberant-ctags\
                     build-essential cmake python-dev

echo -e '\n\n================================'
echo -e '## Downloading NeoBundle for Vim\n'
git submodule update --init

echo -e '\n\n================'
echo -e '## Linking files\n'
for file in `ls -A -I README.md -I setup.sh -I .git -I .gitmodules`;
do
    echo $PWD/$file

    if [ $PWD/$file == `readlink -f $HOME/$file` ]; then
        echo "skipping..."
        continue
    elif [ -e $HOME/$file ]; then
        echo "backuping..."
        mv $HOME/$file $HOME/$file-backup-`date +%Y%m%d%H%M%S`
        echo "replacing..."
    else
        echo "linking..."
    fi

    ln -sf $PWD/$file $HOME
done

echo -e '\n\n======================================'
echo -e '## Download and Installing Vim plugins\n'
vim +NeoBundleInstall +q

# install YouCompleteMe plugin
echo -e '\n\n==========================='
echo -e '## Installing YouCompleteMe\n'
cd $HOME/.vim/bundle/plugins/programming/YouCompleteMe/
./install.sh --clang-completer
