source ~/.vim.d/vimrc

syntax on
"新しい行のインデントを現在行と同じにする
set autoindent
"バックアップファイルを作るディレクトリ
set backupdir=$HOME/vimbackup
"ファイル選択ダイアログの初期ディレクトリを開いているファイルと同じディレクトリに設定
set browsedir=buffer
"ヤンクしたテキストをデスクトップのクリップボードにコピー
set clipboard=unnamed
"Vi互換をオフ
set nocompatible
"スワップファイル用のディレクトリ
set directory=$HOME/vimbackup
"タブの代わりに空白文字を挿入する
set expandtab
"編集中のファイルを保存せずに他のファイルへ切り替え可能にする
set hidden
"インクリメンタルサーチを行う
set incsearch
" TODO
set hlsearch
nnoremap <ESC><ESC> :noh<CR>
"nnoremap <C-h> :set hlsearch!<CR>
"タブ文字、行末など不可視文字を表示する
"set list
"listで表示される文字のフォーマットを指定する
"set listchars=eol:$,tab:>\ ,extends:<
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
"set smartindent
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
"set nowrapscan

"ファイル内の<Tab>文字を画面上の見た目で何文字分に展開するか
set tabstop=8
"シフトオペレータ(>>や<<)などで挿入/削除されるインデントの幅
set shiftwidth=2
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"入力された<Tab>文字をスペースに展開しない
"set noexpandtab

" ○や□の文字が崩れる問題を回避
set ambiwidth=double

autocmd ColorScheme default highlight Visual ctermbg=15
colorscheme default

"ペースト時にインデントしない
"有効にするとautoindentやend補完が効かなくなる
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
"let g:po_translator="Masafumi Yokoyama <yokoyama@clear-code.com>"
"let g:po_lang_team="LANGUAGE TEAM <E-MAIL at ADDRESS or HOME PAGE>"

" quickrun
au BufNewFile,BufRead *.nim set filetype=nim
"au BufNewFile,BufRead *.textile set filetype=textile
"let g:quickrun_config = {
"    \ 'textile': {
"    \   'command'   : 'redcloth',
"    \   'exec'      : '%c  %s',
"    \   'outputter' : 'browser',
"    \ },
"    \}
"let g:quickrun_config = get(g:, 'quickrun_config', {})
"let g:quickrun_config._ = {
"    \ 'runner'    : 'vimproc',
"    \ 'runner/vimproc/updatetime' : 60,
"    \ 'outputter' : 'error',
"    \ 'outputter/error/success' : 'buffer',
"    \ 'outputter/error/error'   : 'quickfix',
"    \ 'outputter/buffer/split'  : ':rightbelow 8sp',
"    \ 'outputter/buffer/close_on_empty' : 1,
"    \ }
"au FileType qf nnoremap <silent><buffer>q :quit<CR>
"au FileType qf nnoremap <silent><buffer>q :quit<CR>

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

" vim-edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

"" カーソル位置の単語をgrep検索
"nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"
"" unite grep に ag(The Silver Searcher) を使う
"if executable('ag')
"  let g:unite_source_grep_command = 'ag'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"  let g:unite_source_grep_recursive_opt = ''
"endif

"" denite.nvim
"call denite#custom#var('file_rec', 'command',
"      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
"
"call denite#custom#var('grep', 'command', ['ag'])
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'final_opts', [])
"call denite#custom#var('grep', 'separator', [])
"call denite#custom#var('grep', 'default_opts',
"      \ ['--nocolor', '--nogroup'])
"
"nnoremap <silent> <C-k><C-f> :<C-u>Denite file_rec<CR>
"nnoremap <silent> <C-k><C-g> :<C-u>Denite grep<CR>
"nnoremap <silent> <C-k><C-l> :<C-u>Denite line<CR>
"nnoremap <silent> <C-k><C-u> :<C-u>Denite file_mru<CR>
"nnoremap <silent> <C-k><C-y> :<C-u>Denite neoyank<CR>

