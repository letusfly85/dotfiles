scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
"
" Last Change: 10-Sep-2014.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 1 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

" plugins下のディレクトリをruntimepathへ追加する。
if (has('win32'))
  for s:path in split(glob($VIM.'/plugins/*'), '\n')
    if s:path !~# '\~$' && isdirectory(s:path)
      let &runtimepath = &runtimepath.','.s:path
    end
  endfor
  unlet s:path
endif

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
if (has('win32'))
  source $VIM/plugins/kaoriya/encode_japan.vim
endif
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
    " やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
    " とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
    " まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
    " 化けてしまう。
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
"set list
" set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
"set ts=2
"set listchars=eol:↲,extends:❯,precedes:❮
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=builtin_xterm
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()

if has('win32')
  " vimdoc-ja: 日本語ヘルプを無効化する.
  if kaoriya#switch#enabled('disable-vimdoc-ja')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
  endif

  " vimproc: 同梱のvimprocを無効化する
  if kaoriya#switch#enabled('disable-vimproc')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
  endif
endif

" Copyright (C) 2009-2013 KaoriYa/MURAOKA Taro
"
"
autocmd FileType bl setl filetype=xml


let g:haskell_quasi         = 0
let g:haskell_interpolation = 0
let g:haskell_regex         = 0
let g:haskell_jmacro        = 0
let g:haskell_shqq          = 0
let g:haskell_sql           = 0
let g:haskell_json          = 0
let g:haskell_xml           = 0

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
if has('win32')
  set backupdir=c:\tmp\
  set backup
  set swapfile
  set backupdir=$HOME/.vim/backup
  set directory=$HOME/.vim/swap
else
  set backup
  set swapfile
  set backupdir=$HOME/.vim/backup
  set directory=$HOME/.vim/swap
  set undofile
  set undodir=$HOME/.vim/undo
endif

"--- Vimを終了してもUndo
if has('persistent_undo')
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
else
  set guifontset=Ricty
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
"set columns=120
" ウインドウの高さ
"set lines=45
" コマンドラインの高さ(GUI使用時)
set cmdheight=2

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

autocmd FileType ruby setl fenc=utf-8
autocmd FileType ruby setl enc=utf-8
autocmd FileType ruby setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

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

autocmd FileType sql setl autoindent
autocmd FileType sql setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType sql setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

autocmd FileType scala setl autoindent
autocmd FileType scala set guifont=VL_Gothic:h12
autocmd FileType scala setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType scala setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

autocmd FileType sh setl autoindent
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


"golint
" exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
" auto BufWritePre *.go Fmt


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

" let g:copypath_copy_to_unnamed_register = 1

"http://rcmdnk.github.io/blog/2013/11/17/computer-vim/
" md as markdown, instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" Disable highlight italic in Markdown
autocmd FileType markdown hi! def link markdownItalic LineNr

autocmd FileType *.bl setl filetype=xml

" linux/windows であれば_vimrcが読まれるが、macでは読み込まれないので_vimrcは設けない。
" http://teppeis.hatenablog.com/entry/20080705/1215262928

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin': 'make -f make_cygwin.mak',
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('t9md/vim-textmanip')

call dein#add('Shougo/unite.vim')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('flazz/vim-colorschemes')
call dein#add('tomasr/molokai')

call dein#add('gmarik/vundle')

call dein#add('fatih/vim-go')
"call dein#add('Blackrush/vim-gocode')
call dein#add('dgryski/vim-godef')
call dein#add('vim-jp/vim-go-extra')

call dein#add('elixir-lang/vim-elixir')

call dein#add('alpaca-tc/alpaca_tags')
call dein#add('AndrewRadev/switch.vim')
call dein#add('bbatsov/rubocop')
call dein#add('tpope/vim-endwise')
call dein#add('thinca/vim-ref')
call dein#add('mattn/emmet-vim')
call dein#add('othree/html5.vim')
call dein#add('othree/html5-syntax.vim')
"call dein#add('chiel92/vim-autoformat')
call dein#add('maksimr/vim-jsbeautify')

" colors
" solarized カラースキーム
call dein#add('altercation/vim-colors-solarized')
" mustang カラースキーム
call dein#add('croaker/mustang-vim')
" wombat カラースキーム
call dein#add('jeffreyiacono/vim-colors-wombat')
" jellybeans カラースキーム
call dein#add('nanotech/jellybeans.vim')
" lucius カラースキーム
call dein#add('vim-scripts/Lucius')
" zenburn カラースキーム
call dein#add('vim-scripts/Zenburn')
" mrkn256 カラースキーム
call dein#add('mrkn/mrkn256.vim')
" railscasts カラースキーム
call dein#add('jpo/vim-railscasts-theme')
" pyte カラースキーム
call dein#add('therubymug/vim-pyte')
" molokai カラースキーム
call dein#add('tomasr/molokai')

" python vim plugins
call dein#add('davidhalter/jedi-vim')
call dein#add('scrooloose/syntastic')

call dein#add('rust-lang/rust.vim')
call dein#add('racer-rust/vim-racer')

call dein#add('cespare/vim-toml')

call dein#end()


" カラー設定:
if has('mac')
  colorscheme jellybeans
  autocmd ColorScheme * highlight LineNr ctermfg=239
else
  colorscheme jellybeans
  "colorscheme solarized
  autocmd ColorScheme * highlight LineNr    ctermfg=193 ctermbg=16
  autocmd ColorScheme * highlight IncSearch ctermfg=193 ctermbg=16
  autocmd ColorScheme * highlight Search    ctermfg=157  ctermbg=248
endif

syntax on

set cursorline
set cursorcolumn
set cmdheight=2
set helpheight=999
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set hlsearch
set incsearch
set clipboard=unnamed,unnamedplus

"emmet bind key
let g:user_emmet_leader_key='<C-i>'

"http://qiita.com/shotat/items/da0f42ea90610ca0dadb
set synmaxcol=200

let g:lightline = {
  \ 'colorscheme': 'wombat',
\ }
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
autocmd FileType html setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType js   setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

autocmd BufWritePre *.js call JsBeautify()
autocmd BufWritePre *.html call HtmlBeautify()
autocmd BufWritePre *.css call CSSBeautify()

" autopep 
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    "--ignote=E501: 一行の長さの補正を無視"
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

" Shift + F でautopep自動修正
nnoremap <S-f> :call Autopep8()<CR>
