"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                             "
" This vimrc file is meant to provide the absolute minimum to make your life  "
" easier when using vim without concealing any of the default functionality   "
" This way you won't loose touch with vim's commands while at the same time   "
" you'll be boosting your productivity                                        "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme ron

if has("syntax")
	syn on	" turn syntax on
	set hlsearch
endif

""""""""""""""
"" Indentation
""

" tw: legacy width for optimal readability
set textwidth=80

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

    " last-position-jump
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \|exe "normal! g`\"" | endif
endif


" ts: the width of a hard tabstop measured in spaces
" effectively this will make the actual tab character to appear as N spaces
" set tabstop=8 " 8 default
set tabstop=4 

" sw: the size of an indent
set shiftwidth=4

" et: insert $(sw) number of spaces on tab press
" To insert a real tab when 'expandtab' is "on, use CTRL-V<Tab>
" :[range]ret[ab][!] [new_tabstop] retab will replace tab characters with
" $(ts) number of spaces when expandtab is set
set expandtab

" sts: case < ts use combo of tabs and spaces to indent
"      case = ts use only tabs to indengt
"      ! only matters when expandtab is not set
" set softtabstop=0 " 0 default

" sta: <BS> will delete a sw worth of space at the start of the line
set smarttab

" paste: Paste text exactly as it is on clipboard without any formatting
" this prohibits vim from commenting every line under a commented line
" set paste


""""""""""""
"" Searching
""

" Setting ignorecase along with smartcase will allow you to search
" case insensitive when all letter are small and case sensitive in
" any othercase

" ic: will search case insensitive
set ignorecase

" scs: will search case insensitive unless there a capital letter in search
set smartcase

" show search matches as you type
set incsearch


"""""""""""
"" Mappings 
""

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"""""""
"" Refs
""

" https://github.com/nvie/vimrc/blob/master/vimrc#L24
