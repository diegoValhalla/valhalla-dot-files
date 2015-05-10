" .vimrc based on:
"   - https://github.com/magic-dot-files/magic-dot-files (strongly based on)
"   - http://www.slackorama.com/projects/vim/vimrc.html
"   - http://spf13.com/post/perfect-vimrc-vim-config-file/
"   - http://amix.dk/vim/vimrc.html


" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on
if has("syntax")
    syntax on
endif

" To Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"Plugins {

    " NeoBundle settings
    if !1 | finish | endif

    "Run VIM scripts from isolated directories by adding them to VIM's
    if has('vim_starting')
        if &compatible
        set nocompatible               " Be iMproved
    endif

        " Required:
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    " Required:
    call neobundle#begin(expand('~/.vim/bundle/'))

    " Let NeoBundle manage NeoBundle
    " Required:
    NeoBundleFetch 'Shougo/neobundle.vim'


    "Powerline {
        " Vim status line
        set laststatus=2  "show status bar
        NeoBundle 'Lokaltog/powerline', {
                    \ 'base' : '~/.vim/bundle/plugins/general/',
                    \ 'directory' : 'powerline/',
                    \ 'rtp' : 'powerline/bindings/vim/'
                    \ }

        " Set term to xterm to display powerline colors
        if match($TERM, "screen*") != -1 || match($TERM, "xterm*") != -1
            set term=xterm-256color
        endif
    "}


    "NerdTree {
        " It's a directory explorer. Shortcut Ctrl-e.
        NeoBundle 'scrooloose/nerdtree', {
                    \ 'base' : '~/.vim/bundle/plugins/general/',
                    \ 'directory' : 'nerdtree/'
                    \ }
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.bak', '\.o', '\.e', '\.obj']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    "}


    "NERDCommenter {
        " Plugin to comment lines.
        " :help NERDCommenter
        NeoBundle 'scrooloose/nerdcommenter', {
                    \ 'base' : '~/.vim/bundle/plugins/programming/',
                    \ 'directory' : 'nerdcommenter/'
                    \ }
    "}


    "TagBar {
        "It provides a sidebar with the information of class and methods in
        "the file.
        " - To use it, it's need to install the package: exuberante-ctags
        " - Shortcut defined F8.
        NeoBundle 'majutsushi/tagbar', {
                    \ 'base' : '~/.vim/bundle/plugins/programming/',
                    \ 'directory' : 'tagbar/'
                    \ }

        "search starts in the directory of the current file and goes to its
        "parent
        set tags=./tags
        nmap <F8> :TagbarToggle<CR>
    "}


    "Syntastic {
        "It's a syntax C-error checker that display it when the file is saved.
        NeoBundle 'scrooloose/syntastic', {
                    \ 'base' : '~/.vim/bundle/plugins/programming/',
                    \ 'directory' : 'syntastic/'
                    \ }
    "}


    "YouCompleteMe {
        "for Vim >= 7.3.584. It also has Jedi as a submodule.
        NeoBundle 'Valloric/YouCompleteMe', {
                    \ 'base' : '~/.vim/bundle/plugins/programming/',
                    \ 'directory' : 'YouCompleteMe/'
                    \ }

        let g:ycm_min_num_identifier_candidate_chars = 4
        let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/plugins/programming/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
        let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}

        " disable preview popup during completion
        set completeopt-=preview

        nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
        nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
        nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
        nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
    "}


    "MatchTagAlways {
        "highlight open and close tags
        NeoBundle 'Valloric/MatchTagAlways', {
                    \ 'base' : '~/.vim/bundle/plugins/programming/',
                    \ 'directory' : 'MatchTagAlways/'
                    \ }
    "}


    "Ctags {
        "To run ctags in background
        nmap <C-l> :call system('ctags --tag-relative --recurse --sort=yes --fields=+l --exclude=".git" . &')<CR><CR>
    "}

    "vim-javascript-syntax {
        "enhanced javascript syntax
        NeoBundleLazy 'jelera/vim-javascript-syntax', {
                        \ 'base' : '~/.vim/bundle/plugins/programming/',
                        \ 'directory' : 'vim-javascript-syntax/',
                        \ 'autoload': {'filetypes': ['javascript']}
                        \ }
    "}

    call neobundle#end()

    " To have Vim load indentation rules and plugins according to the detected
    " filetype.
    filetype plugin indent on

    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.
    NeoBundleCheck
