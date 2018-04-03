"-------------------------------------------------
" dein プラグイン管理
"-------------------------------------------------

filetype off

if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  " dein.vim がなければ github から落としてくる
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:config_dir = s:dein_dir . '/config'
  let s:toml       = g:config_dir . '/dein.toml'
  let s:lazy_toml  = g:config_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ファイル形式別プラグインのロードを有効化
filetype plugin indent on


"-------------------------------------------------
" neocomplcache 設定
"-------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete completeopt-=preview
" jedy-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


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

" インデントの折り返しをキレイに表示
set breakindent

" 大文字小文字を区別せずに検索を行う
set ignorecase

" 検索文字列に大文字が含まれているならば大文字小文字区別して検索する
set smartcase

" 検索結果をハイライトする
set hlsearch

" 検索で途中までマッチしているものをハイライト
set incsearch

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

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

" rubyファイル編集を軽くする
set nofoldenable
set re=1

" JSONのダブルクオートを表示する
set conceallevel=0


"-------------------------------------------------
" Filetype 設定
"-------------------------------------------------

au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.tx set filetype=html
au BufRead,BufNewFile *.tt set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile nginx.conf set filetype=nginx
au BufRead,BufNewFile td-agent.conf set filetype=fluentd
au BufRead,BufNewFile *.service set filetype=toml


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
set expandtab

" 行頭の余白内で Tab を打ち込むと、'shiftwidth'の数だけインデントする
set smarttab

if has("autocmd")
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType fluentd    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType nginx      setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType txt        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vue        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
endif


"-------------------------------------------------
" Color 設定
"-------------------------------------------------

syntax enable
colorscheme molokai
set t_Co=256


"-------------------------------------------------
" command
"-------------------------------------------------
" [:DeinClean] 利用していないpluginを削除する
function! s:deinClean()
  let disabled_plugins = dein#check_clean()
  if len(disabled_plugins)
    call map(disabled_plugins, 'delete(v:val, "rf")')
    call dein#recache_runtimepath()
  else
    echo 'Not exist disabled plugins.'
  endif
endfunction
command! DeinClean :call s:deinClean()
