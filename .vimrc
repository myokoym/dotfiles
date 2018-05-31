" git clone https://github.com/clear-code/vim.d.git ~/.vim.d
source ~/.vim.d/vimrc
source ~/.vim.d/mapping.vim
source ~/.vim.d/leader.vim
source ~/.vim.d/plugin.vim
source ~/.vim.d/japanese.vim
source ~/.vim.d/plugin-settings/lightline.vim
source ~/.vim.d/plugin-settings/JpFormat.vim
source ~/.vim.d/plugin-settings/ctrlp.vim
source ~/.vim.d/plugin-settings/vim-anzu.vim
source ~/.vim.d/plugin-settings/vim-operator-surround.vim
source ~/.vim.d/plugin-settings/altr.vim

" バッファを記憶しておく
" TODO: ディレクトリごとに記憶したい
exec 'set viminfo=%,' . &viminfo

" https://stackoverflow.com/questions/2147875/what-vim-commands-can-be-used-to-quote-unquote-words
" sはsurroundのs
"nnoremap <Leader>s" ciw""<Esc>P
"nnoremap <Leader>s' ciw''<Esc>P
"nnoremap <Leader>s` ciw``<Esc>P
"nnoremap <Leader>s( ciw()<Esc>P
"nnoremap <Leader>s{ ciw{}<Esc>P
"nnoremap <Leader>s[ ciw[]<Esc>P

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>

function! s:search(pat)
  let l:cache = []
  execute '%s/' . a:pat . '/\=add(l:cache, submatch(0))/n'
  call setreg(v:register,join(l:cache, "\n"))
endfunction
command! -nargs=* SearchYank call s:search(<q-args>)

"noremap <Leader>ceg :bufdo bd<CR>:call EditGitModifiedFiles()<CR>
"noremap <silent> <Leader>cge :bufdo bd<CR>:call EditGitModifiedFiles()<CR>:BufExplorer<CR>

"" 選択範囲でgrepしたい（試行中）
vnoremap <Leader>vg y:vimgrep "<C-r>"" %<CR>
vnoremap <Leader>vg y:Pt "<C-r>"" %<CR>

autocmd ColorScheme default highlight Visual ctermbg=15
colorscheme default

"let g:ctrlp_dont_split = 'nerdtree'
"let g:ctrlp_dont_split = 'NERD'
"let g:ctrlp_dont_split = 'NERD_tree_1'
"let g:ctrlp_dont_split = 'NERD_tree_2'
"let g:ctrlp_cmd = ':NERDTreeClose\|CtrlP'
"function! CtrlPCommand()
"    let c = 0
"    let wincount = winnr('$')
"    " Don't open it here if current buffer is not writable (e.g. NERDTree)
"    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
"        exec 'wincmd w'
"        let c = c + 1
"    endwhile
"    exec 'CtrlP'
"endfunction
"let g:ctrlp_cmd = 'call CtrlPCommand()'

" vim-altr
" source ~/.vim.d/plugin-settings/altr.vim に移動
"call altr#define('%.js', '%.controller.js', '%.html')
"call altr#define('%.service.js', '%.service.spec.js')
""call altr#define('%.controller.js', '%.html')
"call altr#define('doc/source/%.rst', 'doc/locale/ja/LC_MESSAGES/%.po')

"" alternate.vim
"" The actual {extension -> extensions} map
"call lh#alternate#register_extension('g', 'js'  , g:alternates.extensions.js + ['html'])
"call lh#alternate#register_extension('g', 'html', g:alternates.extensions.html + ['js'])
"" The {filetype -> extensions} map
""let g:alternates.ft.cpp += ['tpp']

" FSwitch
"au! BufEnter *.js let b:fswitchdst = 'html' | let b:fswitchlocs = '../inc'
"au! BufEnter *.html let b:fswitchdst = 'js' | let b:fswitchlocs = '../inc'

"" vim-expand-region
"vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)

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

" Enable slim syntax highlight
autocmd FileType slim setlocal foldmethod=indent
autocmd BufNewFile,BufRead *.slim set filetype=slim

autocmd BufNewFile,BufRead *.es6 set filetype=javascript



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


" gtags
"map <C-g> :Gtags
"map <C-h> :Gtags -f %<CR>
"map <C-j> :GtagsCursor<CR>
"map <C-n> :cn<CR>
"map <C-p> :cp<CR>

"" ----------------------------------------------------
""   dein.vim
"" ----------------------------------------------------
"" プラグインが実際にインストールされるディレクトリ
"let s:dein_dir = expand('~/.vim/dein')
"" dein.vim 本体
"let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"
"" dein.vim がなければ github から落としてくる
"if &runtimepath !~# '/dein.vim'
"  if !isdirectory(s:dein_repo_dir)
"    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
"  endif
"  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
"endif
"
"" 設定開始
"if dein#load_state(s:dein_dir)
"  call dein#begin(s:dein_dir)
"
"  "call dein#add('Shougo/vimproc.vim', {
"  "    \ 'build': {
"  "    \     'windows' : 'tools\\update-dll-mingw',
"  "    \     'cygwin'  : 'make -f make_cygwin.mak',
"  "    \     'mac'     : 'make -f make_mac.mak',
"  "    \     'linux'   : 'make',
"  "    \     'unix'    : 'gmake',
"  "    \    },
"  "    \ })
"  "call dein#add('Shougo/unite.vim')
"  call dein#add('fuenor/JpFormat.vim')
"  call dein#add('tomtom/tcomment_vim')
"  call dein#add('tpope/vim-surround')
"  call dein#add('vim-scripts/rest.vim')
"  call dein#add('junegunn/vim-easy-align')
"  call dein#add('itchyny/lightline.vim')
"  call dein#add('taohex/lightline-buffer')
"  call dein#add('ctrlpvim/ctrlp.vim')
"  call dein#add('rhysd/committia.vim')
"  "call dein#add('airblade/vim-gitgutter')
"  call dein#add('gregsexton/gitv')
"  call dein#add('AndrewRadev/gapply.vim')
"  "call dein#add('Shougo/denite.nvim')
"  "call dein#add('Shougo/neoplete.nvim')
"  call dein#add('terryma/vim-expand-region.vim')
"  call dein#add('skalnik/vim-vroom')
"
"  " 設定終了
"  call dein#end()
"  call dein#save_state()
"endif
"
"" もし、未インストールものものがあったらインストール
"if dein#check_install()
"  call dein#install()
"endif

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

