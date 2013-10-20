" Vim Color Scheme
"   - https://github.com/Valloric/vim-valloric-colorscheme/blob/master/colors/valloric.vim (strongly based on it)
"   - http://ianbits.googlecode.com/svn/trunk/vim/blackboard.vim
"
"   - http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"   - http://www.sbf5.com/~cduan/technical/vi/vi-4.shtml
"   - http://learnvimscriptthehardway.stevelosh.com/chapters/45.html
"
" To check which group belong a keyword do :syn, but to check the highlight
" configuration of a scheme do :hi.
"
" Color chart in 256: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
      syntax reset
    endif
endif
let g:colors_name="valhalla"

"
" Support for 256-color terminal
"
if &t_Co >= 256
    hi Boolean         ctermfg=135
    hi Number          ctermfg=135
    hi Character       ctermfg=143
    hi String          ctermfg=143
    hi Conditional     ctermfg=214
    hi Repeat          ctermfg=214
    hi Constant        ctermfg=135
    hi Cursor          ctermfg=16   ctermbg=253
    hi Debug           ctermfg=225              cterm=bold
    hi Define          ctermfg=81
    hi Delimiter       ctermfg=241

    hi DiffAdd                      ctermbg=24
    hi DiffChange      ctermfg=181  ctermbg=239
    hi DiffDelete      ctermfg=162  ctermbg=53
    hi DiffText                     ctermbg=102 cterm=bold

    hi Directory       ctermfg=44               cterm=bold
    hi Error           ctermfg=219  ctermbg=89
    hi Exception       ctermfg=214
    hi Float           ctermfg=135
    hi FoldColumn      ctermfg=67   ctermbg=16
    hi Folded          ctermfg=67   ctermbg=16
    hi Function        ctermfg=202
    hi Identifier      ctermfg=208
    hi Ignore          ctermfg=244  ctermbg=232
    hi IncSearch       ctermfg=193  ctermbg=16

    hi Keyword         ctermfg=161              cterm=bold
    hi Label           ctermfg=229              cterm=none
    hi Macro           ctermfg=193
    hi SpecialKey      ctermfg=81

    hi ModeMsg         ctermfg=229
    hi MoreMsg         ctermfg=229
    hi Operator        ctermfg=214              cterm=bold

    hi PreCondit       ctermfg=193
    hi PreProc         ctermfg=81
    hi Question        ctermfg=81
    hi Search          ctermfg=253  ctermbg=66

    " marks column
    hi SignColumn      ctermfg=118  ctermbg=235
    hi SpecialChar     ctermfg=214              cterm=bold
    hi SpecialComment  ctermfg=245              cterm=bold
    hi Special         ctermfg=214              cterm=bold
    hi SpecialKey      ctermfg=245

    hi Statement       ctermfg=42               cterm=bold
    hi Include         ctermfg=118
    hi StorageClass    ctermfg=208
    hi Structure       ctermfg=75               cterm=bold
    hi Tag             ctermfg=161
    hi Title           ctermfg=166
    hi Todo            ctermfg=231  ctermbg=232 cterm=bold

    hi Typedef         ctermfg=75               cterm=bold
    hi Type            ctermfg=75
    hi Underlined      ctermfg=244              cterm=underline

    hi VertSplit       ctermfg=236  ctermbg=236
    hi Visual                       ctermbg=236

    hi Comment         ctermfg=248
    hi CursorLine                   ctermbg=233 cterm=none
    hi CursorColumn                 ctermbg=234
    hi LineNr          ctermfg=240

    " pop-up window color; selection color; scroll color
    hi Pmenu           ctermfg=0    ctermbg=7
    hi PmenuSel                     ctermbg=43
    hi PmenuThumb      ctermfg=40   ctermbg=30
end