"" ale
"" 保存時のみ実行する
"let g:ale_lint_on_text_changed = 0
"" 表示に関する設定
"let g:ale_sign_error = '❎'
"let g:ale_sign_warning = '⚠'
""let g:airline#extensions#ale#open_lnum_symbol = '('
""let g:airline#extensions#ale#close_lnum_symbol = ')'
"let g:ale_echo_msg_format = '[%linter%]%code: %%s'
"highlight link ALEErrorSign Tag
"highlight link ALEWarningSign StorageClass
"" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
""nmap <silent> <C-k> <Plug>(ale_previous_wrap)
""nmap <silent> <C-j> <Plug>(ale_next_wrap)

"" vim-airline
""let g:airline_theme = 'wombat'
"set laststatus=2
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
""let g:airline#extensions#wordcount#enabled = 0
""let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
"let g:airline_section_c = '%t'
"let g:airline_section_x = '%{&filetype}'
"let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
"let g:airline#extensions#ale#error_symbol = '❎ '
"let g:airline#extensions#ale#warning_symbol = '⚠ '
""let g:airline#extensions#default#section_truncate_width = {}
""let g:airline#extensions#whitespace#enabled = 1

" lightline.vim
set laststatus=2
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [
      \             [ 'readonly', 'filename', 'modified' ],
      \           ],
      \   'right': [
      \              [ 'gitbranch' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'mode', 'paste' ],
      \            ]
      \ },
      \ 'inactive': {
      \   'left': [
      \             [ 'readonly', 'filename', 'modified' ],
      \           ],
      \   'right': [
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \            ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \   'filename': 'LightLineFilename',
      \ },
      \ 'tabline': {
      \   'left': [[ 'bufferbefore', 'buffercurrent', 'bufferafter' ]],
      \   'right': [],
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \ },
      \ 'component': {
      \   'separator': '',
      \ },
      \ }
function! LightLineFilename()
  return expand('%')
endfunction
" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
"let g:lightline_buffer_logo = ' '
"let g:lightline_buffer_readonly_icon = ''
"let g:lightline_buffer_modified_icon = '✭'
"let g:lightline_buffer_git_icon = ' '
"let g:lightline_buffer_ellipsis_icon = '..'
"let g:lightline_buffer_expand_left_icon = '◀ '
"let g:lightline_buffer_expand_right_icon = ' ▶'
"let g:lightline_buffer_active_buffer_left_icon = ''
"let g:lightline_buffer_active_buffer_right_icon = ''
"let g:lightline_buffer_separator_icon = '  '
"
" lightline-buffer function settings
"let g:lightline_buffer_show_bufnr = 1
"let g:lightline_buffer_rotate = 0
"let g:lightline_buffer_fname_mod = ':t'
"let g:lightline_buffer_excludes = ['vimfiler']
"
"let g:lightline_buffer_maxflen = 30
"let g:lightline_buffer_maxfextlen = 3
"let g:lightline_buffer_minflen = 16
"let g:lightline_buffer_minfextlen = 3
"let g:lightline_buffer_reservelen = 20

" gtags
"map <C-g> :Gtags
"map <C-h> :Gtags -f %<CR>
"map <C-j> :GtagsCursor<CR>
"map <C-n> :cn<CR>
"map <C-p> :cp<CR>

