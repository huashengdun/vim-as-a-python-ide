" ============================================================================
" Vim-plug initialization

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
call plug#begin('~/.vim/plugged')

" plugins from github repos

" Colorschemes
Plug 'junegunn/seoul256.vim'
Plug 'huashengdun/wombat'

" Airlline for status lines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Lanuage syntax checker
Plug 'vim-syntastic/syntastic'

" Better file browser
Plug 'scrooloose/nerdtree'

" Class/module browser
Plug 'majutsushi/tagbar'

" Code and files fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'

" Zen coding
Plug 'mattn/emmet-vim'

" Surround
Plug 'tpope/vim-surround'

" Autoclose
Plug 'Townk/vim-autoclose'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" python auto completion
Plug 'davidhalter/jedi-vim'

" python virtualenv
Plug 'jmcantrell/vim-virtualenv'

" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" javascript syntax highlighting and improved indentation
Plug 'pangloss/vim-javascript'

" clang_complete
Plug 'Rip-Rip/clang_complete'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================

" Vim settings and mappings

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType c setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2

" html indent settings
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" strip trailing spaces on save
autocmd FileType python,javascript autocmd BufWritePre <buffer> %s/\s\+$//e
nmap <leader>r :%s/\s\+$//e\|w<CR>

" always show status bar
set laststatus=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line number
set number

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" tab navigation mappings
nmap tn :tabn<CR>
nmap tp :tabp<CR>
nmap tm :tabm
nmap tt :tabnew 
nmap ts :tab split<CR>
nmap <Tab> :tabn<CR>

" paste mode toggle
set pastetoggle=<F2>

" save as sudo
ca w!! w !sudo tee "%"


" ------------ colorscheme ----------------

let g:seoul256_background = 236
" colorscheme seoul256
colorscheme wombat


" function for adapting seoul256 background
function! Adapt_seoul256_background(value)
    " only for adapting seoul256 background
    if g:colors_name != "seoul256"
        return
    endif

    " make step as minimal as possible
    if a:value > 1
        let step = 1
    elseif a:value < -1
        let step = -1
    else
        let step = a:value
    endif
    " echo step

    " echo g:seoul256_background
    if g:seoul256_background == 233
        if step == -1
            let g:seoul256_background = 257
        endif
    elseif g:seoul256_background == 239
        if step == 1
            let g:seoul256_background = 251
        endif
    elseif g:seoul256_background == 252
        if step == -1
            let g:seoul256_background = 240
        endif
    elseif g:seoul256_background == 256
        if step == 1
            let g:seoul256_background = 232
        endif
    endif
    " echo g:seoul256_background

    " change seoul256 background and refresh
    let g:seoul256_background += step
    color seoul256
endfunction

" map keys for adapting seoul256 background
nmap <silent> <C-k> :call Adapt_seoul256_background(1)<CR>
nmap <silent> <C-j> :call Adapt_seoul256_background(-1)<CR>


" ---------------- Airline --------------------

" let g:airline_detect_paste=1
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'bubblegum'
" let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#tabline#enabled = 1


" ------------------- syntastic ----------------------

if has('python')
    let python_path = '/usr/bin/python'
else
    let python_path = '/usr/bin/python3'
endif

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = ['-m', 'flake8']
let g:syntastic_python_flake8_exec = python_path
let g:syntastic_javascript_checkers = ['jslint']
" :SyntasticInfo <language>


" ------------------ jedi-vim -----------------------

" almost no delay
let g:jedi#show_call_signatures_delay = 1
" use tabs instead of buffer
let g:jedi#use_tabs_not_buffers = 1
" no auto docstring preview window
autocmd FileType python setlocal completeopt-=preview


" -------------- vim-virtualenv --------------
let g:virtualenv_auto_activate = 1


" ---------------- NERDTree ------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" -------- Tagbar --------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1


" ------------------- CtrlP --------------------

" file finder mapping
let g:ctrlp_map = ',e'
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrlPMRUFiles<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$\|\.pyo$',
\ }


" ----------------------- Autoclose ----------------------------

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}


" ------------------------------ Signify --------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227


" ------------------------ clang_complete -------------------------------
let g:clang_library_path = '/usr/lib/x86_64-linux-gnu/libclang-3.8.so.1'
let g:clang_user_options = '-std=c++11'
" let g:clang_close_preview = 1
let g:clang_auto_select = 1
" let g:clang_complete_copen = 1
" let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
