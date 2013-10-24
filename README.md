Valhalla dot-files
==================

**NOTE**: This dot files only supports Vim 7.3.584 or earlier. In
[Valloric/YouCompleteMe][] you can find more details about installing a new
version.

This is my collection of dot files. It includes some configuration files for
tmux and also for vim. It is strongly based on [magic-dot-files][] and
[vim-valloric-colorscheme][] for color scheme.

To install just do:

    $ ./setup.sh


### Vim plugins

I used [NeoBundle][] for manage my plugins, which are:

* [Powerline][]
* [NerdTree][]
* [NerdCommenter][]
* [TagBar][]
* [Syntastic][]
* [YouCompleteMe][]
* [MatchTagAlways][]

If your powerline shows some weird characters, it's better to follow
[Powerline][] explanation how to set a font for it. However, this dot files
will install _DejaVu Sans Mono_ font for it, then it has just to be set in
terminal profile preferences.

I also set my color scheme for vim. You can find it at vim/colors/valhalla.vim.


### Vim shortcuts

* Ctrl-e: open NerdTree;
* Ctrl-c: copy to clipboard in visual mode
* Ctrl-v: paste contents from clipboard
* F8: toggle TagBar;
* F2: toggle paste mode;
* TAB: switch between vim splitted windows in normal mode;


<!-- Reference -->

[Valloric/YouCompleteMe]: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
[magic-dot-files]: https://github.com/magic-dot-files/magic-dot-files
[vim-valloric-colorscheme]: https://github.com/Valloric/vim-valloric-colorscheme
[NeoBundle]: https://github.com/Shougo/neobundle.vim
[Powerline]: https://github.com/Lokaltog/powerline
[NerdTree]: https://github.com/scrooloose/nerdtree
[NerdCommenter]: https://github.com/scrooloose/nerdcommenter
[TagBar]: https://github.com/majutsushi/tagbar
[Syntastic]: https://github.com/scrooloose/syntastic
[YouCompleteMe]: https://github.com/Valloric/YouCompleteMe
[MatchTagAlways]: https://github.com/Valloric/MatchTagAlways
