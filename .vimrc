syntax on
"新しい行のインデントを現在行と同じにする
set autoindent
"バックアップファイルを作るディレクトリ
set backupdir=$HOME/vimbackup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
"クリップボードをWindowsと連携
set clipboard=unnamed
"Vi互換をオフ
set nocompatible
"スワップファイル用のディレクトリ
set directory=$HOME/vimbackup
"タブの代わりに空白文字を挿入する
set expandtab
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
"set list
"listで表示される文字のフォーマットを指定する
"set listchars=eol:$,tab:>\ ,extends:<
"行番号を表示する
set number
"シフト移動幅
"set shiftwidth=4
set shiftwidth=2
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
"set tabstop=4
set tabstop=8
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
"set nowrapscan

"タブをタブとして扱う（スペースに展開しない）
"set noexpandtab

autocmd ColorScheme default highlight Visual ctermbg=15
colorscheme default

"ペースト時にインデントしない
"有効にするとautoindentやend補完がおかしくなる
"set paste
set pastetoggle=<C-e>

"行末の空白をハイライトする
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\t\+\|\s\+$/
augroup END

" vimgrepで常にquickfix-windowを開く（|cw する）
autocmd QuickFixCmdPost *grep* cwindow

" vim-endwise
let g:endwise_no_mappings = 1
autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd

" po.vim
let g:po_translator="Masafumi Yokoyama <yokoyama@clear-code.com>"
"let g:po_lang_team="LANGUAGE TEAM <E-MAIL at ADDRESS or HOME PAGE>"

" quickrun
au BufNewFile,BufRead *.textile set filetype=textile
let g:quickrun_config = {
    \ 'textile': {
    \   'command'   : 'redcloth',
    \   'exec'      : '%c  %s',
    \   'outputter' : 'browser',
    \ },
    \}

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" JpFormat.vim
"" 原稿文字数(全角の折り返し文字数)
let JpCountChars = 35
"" 日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"" 現在行を整形
nnoremap <silent> gl :JpFormat<CR>
vnoremap <silent> gl :JpFormat<CR>
"" 自動整形のON/OFF切替
"" 30gCの様にカウント指定すると、現バッファのみ折り返し文字数を指定されたカウントに変更します。
nnoremap <silent> gc :JpFormatToggle<CR>
"" 現バッファを整形
nnoremap <silent> g,rJ :JpFormatAll<CR>
"" 原稿枚数カウント
nnoremap <silent> g,rc :JpCountPages!<CR>
"" 外部ビューアを起動する
nnoremap <silent> <F8> :JpExtViewer<CR>

" Enable slim syntax highlight
autocmd FileType slim setlocal foldmethod=indent
autocmd BufNewFile,BufRead *.slim set filetype=slim

autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" nerdtree
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeChDirMode = 2
"let g:NERDTreeDirArrows=0
let NERDTreeWinSize = 25
nnoremap <silent><C-e> :NERDTreeToggle<CR>
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------
"   neobundle
" ----------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugins
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-endwise'
"NeoBundle 'kana/vim-smartinput'
"NeoBundle 'mattn/flappyvird-vim'
"NeoBundle 'Shougo/vimproc.vim'
"NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'mattn/emmet-vim'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'mattn/gist-vim'
NeoBundle 'cohama/agit.vim'
"NeoBundle 'cohama/lexima.vim'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'hrsh7th/vim-versions'
NeoBundle 'fuenor/JpFormat.vim'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'JuliaLang/julia-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
"NeoBundle 'nvie/vim-rst-tables'
"NeoBundle 'Rykka/clickable.vim'
"NeoBundle 'Rykka/riv.vim'
NeoBundle 'vim-scripts/rest.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'vim-scripts/po.vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'fuenor/qfixgrep'
"NeoBundle 'thinca/vim-qfreqlace'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'hotwatermorning/auto-git-diff'

filetype plugin on

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
