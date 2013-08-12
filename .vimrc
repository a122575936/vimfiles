"set setting
set hidden              " Keep changed buffers without requiring saves.
set number              " Display line numbers.
set laststatus=2        " Always show a status line.
set vb t_vb=        	" Use null visual bell (no beeps or flashes).
set guioptions-=T       " Turn off the toolbar
set guioptions-=m       " Turn off the menu
set guioptions-=r       " Turn off the scroll bar
set autoindent          " auto indent  actionscript indent?
set smartindent         " smartindent better than autoindent
set showmode            " display the current mode
set showcmd             " show partial commands in status line and
set showmatch           " show matching brackets/parenthesis
set wildmenu            " show list instead of just completing
set cursorline          " highlight current line
set ignorecase          " search
set columns=150
set lines=40
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set mouse=c
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 " set encoding=utf-8
set completeopt=longest,menuone " doesn't select the first completion item
set rtp+=$GOROOT/misc/vim   " go lang support
set autowrite autoread 
set complete+=k
set display=lastline
set laststatus=2
set cmdheight=1
set lazyredraw
set foldmethod=marker
set incsearch
set hlsearch
"use space to replace tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

syntax on 

filetype plugin indent on

"call pathogen#infect()
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


Bundle 'gmarik/vundle'


"Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/vimwiki'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'godlygeek/tabular'
Bundle 'Raimondi/delimitMate'
Bundle 'sukima/xmledit'
Bundle 'wikitopian/hardmode'


set background=dark
colorscheme solarized

command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

"let g:EasyMotion_leader_key = '<Leader>'

let g:neocomplcache_enable_at_startup = 0

let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = ''

let Tlist_Close_On_Select = 1
let Tlist_Ctags_Cmd = 'ctags.exe'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let g:tlist_ant_settings = 'ant;p:Project;t:Target'
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

"vimwiki settings
let wiki_1 = {}
let wiki_1.path = '~/SkyDrive/vimwiki/'
let g:vimwiki_list = [wiki_1]

" When vimrc is edited, reload it
autocmd bufwritepost .vimrc source ~/vimfiles/.vimrc
autocmd FileType actionscript set dictionary+=~/vimfiles/dict/actionscript.dict
autocmd FileType actionscript set makeprg=ant         " set ant as make program
autocmd FileType actionscript silent! %s///gi
autocmd FileType actionscript call SourceWorkspace()
"设置Vim的errorformat以支持mxmlc编译器
autocmd FileType actionscript let &errorformat=iconv("%E\ \ \ \ [compc]%f(%l):\ 列:\ %c\ %m", 'utf8', &enc)
"Write when you leave insert mode
autocmd InsertLeave * silent! write
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

nnoremap <leader>e :e ~/vimfiles/.vimrc<CR>
nnoremap <silent> <F9> :TlistToggle<CR>

" Toggle the Taglist window
nnoremap \l  :TlistToggle<CR>
nnoremap \w  :cd d:\WorldWar\trunk\Client\FlashClient\ \| set ft=actionscript<CR>
nnoremap \c  :cd d:\WorldWar\trunk\ClientRun\NativeClient\GameResPak\resource\Package\config\<CR>
nnoremap \v  :cd C:\Users\liweiwei\vimfiles\<CR>
nnoremap \t  :!ctags -R --languages=actionscript<CR>
nnoremap \s  :so %<CR>

" Insert one line and back to normal model
noremap oo o<esc>
noremap OO O<esc>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <middlemouse> <nop>
map <F12> :NERDTreeToggle<CR>
map <F11> :make<CR>
" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" execute project related configuration in current directory
if filereadable("workspace.vim")
    source workspace.vim
endif 

function! SourceWorkspace()
    if filereadable("workspace.vim")
        source workspace.vim
    endif 
endfunction

if has("win32")
    "copy to system clipboard instead of * register
    set clipboard=unnamed
    " Remove the current directory from the backup directory list.
    "
    set backupdir-=.
    " Save backup files in the current user's TEMP directory
    " (that is, whatever the TEMP environment variable is set to).
    "
    set backupdir^=$TEMP
    " Put swap files in TEMP, too.
    "
    set directory=$TEMP\\\\
endif

set tags=tags

"Toggle forward/back slashes
function! ToggleSlash(independent) range
  let from = ''
  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    let first = matchstr(line, '[/\\]')
    if !empty(first)
      if a:independent || empty(from)
        let from = first
      endif
      let opposite = (from == '/' ? '\' : '/')
      call setline(lnum, substitute(line, from, opposite, 'g'))
    endif
  endfor
endfunction
command! -bang -range ToggleSlash <line1>,<line2>call ToggleSlash(<bang>1)
noremap <silent> <F8> :ToggleSlash<CR>
"end .vimrc
