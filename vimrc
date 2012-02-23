call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible                " Use vim rather than Vi
"set background=dark
set hidden                      " hide buffers instead of closing them
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=5000	            " keep 50 lines of command line history
set undofile
set undolevels=1000
set undoreload=10000

set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set number                      " show line numbers
set showmatch

set incsearch                   " do incremental searching
set hlsearch                    " turn on search highlighting

set autoindent
set smartindent
set copyindent                  " copy the previous indentation on autoindenting
set expandtab                   " spaces are better than tabs
set smarttab
set shiftwidth=4                " Who wants an 8 character tab?  Not me!
set softtabstop=4
set tabstop=4                   " tabs are 4 spaces
set textwidth=120
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

"set autochdir

set wildmenu                    " Cool tab completion stuff
set wildmode=list:longest,full

"set ignorecase
"set smartcase

set list                        " highlight whitespaces
set listchars=tab:▸\ ,eol:¬

set matchpairs+=<:>             " Match angle brackets
set foldmethod=syntax           " Fold according to syntax rules
set foldlevel=99                " Initially dont fold anything

let mapleader = ","


if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
    syntax on
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

   "set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
   " Remove trailing whitespaces and ^M chars
   autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Remove any trailing whitespace that is in the file
  autocmd BufRead,BufWrite * if ! &bin |silent! %s/\s\+$//ge | endif
endif " has("autocmd")

if has('cmdline_info')
   set ruler " show the ruler
   set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
   set showcmd " show partial commands in status line and
   " selected characters/lines in visual mode
endif

if has('statusline')
        set laststatus=2

   " Broken down into easily includeable segments
   set statusline=%<%f\ " Filename
   set statusline+=%w%h%m%r " Options
   set statusline+=\ [%{&ff}/%Y] " filetype
   set statusline+=\ [%{getcwd()}] " current dir
   "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
   set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif


" configure tags - add additional tags here or comment out not-used ones
 set tags+=~/.vim/tags/cpp
 set tags+=~/.vim/tags/linux
 set tags+=~/.vim/tags/boost
" build tags of your own project with Ctrl-F12
 map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1      " autocomplete after .
let OmniCpp_MayCompleteArrow = 1    " autocomplete after ->
let OmniCpp_MayCompleteScope = 1    " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest    ",preview


noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

"Turn on and off invisible characters
nmap <leader>l :set list!<CR>

"Tagbar toggle
let g:tagbar_usearrows=1
nnoremap <leader>t :TagbarToggle<CR>

"Let SuperTab use OmniComplete
let g:SuperTabDefaultCompletionType = "context"

"window resizing
nnoremap <C-+> :resize +10<CR>
nnoremap <C--> :resize -10<CR>

"toggle .{c|cpp}/.{h|hpp}
nnoremap <silent> <C-A> :A<CR>

"insert newline
nnoremap <C-J> i<CR><Esc>==}

"quickfix window
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>]

"NERDTree
nnoremap <Leader>r :NERDTreeToggle<CR>
nnoremap <Leader>R :NERDTreeMirror<CR

"CScope
"set cscopetag=0

nmap <C-_> :cs find s <C-R>=expand("cword>")<CR><CR>

nmap <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-Space><C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" in normal mode F2 will save the file
nmap <F2> :w<CR>

"in insert mode, F2 will exit insert mode, save then re-enter insert mode
imap <F2> <ESC>:w<CR>i

"switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>

" goto definition with F12
map <F12> <C-]>


" in diff mode we use the spell check keys for merging
if &diff
    "diff settings
    set diffopt=filler      "add vertical spaces to allign text
    set diffopt+=iwhite     "ignore white spaces

    map <M-Down> ]c
    map <M-Up> [c
    map <M-Left> do
    map <M-Right> dp
"    map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
    " Use english for spellchecking, but don't spellcheck by default
    if version >= 700
        set spl=en spell
        set nospell
    endif
"    set spellfile=~/.vim/spellfile.add
    map <M-Down> ]s
    map <M-Up> [s
endif
