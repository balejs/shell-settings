set nocompatible

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'VundleVim/Vundle.vim'
"Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'davidhalter/jedi-vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf' " To get shell fzf goodies, run the install script from ~/.vim/bundle/fzf
Plug 'raimondi/delimitmate'
"Plug 'majutsushi/tagbar'
"Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-sleuth'
Plug 'normen/vim-pio'
Plug 'prabirshrestha/vim-lsp'

call plug#end()


"the following plugins are to be installed manually
"from https://github.com/normen/vim-pio, need vim-plug otherwise
:set rtp+=~/.vim/bundle/vim-pio
"https://github.com/prabirshrestha/vim-lsp.git
:set rtp+=~/.vim/bundle/vim-lsp

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

" visualize non-space whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" save system clipboard at exit
  autocmd VimLeave * call system("xsel -ib", getreg('+'))
endif

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
endif

" set colorcolumn=80,100
highlight ColorColumn ctermbg=DarkGray
set binary noendofline

"""""""""""""""""""""""""

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

" More key bindings for vim-lsp.
nn <silent> <M-d> :LspDefinition<cr>
nn <silent> <M-r> :LspReferences<cr>
nn <f2> :LspRename<cr>
nn <silent> <M-a> :LspWorkspaceSymbol<cr>
nn <silent> <M-l> :LspDocumentSymbol<cr>

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Register ccls C++ language server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
      \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

set expandtab
set softtabstop=4