" open-browser.vim
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ----------------------------------------------------
"   dein.vim
" ----------------------------------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  "call dein#add('Shougo/vimproc.vim', {
  "    \ 'build': {
  "    \     'windows' : 'tools\\update-dll-mingw',
  "    \     'cygwin'  : 'make -f make_cygwin.mak',
  "    \     'mac'     : 'make -f make_mac.mak',
  "    \     'linux'   : 'make',
  "    \     'unix'    : 'gmake',
  "    \    },
  "    \ })
  call dein#add('thinca/vim-quickrun')
  call dein#add('tpope/vim-endwise')
  call dein#add('mattn/emmet-vim')
  call dein#add('cohama/agit.vim')
  call dein#add('haya14busa/incsearch.vim')
  "call dein#add('Shougo/unite.vim')
  call dein#add('fuenor/JpFormat.vim')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('othree/html5.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-scripts/rest.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('haya14busa/vim-edgemotion')
  call dein#add('itchyny/lightline.vim')
  call dein#add('taohex/lightline-buffer')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('myokoym/insert-git-log.vim')
  call dein#add('rking/ag.vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('rhysd/committia.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('gregsexton/gitv')
  call dein#add('AndrewRadev/gapply.vim')
  call dein#add('kana/vim-gf-user')
  call dein#add('kana/vim-gf-diff')
  call dein#add('vim-scripts/gitdiff.vim')
  call dein#add('clear-code/git-diff-unified.vim')
  call dein#add('jlanzarotta/bufexplorer')
  "call dein#add('Shougo/denite.nvim')
  "call dein#add('Shougo/neoplete.nvim')

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"" ----------------------------------------------------
""   neobundle
"" ----------------------------------------------------
"if has('vim_starting')
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif
"
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" add plugins
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'tpope/vim-endwise'
""NeoBundle 'kana/vim-smartinput'
""NeoBundle 'mattn/flappyvird-vim'
"NeoBundle 'Shougo/vimproc.vim'
""NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'mattn/emmet-vim'
""NeoBundle 'mattn/webapi-vim'
""NeoBundle 'mattn/gist-vim'
"NeoBundle 'cohama/agit.vim'
""NeoBundle 'cohama/lexima.vim'
"NeoBundle 'haya14busa/incsearch.vim'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'hrsh7th/vim-versions'
"NeoBundle 'fuenor/JpFormat.vim'
"NeoBundle 'slim-template/vim-slim'
"NeoBundle 'tomtom/tcomment_vim'
"NeoBundle 'JuliaLang/julia-vim'
"NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'Xuyuanp/nerdtree-git-plugin'
"NeoBundle 'othree/html5.vim'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'tpope/vim-rails'
"NeoBundle 'tpope/vim-surround'
""NeoBundle 'nvie/vim-rst-tables'
""NeoBundle 'Rykka/clickable.vim'
""NeoBundle 'Rykka/riv.vim'
"NeoBundle 'vim-scripts/rest.vim'
"NeoBundle 'fatih/vim-go'
""NeoBundle 'vim-scripts/po.vim'
"NeoBundle 'rust-lang/rust.vim'
"NeoBundle 'junegunn/vim-easy-align'
"NeoBundle 'fuenor/qfixgrep'
""NeoBundle 'thinca/vim-qfreqlace'
"NeoBundle 'PProvost/vim-ps1'
"NeoBundle 'hotwatermorning/auto-git-diff'
"NeoBundle 'ConradIrwin/vim-bracketed-paste'
"NeoBundle 'haya14busa/vim-edgemotion'
"NeoBundle 'kablamo/vim-git-log'
""NeoBundle 'w0rp/ale'
""NeoBundle 'vim-airline/vim-airline'
""NeoBundle 'vim-airline/vim-airline-themes'
""NeoBundle 'ryanoasis/vim-devicons'
"NeoBundle 'itchyny/lightline.vim'
"NeoBundle 'taohex/lightline-buffer'
"NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'vim-jp/vimdoc-ja'
"NeoBundle 'myokoym/insert-git-log.vim'
"NeoBundle 'vim-scripts/SQLUtilities'
"NeoBundle 'vim-scripts/Align'
"NeoBundle 'vim-scripts/vim-misc'
"NeoBundle 'vim-scripts/lua.vim'
"NeoBundle 'zah/nimrod.vim'
""NeoBundle 'osyo-manga/vim-watchdogs'
"NeoBundle 'rking/ag.vim'
""NeoBundle 'Shougo/denite.nvim'
"
"filetype plugin on
"
"call neobundle#end()
"
"filetype plugin indent on
"
"NeoBundleCheck

