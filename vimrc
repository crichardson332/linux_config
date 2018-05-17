let g:solarized_termtrans=1
filetype on
filetype plugin indent on
syntax enable
" pathogen
execute pathogen#infect()
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set hls!
:set ruler
:set number
" Set xml syntax highlighting for ros 
autocmd bufread *.launch exe "setf xml"
":set nohlsearch

" Functions to see a diff from the last save inside of vim
:command Diff w !diff % - 
:command Tkdiff w !tkdiff % /dev/stdin
:command Fold setlocal foldmethod=syntax
:command Sign %s/@author.*/@author Christopher Richardson <christopher.richardson@gtri.gatech.edu>
set background=dark
"set background=light
colorscheme solarized

"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

"autocmd vimenter * Fold
"autocmd vimenter * NERDTree | wincmd p
"autocmd vimenter * NERDTree
" close vim if NERDTree is the only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctrlp
"set runtimepath^=~/.vim/bundle/ctrlp.vim

" term functions
function InsertOnTerm()
  if index(term_list(),bufnr('%')) != -1
    normal i
    normal :
  endif 
endfunction

function ForceQuitIfTerm()
  if index(term_list(),bufnr('%')) != -1
    quit!
  else
    quit
  endif 
endfunction

:command Term term ++curwin
:command NTerm tabnew | Term
:command D bp|bd #

" remaps
noremap <c-n> :NERDTreeToggle<CR>

" un-mapping NERDTree maps that conflict
let g:NERDTreeMapJumpNextSibling="☻"
let g:NERDTreeMapJumpPrevSibling="☺"

" movement
noremap <c-e> <esc>$
noremap <c-a> <esc>0
inoremap <c-e> <esc><S-a>
inoremap <c-a> <esc><S-i>
" remap ctrl-c to esc to get abbreviation finishing functionality
inoremap <c-c> <esc>
" tab remaps
nnoremap <c-f> <c-p>
"nnoremap <c-j> <c-\><c-n>gT:call InsertOnTerm()<CR>
"nnoremap <c-k> <c-\><c-n>gt:call InsertOnTerm()<CR>
"tnoremap <c-j> <c-\><c-n>gTk:call InsertOnTerm()<CR>
"tnoremap <c-k> <c-\><c-n>gtk:call InsertOnTerm()<CR>
nnoremap <c-t> :tabnew<CR>
tnoremap <c-t> <c-\><c-n>:tabnew<CR>
" quit remap
"tnoremap <c-q> <c-w><c-c>
" window remaps
nnoremap <c-g> :vsplit<CR>
nnoremap <c-b> :split<CR>
nnoremap <c-k> <c-W>k<CR>
nnoremap <c-j> <c-W>j<CR>
nnoremap <c-h> <c-W>h<CR>k
nnoremap <c-l> <c-W>l<CR>k
inoremap <c-j> <c-c><c-W>k
inoremap <c-k> <c-c><c-W>j
inoremap <c-h> <c-c><c-W>h
inoremap <c-l> <c-c><c-W>l
" buffer cycling
nnoremap <c-i> :bprev<CR>
nnoremap <c-o> :bnext<CR>

" bufferline settings
let g:bufferline_echo = 0
autocmd VimEnter *
    \ let &statusline='%{bufferline#refresh_status()}' . bufferline#get_status_string()
set laststatus=2

"" syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
""
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_w = 1
"let g:syntastic_cpp_remove_include_errors = 0
""let g:syntastic_toggle_mode = {"mode": "passive", "active_filetypes": []}
"""let g:syntastic_quiet_messages = {"type": "syntax"}
"let g:syntastic_cpp_cpplint_exec = "cpplint"
"let g:syntastic_debug = 0
"let g:syntastic_cpp_compiler = "g++"
"let g:syntastic_cpp_compiler_options="-std=c++14 -stdlib=libc++"
