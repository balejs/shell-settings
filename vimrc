set nocompatible

filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'davidhalter/jedi-vim'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf' " To get shell fzf goodies, run the install script from ~/.vim/bundle/fzf
Plugin 'raimondi/delimitmate'
Plugin 'majutsushi/tagbar'
"Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-sleuth'

call vundle#end()            " required
filetype plugin indent on    " required

"source $HOME/.vim/plugins/cscope_maps.vim

syntax on
set hlsearch

" one-stroke write
nnoremap <S-w> :w!<cr>
" one-stroke exit and save
nnoremap <S-x> :xa!<cr>
" one-stroke exit no save
nnoremap <S-q> :qa!<cr>
" search multiple lines (fuzzy search?)
nnoremap <S-f> :BLines<cr>
" move to beginning of function
nnoremap <S-b> [m[{kk<cr>

nnoremap s<Space> :Csearch symbol:<C-R><C-W>$<CR><CR><cr>
map <C-t> :NERDTreeToggle<CR>
map <C-g> :YcmCompleter GoTo<CR>
map <C-d> :YcmCompleter GoToDefinition<CR>
map <C-l> :YcmCompleter GoToReferences<CR>
map <C-y> "+y
map <C-p> "+p

" visualize non-space whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" save system clipboard at exit
  autocmd VimLeave * call system("xsel -ib", getreg('+'))
endif

nmap <F8> :TagbarToggle<CR>
nmap <F9> :ccl<CR>

" set screen title to currently opened file
let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
if &term == "screen.xterm-256color"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen.xterm-256color" || &term == "xterm"
  set titlestring=VIM:%t
  set title
endif

if &diff
  colorscheme diff_colors
else
  "configure syntastic
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

"  let g:syntastic_always_populate_loc_list = 1
"  let g:syntastic_auto_loc_list = 1
"  let g:syntastic_check_on_open = 1
"  let g:syntastic_check_on_wq = 0
endif

" set colorcolumn=80,100
highlight ColorColumn ctermbg=DarkGray
set binary noendofline
