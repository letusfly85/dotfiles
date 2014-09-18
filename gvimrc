let g:haskell_quasi         = 0
let g:haskell_interpolation = 0
let g:haskell_regex         = 0
let g:haskell_jmacro        = 0
let g:haskell_shqq          = 0
let g:haskell_sql           = 0
let g:haskell_json          = 0
let g:haskell_xml           = 0
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version gvimrc file.
" 日本語版のデフォルトGUI設定ファイル(gvimrc) - Vim7用試作
"
" Last Change: 10-Sep-2014.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、GUI関連の設定が書かれていま
" す。編集時の挙動に関する設定はvimrcに書かかれています。
"
" 個人用設定は_gvimrcというファイルを作成しそこで行ないます。_gvimrcはこの
" ファイルの後に読込まれるため、ここに書かれた内容を上書きして設定することが
" 出来ます。_gvimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIM
" よりも優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/gvimrc_local.vim)が存在するならば、本設
" 定ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:gvimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version

" plugin pathogen 利用
":call pathogen#runtime_append_all_bundles()

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/gvimrc_local.vim)があれば読み込む。読み込んだ後
" に変数g:gvimrc_local_finishに非0な値が設定されていた場合には、それ以上の設
" 定ファイルの読込を中止する。
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.gvimrc_first.vim)があれば読み込む。読み込んだ後に変
" 数g:gvimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_gvimrc_exampleに非0な値を設定しておけばインクルードしない。
if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif

"---------------------------------------------------------------------------
" カラー設定:
"colorscheme zmrok
"colorscheme leo
"colorscheme desertEx
"colorscheme jellybeans
"colorscheme Chocolateliquor
"colorscheme darkZ
"colorscheme RailsCasts
colorscheme desert256
"colorscheme dw_orange
set backupdir=c:\tmp\
set backup
set swapfile
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap

"--- Vimを終了してもUndo
if has('persistent_undo')
  set undofile
  set undodir=$HOME/.vim/undo
endif


"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  "set guifont=Inconsolata:h12
  set guifont=VL_Gothic:h13:cSHIFTJIS
  "set guifont=Ricty_Diminished:h12:cSHIFTJIS
  "set guifont=メイリオ:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    "set guifont=Inconsolata:h12
    set guifont=Ricty_Diminished:h13
    "set guifont=VL_Gothic:h12
    ":cSHIFTJIS
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=VL_Gothic:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=120
" ウインドウの高さ
set lines=45
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme jellybeans" (GUI使用時)
"colorscheme desertEx" (GUI使用時)

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" メニューに関する設定:
"
" 解説:
" "M"オプションが指定されたときはメニュー("m")・ツールバー("T")供に登録され
" ないので、自動的にそれらの領域を削除するようにした。よって、デフォルトのそ
" れらを無視してユーザが独自の一式を登録した場合には、それらが表示されないと
" いう問題が生じ得る。しかしあまりにレアなケースであると考えられるので無視す
" る。
"
if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
" 検索文字列をハイライトしない(_vimrcではなく_gvimrcで設定する必要がある)
"set nohlsearch

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif

" Copyright (C) 2011 KaoriYa/MURAOKA Taro
set sm
set ai
syntax on
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

""" ref.vim
let g:ref_use_vimproc = 0   " vimprocをインストールしてない場合は0を指定
nmap ,rr :<C-u>Ref refe<Space>
nmap ,ra :<C-u>Ref alc<Space>
nmap ,rp :<C-u>Ref phpmanual<Space>

if exists('*ref#register_detection')
  call ref#register_detection('_', 'alc') " 適切な対象が無い場合はalcで検索
endif

" phpmanual
let g:ref_phpmanual_path = $DROPBOX_DIR . '/Documents/PHP/phpmanual'

" alc
let g:ref_alc_start_linenumber = 39


autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType c setl autoindent
autocmd FileType c setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType c setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType html setl enc=utf-8 fenc=utf-8
autocmd FileType java setl enc=utf-8

autocmd FileType ruby setl autoindent
autocmd FileType ruby setl fenc=utf-8
autocmd FileType ruby setl enc=utf-8
autocmd FileType ruby setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType ruby setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd BufNewFile *.rb 0r $VIM_HOME/template/ruby.tpl

autocmd FileType d setl autoindent
autocmd FileType d setl fenc=utf-8
autocmd FileType d setl enc=utf-8
autocmd FileType d setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType d setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType groovy setl autoindent
autocmd FileType groovy setl fenc=utf-8
autocmd FileType groovy setl enc=utf-8
autocmd FileType groovy setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType groovy setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType Rakefile setl autoindent
autocmd FileType Rakefile setl fenc=utf-8
autocmd FileType Rakefile setl enc=utf-8
autocmd FileType Rakefile setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType Rakefile setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType tpl setl autoindent
autocmd FileType tpl setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType tpl setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType sql setl autoindent
autocmd FileType sql setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType sql setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

autocmd FileType scala setl autoindent
autocmd FileType scala set guifont=VL_Gothic:h12
"Inconsolata:h12
autocmd FileType scala setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType scala setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType sh setl autoindent
"autocmd FileType sh set guifont=Inconsolata:h12
autocmd FileType sh set guifont=VL_Gothic:h12
autocmd FileType sh setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType sh setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

"autocmd FileType haskell setl autoindent
"autocmd FileType haskell setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType haskell setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

:abbreviate #b /**********************************************
:abbreviate #e <Space> **********************************************/
:abbreviate #t #################################################

let g:rsenseUseOmniFunc = 1

autocmd FocusGained * set transparency=220
"autocmd FocusLost * set tsransparency=100

" ファイルが選択されたら、ウィンドウを閉じる
:let g:proj_flags = "imstc"

" <Leader>Pで、プロジェクトをグルで開閉する
:nmap <silent> <Leader>P <Plug>ToggleProject

" <Leader>pで、デフォルトのプロジェクトを開く
:nmap <silent> <Leader>p :Project<CR>

autocmd BufAdd .vimprojects silent! %foldopen!

if getcwd() != $HOME
  if filereadable(getcwd(). '/.vimprojects')
    Project .vimprojects
  endif
endif

" git add
let g:proj_run1='!git add %f'
let g:proj_run_fold1='*!git add %f'

set modeline

" 挿入モード終了時にIME状態を保存しない
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-^>

" fコマンドなどでのIMEをOFFにする
let g:IMState = 0
autocmd InsertEnter * let &iminsert = g:IMState
autocmd InsertEnter * let g:IMState = &iminsert|set iminsert=0 imsearch=0

set number

set nocompatible

filetype off

" gocode
set rtp+=$GOROOT/misc/vim
"golint
exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

" Vundle を初期化して
" Vundle 自身も Vundle で管理
set rtp+=c:\users\wada-s\.vim\bundle\vundle\
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Blackrush/vim-gocode'
filetype plugin indent on 

"" Go
filetype plugin indent on
syntax on
auto BufWritePre *.go Fmt

Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler.vim'

"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>z [unite]
 
" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>
 
" vinarise
let g:vinarise_enable_auto_detect = 1
 
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
"" }}}

let g:copypath_copy_to_unnamed_register = 1

"http://rcmdnk.github.io/blog/2013/11/17/computer-vim/
" md as markdown, instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" Disable highlight italic in Markdown
autocmd FileType markdown hi! def link markdownItalic LineNr

autocmd FileType *.bl setl filetype=xml