" }


"==== Status Line ====

    " Status line to be used when Powerline is not working.

    " Get git branch
    function! GitBranch()
        let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
        if branch != ''
            return '[' . substitute(branch, '\n', '', 'g') . ']'
        endif
        return ''
    endfunction

    " Change the home directory by the symbol '~'
    function! CurDir()
        return substitute(getcwd(), $HOME, "~", "g")
    endfunction

    if has('statusline')
        set laststatus=2                        " show status bar
        set statusline=[%{&ff}/%Y]              " filetype
        set statusline+=\ [%{CurDir()}]
        set statusline+=\ %{GitBranch()}        " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
    endif


" Settings {

    set encoding=utf8       " Set utf8 as standard encoding and en_US as the
                            " standard language

    colorscheme valhalla    " My custom color scheme
    set number

    " main indentation is with spaces
    " NOTE: use :retab command in a file if the tabs weren't change
    set tabstop=4           " Define tab stop to 4 spaces
    set shiftwidth=4        " Shift + >, command will be 4 spaces
    set expandtab           " Use spaces instead of tab

    set ai                  " Copy indent of the previous line
    set smartindent         " Try to guess the right indentation

    set hls                 " Highlight the search string
    set ic                  " Make an insensitive search case
    set incsearch           " Enable search while typing
    set cursorline

    set wildmenu                                        " Command-line completion in an enhanced mode
    set wildmode=list:longest,full                      " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore=*.bak,*.o,*.e,*~,*.obj,.git,*.pyc    " Wildmenu: ignore these extensions

    " to display a » and · when a tab or space are typeded.
    set list
    set listchars=tab:»·,trail:·,extends:#,nbsp:.

    set textwidth=79        " limit text width to 79 characters
    set showcmd             " Show (partial) command in status line
    set showmatch           " Show matching brackets.
    set scrolloff=5         " stop scroll when 5 lines left

    " make the arrows and 'h' and 'l' keys go to the first or last character of
    " a line in normal, visual, insert and replace modes.
    set whichwrap+=<,>,[,]
    set whichwrap+=h,l

    set splitbelow          " new split panes to bottom
    set splitright          " new split panes to right

    " Highlight unnecessary white spaces in red
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/                               " match trailing white spaces
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/         " show white spaces in the end of line in all windows
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/  " show trailing white spaces after typing
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/         " show white spaces in the end of line
    autocmd BufWinLeave * call clearmatches()                   " clear buffer

    " Set the working directory the same as the file that is being edited.
    autocmd BufEnter * silent! lcd %:p:h

    " setting text width for git commits
    au FileType gitcommit set tw=49

    set pumheight=8 "limit to 8 lines to show in the pop-up

    " Vim 7.4.1-52 backspace is not working properly
    set backspace=indent,eol,start
" }

" ==== User MAP's ====

    " If one of the maps is not working do like: :verbose imap <Tab>, to see
    " what commands are map to the key.

    set pastetoggle=<F2>    " Enable paste mode to not allow auto-ident

    " Note * is the buffer register and + the clipboard register
    vnoremap <C-c> "+y          " Make Ctrl+c copy to clipboard in visual mode
    nnoremap <C-v> "+P          " Make Ctrl+v paste from clipboard in visual mode
    nnoremap <Space> :noh<CR>   " To disable highlight search temporarily
    vnoremap <Tab> >gv          " Do the tab and keep highlighted the selected text
    vnoremap <S-Tab> <gv
    nnoremap <Tab> <C-w>w       " Switch between splits and vertical splits in normal mode

    " To automaticly show which tag must be closed
    imap <C-Space> <C-X><C-O>
