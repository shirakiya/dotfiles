"-------------------------------------------------
" NeoBundle プラグイン管理
"-------------------------------------------------

filetype off
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tomasr/molokai'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'Align'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'

call neobundle#end()

NeoBundleCheck

" ファイル形式別プラグインのロードを有効化
filetype plugin indent on


"-------------------------------------------------
" neocomplcache 設定
"-------------------------------------------------

" neocomplcacheを起動時に有効化
let g:neocomplcache_enable_at_startup = 1

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:NeoComplCache_SkipInputTime = '0.5'
" カーソルキーで補完候補を表示しない
let g:neocomplcache_enable_insert_char_pre = 1
"inoremap <expr><Up> pumvisible() ? neocomplcache#smart_close_popup()."\<Up>" : "\<Up>"
"inoremap <expr><Down> pumvisible() ? neocomplcache#smart_close_popup()."\<Down>" : "\<Down>"
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><ESC> neocomplcache#smart_close_popup()."\<C-h>"
" 補完候補の共通文字列を補完する(シェル補完のような動作)
inoremap <expr><C-l>   neocomplcache#complete_common_string()

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'


"-------------------------------------------------
" PowerLine 設定
"-------------------------------------------------

let g:Powerline_symbols = 'compatible'


"-------------------------------------------------
" NERDTree 設定
"-------------------------------------------------

" 隠しファイルを表示する。
let NERDTreeShowHidden = 1 

" デフォルトでツリーを表示させる
"autocmd VimEnter * execute 'NERDTree'

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * execute 'NERDTree ./'
endif

" NERDTree呼び出しキーマッピング
nnoremap [NERDTree] <Nop>
nmap <Space>t [NERDTree]
nnoremap <silent> [NERDTree]o :<C-u>NERDTree<CR>


"-------------------------------------------------
" previm 設定
"-------------------------------------------------

" previm呼び出しキーマッピング
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>


"-------------------------------------------------
" Basic
"-------------------------------------------------

" 分割した設定ファイルをすべて読み込む
set runtimepath+=~/.vim/
runtime! conf/*.vim

" カーソルの上または下に表示する最小限の行数
set scrolloff=1

" 入力されているテキストの最大幅 「0」で無効
set textwidth=0

" バックアップの作成は行わない
set nobackup

" Vimの外部で変更されたことが判明したとき、自動的に読み直す
set autoread

" スワップファイルの作成は行わない
set noswapfile

" 保存しないで他のファイルを表示することが出来るようにする
set hidden

" 自動整形の実行方法
set formatoptions=lmoq

" ビープ音 ビジュアルベルを使用しない
set vb t_vb=

" ファイルブラウザの初期ディレクトリ
set browsedir=buffer

" コマンド (の一部) を画面の最下行に表示する
set showcmd

" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" ステータス行を常に表示する
set laststatus=2

" 行番号を表示する。
set number

" コマンドラインに使われる画面上の行数
set cmdheight=2

" Insertモード、ReplaceモードまたはVisualモードで最終行にメッセージを表示する
set showmode

" モードラインの無効化
set nomodeline

" すべてのモードでマウスが有効
set mouse=a

" クリップボードを利用する
set clipboard=unnamed,autoselect

" Insertモード前にあった文字をBackspaceキーで削除可能にする
set backspace=start,eol,indent

" 閉じ括弧が入力されたとき、対応する開き括弧にわずかの間ジャンプする
set showmatch

" カーソル上の行番号のハイライト
set cursorline
hi clear CursorLine

" 検索結果をハイライトする
set hlsearch

" 検索で途中までマッチしているものをハイライト
set incsearch

"補完候補を表示する
set wildmenu
set wildmode=list:longest,full

" インサートモードでもhjklで移動（Ctrlを押しながら）
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" インサートモードでも削除
inoremap <C-x> <BS>

" 'j'2回押下でESC
inoremap jj <ESC>


"-------------------------------------------------
" Color 設定
"-------------------------------------------------

syntax enable
colorscheme molokai


"-------------------------------------------------
" Filetype 設定
"-------------------------------------------------

au BufRead,BufNewFile *.psgi set filetype=perl
au BufNewFile,BufRead *.tx set filetype=html
au BufNewFile,BufRead *.tt set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.airy set filetype=airy


"-------------------------------------------------
" Indent 設定
"-------------------------------------------------

" 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set autoindent

" 新しい行を作ったときに高度な自動インデントを行う
set smartindent

" <Tab> が対応する空白の数。
set tabstop=4

" インデントの各段階に使われる空白の数
set shiftwidth=4

" <Tab> の挿入や <BS> の使用等の編集操作をするときに、<Tab>が対応する空白の数。
set softtabstop=4

" Insertモードで <Tab>を挿入するとき、代わりに適切な数の空白を使う。（有効:expandtab/無効:noexpandtab）
set noexpandtab

" 行頭の余白内で Tab を打ち込むと、'shiftwidth'の数だけインデントする
set smarttab

if has("autocmd")
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType txt        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
endif
