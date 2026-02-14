scriptencoding utf-8
set nocompatible

"---------------------------------------------------------------------------
" 検索
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch

"---------------------------------------------------------------------------
" 編集
set tabstop=8
set noexpandtab
set autoindent
set backspace=indent,eol,start
set showmatch
set wildmenu
set formatoptions+=mM
set modeline
set history=10000
set hidden

"---------------------------------------------------------------------------
" 表示
set number
set ruler
set nolist
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set cursorline
set helpheight=999
set whichwrap=b,s,h,l,<,>,[,]
set synmaxcol=200

"---------------------------------------------------------------------------
" マウス
set mouse=a

"---------------------------------------------------------------------------
" クリップボード
set clipboard=unnamed,unnamedplus

"---------------------------------------------------------------------------
" バックアップ・スワップ・Undo
set backup
set swapfile
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap
set undofile
set undodir=$HOME/.vim/undo

"---------------------------------------------------------------------------
" Mac 固有設定
if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
  set langmenu=japanese
endif

"---------------------------------------------------------------------------
" IME
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>
inoremap <silent> <C-j> <C-^>
let g:IMState = 0
autocmd InsertEnter * let &iminsert = g:IMState
autocmd InsertEnter * let g:IMState = &iminsert|set iminsert=0 imsearch=0

"---------------------------------------------------------------------------
" 256色対応
if !has('gui_running')
  set t_Co=256
endif

"---------------------------------------------------------------------------
" dein プラグイン管理
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('itchyny/lightline.vim')
call dein#add('t9md/vim-textmanip')
call dein#add('AndrewRadev/switch.vim')

call dein#add('mattn/emmet-vim')
call dein#add('othree/html5.vim')
call dein#add('othree/html5-syntax.vim')

call dein#add('altercation/vim-colors-solarized')
call dein#add('flazz/vim-colorschemes')

call dein#add('rust-lang/rust.vim')
call dein#add('cespare/vim-toml')
call dein#add('editorconfig/editorconfig-vim')

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

call dein#end()

filetype plugin indent on
syntax enable

"---------------------------------------------------------------------------
" カラースキーム
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

if has('mac')
  autocmd ColorScheme * highlight LineNr ctermfg=239
endif

"---------------------------------------------------------------------------
" プラグイン設定

let g:lightline = {
  \ 'colorscheme': 'wombat',
\ }

let g:user_emmet_leader_key='<C-i>'
let g:neocomplete#enable_at_startup = 1
let g:rustfmt_autosave = 1
let g:terraform_align=1
let g:python3_host_prog = $HOME/'.pyenv/shims/python3'

"---------------------------------------------------------------------------
" ファイルタイプ別設定
autocmd FileType python setl autoindent smartindent tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType python setl cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType c      setl autoindent smartindent tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType c      setl cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType html   setl enc=utf-8 fenc=utf-8 tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType js     setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType java   setl enc=utf-8
autocmd FileType ruby   setl fenc=utf-8 enc=utf-8 tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType sql    setl autoindent smartindent tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType scala  setl autoindent smartindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType scala  setl cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType sh     setl autoindent smartindent tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd FileType markdown hi! def link markdownItalic LineNr
autocmd BufNewFile,BufRead *.scala setf scala

"---------------------------------------------------------------------------
" autopep8
function! Preserve(command)
    let search = @/
    let cursor_position = getpos('.')
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    execute a:command
    let @/ = search
    call setpos('.', window_position)
    normal! zt
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

nnoremap <S-f> :call Autopep8()<CR>
