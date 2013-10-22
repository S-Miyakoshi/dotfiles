"------------------------------------------------
" neobundle setting
"------------------------------------------------
set notitle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/neobundle.vim

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/neosnippet'
NeoBundle 'rhysd/unite-ruby-require.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'taichouchou2/surround.vim'
NeoBundle 'taglist.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-rails'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'dbext.vim'
NeoBundle 'scrooloose/nerdcommenter.git'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'taq/vim-rspec'
NeoBundle 'timcharper/textile.vim'
NeoBundle 'open-browser.vim'
NeoBundle 'Markdown'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'violetyk/cake.vim'
NeoBundle 'ruby-matchit'
" NeoBundle 'JavaScript-syntax'
" NeoBundle 'yaymukund/vim-rabl'
" NeoBundle 'taichouchou2/alpaca_powertabline'
" NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}

filetype plugin indent on
filetype plugin on

" open neocomplcache
let g:neocomplcache_enable_at_startup = 1

" neocomplcacheが強制的に'completefunc'を上書きする
" ただし、プラグインの'completefunc'は使用できなくなる。
let g:neocomplcache_force_overwrite_completefunc = 1

" vim-powerline setting
let g:Powerline_symbols='fancy'
set t_Co=256

" nerdcommenter setting
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>cs <Plug>NERDCommenterSexy

" taglist setting
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
map <silent> <Leader>l :TlistToggle<CR>

" quick run setting
let g:quickrun_config = {}
let g:quickrun_config.textile = {
  \ 'command': 'redcloth',
  \ 'exec': '%c %s',
  \ 'outputter': 'browser',
  \ }

let g:quickrun_config.markdown = {
  \ 'outputter/buffer/close_on_empty': 1,
  \ 'command': 'open',
  \ 'cmdopt': '-a',
  \ 'args': 'Marked',
  \ 'exec': '%c %o %a %s',
  \ }

let g:quickrun_config.html = {
  \ 'command': 'open',
  \ }

" syntastic settings
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['ruby', 'javascript', 'php'],
  \ 'passive_filetypes': []
  \}

" unite-ruby-require setting
let g:unite_source_ruby_require_ruby_command = '$HOME/.rbenv/shims/ruby'

" jscomplete-vim setting
let g:jscomplete_use = ['dom', 'moz', 'es6th']

" tagbar settings
nnoremap <C-J><C-T> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '$HOME/homebrew/Cellar/ctags'
let g:tagbar_type_javascript = {
  \'ctagsbin' : '$HOME/homebrew/lib/node_modules/jsctags'
\}

" javascript-indenter setting
let g:SimpleJsIndenter_BriefMode = 1

"------------------------------------------------
" unite shortcut
"------------------------------------------------
noremap <C-U><C-B> :Unite buffer<CR>
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
"------------------------------------------------
" basic setting
"------------------------------------------------
set nobackup
"set noswapfile
set directory=$HOME/tmp

set vb t_vb=

"------------------------------------------------
" color setting
"------------------------------------------------
syntax enable
" set background=dark
" colorscheme solarized
colorscheme molokai

"------------------------------------------------
" tab setting
"------------------------------------------------
set expandtab "Tab をスペースに置き換える
set tabstop=2
set softtabstop=2
set shiftwidth=2

" au BufNewFile,BufRead *.php set nowrap tabstop=4 shiftwidth=4 softtabstop=4

"------------------------------------------------
" display setting
"------------------------------------------------
set autoindent
set number "行番号表示
set cursorline

" draw only current window
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear cursorline
:hi cursorline gui=underline
highlight cursorline ctermbg=black guibg=black

" Esc2回押しでハイライト削除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"------------------------------------------------
" edit setting
"------------------------------------------------
" 保存時に行末の空白を除去
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge
" クリップボードの共有
set clipboard=unnamed
" ノーマルモードで ; と : を入れ替える
nnoremap ; :

"------------------------------------------------
" tab page setting
"------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]l :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]h :tabprevious<CR>
" tp 前のタブ


"------------------------------------------------
" gjslint setting
"------------------------------------------------
autocmd FileType javascript :compiler gjslint
autocmd QuickfixCmdPost make copen

