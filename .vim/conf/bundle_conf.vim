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
inoremap <expr><Up> pumvisible() ? neocomplcache#smart_close_popup()."\<Up>":"\<Up>"
inoremap <expr><Down> pumvisible() ? neocomplcache#smart_close_popup()."\<Down>":"\<Down>"
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

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
" NERDTree 設定
"-------------------------------------------------

"隠しファイルを表示する。
let NERDTreeShowHidden = 1 

" デフォルトでツリーを表示させる
"autocmd VimEnter * execute 'NERDTree'

"引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * execute 'NERDTree ./'
endif


"-------------------------------------------------
" PowerLine 設定
"-------------------------------------------------

let g:Powerline_symbols = 'compatible'
