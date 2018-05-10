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
:command Term term ++curwin
set background=dark
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

" remaps
noremap <C-n> :NERDTreeToggle<CR>
" movement
noremap <C-e> <esc>$
noremap <C-a> <esc>0
inoremap <C-e> <esc><S-a>
inoremap <C-a> <esc><S-i>
" remap ctrl-c to esc to get abbreviation finishing functionality
inoremap <C-c> <esc>
" tab remaps
nnoremap <C-i> <C-\><C-n>gT:call InsertOnTerm()<CR>
nnoremap <C-o> <C-\><C-n>gt:call InsertOnTerm()<CR>
tnoremap <C-i> <C-\><C-n>gT<CR>
tnoremap <C-o> <C-\><C-n>gt<CR>
nnoremap <C-t> :tabnew<CR>
tnoremap <C-t> <C-\><C-n>:tabnew<CR>
" quit remap
tnoremap <c-f> <c-w><c-c>
"nnoremap :q :call ForceQuitIfTerm()
" window remaps
nnoremap <C-g> :vsplit<CR>
nnoremap <C-b> :split<CR>
nnoremap <C-k> <C-W>k<CR>
nnoremap <C-j> <C-W>j<CR>
nnoremap <C-h> <C-W>h<CR>k
nnoremap <C-l> <C-W>l<CR>k
inoremap <C-j> <C-c><C-W>k
inoremap <C-k> <C-c><C-W>j
inoremap <C-h> <C-c><C-W>h
inoremap <C-l> <C-c><C-W>l

"" syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_w = 0
"let g:syntastic_toggle_mode = {"mode": "passive", "active_filetypes": []}
""let g:syntastic_quiet_messages = {"type": "syntax"}
"let g:syntastic_cpp_cpplint_exec = "cpplint"
