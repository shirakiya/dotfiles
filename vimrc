"-------------------------------------------------
" NeoBundle プラグイン管理
"-------------------------------------------------

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

" NeoBundle自体を更新可能にする
NeoBundleFetch 'Shougo/neobundle.vim'

" Utility
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
" Color
NeoBundle 'tomasr/molokai'
" Syntax
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'toyamarinyon/vim-swift'

" ':BenchVimrc' を叩くと計測
NeoBundleLazy 'mattn/benchvimrc-vim', {
  \ 'autoload': {
    \   'commands': ['BenchVimrc'],
      \  },
    \}

call neobundle#end()

" 未インストールのものがあればインストールするか確認する
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
" Color 設定
"-------------------------------------------------

syntax enable
colorscheme molokai
set t_Co=256


"-------------------------------------------------
" lightline.vim 設定
"-------------------------------------------------

let g:lightline = {
    \    'colorscheme': 'default',
    \    'active': {
    \        'left': [
    \            ['mode', 'paste'],
    \            ['fugitive', 'gitgutter', 'readonly', 'filename'],
    \        ],
    \    },
    \    'component_function' : {
    \        'fugitive' : 'LightLineFugitive',
    \        'gitgutter': 'MyGitGutter',
    \        'readonly' : 'LightLineReadonly',
    \        'filename' : 'LightLineFilename',
    \    },
    \    'subseparator': { 'left': '|', 'right': '|' }
    \}

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return ('' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction


"-------------------------------------------------
" vim-trailing-whitespace 設定
"-------------------------------------------------

":FixWhitespaceで行末スペースを全て削除


"-------------------------------------------------
" syntastic 設定
"-------------------------------------------------

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"-------------------------------------------------
" RSpec syntax highlight 設定
"-------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config._={
      \ 'outputter/buffer/split': ':botright'
      \ }
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'rspec'
      \ }
augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END


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

" crontabの編集時だけバックアップの作成を行う
autocmd BufRead /private/tmp/crontab.* set backupcopy=yes

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

" ステータス行を常に表示する
set laststatus=2

" ステータスラインのカスタマイズ
"set statusline=%<%F\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}[%Y]
"set statusline+=%=%l/%L,\ %c%V%8P

" コマンドラインに使われる画面上の行数
set cmdheight=2

" Insertモード、ReplaceモードまたはVisualモードで最終行にメッセージを表示する
set showmode

" モードラインの無効化
set modeline

" すべてのモードでマウスが有効
set mouse=a

" クリップボードを利用する
set clipboard=unnamed,autoselect

" Insertモード前にあった文字をBackspaceキーで削除可能にする
set backspace=start,eol,indent

" 閉じ括弧が入力されたとき、対応する開き括弧にわずかの間ジャンプする
set showmatch

" 全角記号をズレずに表示する
set ambiwidth=double

" 行番号を表示する
set number

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

" ノーマルモードにおいて';'で':'
noremap ; :

" Linuxの場合はviminfoを用いてヤンクデータを共有
if has("unix") && !has("mac")
    noremap y y:wv<CR>
    vnoremap x x:wv<CR>
    vnoremap d d:wv<CR>
    noremap p :rv!<CR>p
endif


set viminfo='50,\"3000,:0,n~/.viminfo

"-------------------------------------------------
" Filetype 設定
"-------------------------------------------------

au BufRead,BufNewFile *.psgi set filetype=perl
au BufNewFile,BufRead *.tx set filetype=html
au BufNewFile,BufRead *.tt set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown


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
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
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
