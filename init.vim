"" Jackie McGhee's .
"" Created: 10-Nov-2008

" Options for diff view
set diffopt=vertical,filler

" Switch off Vi ompatibility
set nocompatible

" vim-plug init
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'JulesWang/css.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'
call plug#end()

" JSX syntax without .JSX suffix
let g:jsx_ext_required=0

" Keep ALE gutter open
let g:ale_sign_column_always=1

" Auto format with Prettier: 
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Set encoding to UTF-8
set enc=utf-8

" Syntax highlighting
syntax on
set background=dark
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme gruvbox
if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Editor settings
set inccommand=nosplit
set path+=**
set hidden
set noshowmode
set wildmenu
set wildoptions=pum
set pumblend=10
" set wildmode=longest:full

" Editor text settings
set scrolloff=10
set clipboard=unnamed
set nowrap
set showmatch
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set noautoindent
set smartindent
set foldmethod=indent
" set foldcolumn=1
set foldlevel=4
set backspace=indent,eol,start

" Editor UI settings
set relativenumber
" set cursorcolumn
set colorcolumn=80
" hi colorcolumn guibg=#1a1a1a
" Gruvbox
hi colorcolumn guibg=#1d2021

" Statusline settings
" set statusline=
" set statusline+=\ %{fugitive#statusline()}
" set statusline+=\ \ \%t%m%r%h%w
" set statusline+=%=
" set statusline+=%{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ %y
" set statusline+=\ \[%{&fileformat}\]\ %p%%\ %l:%c\ 
" set ls=2

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" File system
set nobackup
set nowritebackup
set noswapfile
filetype plugin indent on

set rnu
set nu
set listchars=tab:▸\ ,eol:¬
set nolist
highlight NonText guifg=#cccccc
highlight SpecialKey guifg=#cccccc

"" COC stuff
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Leader settings and shortcuts
let mapleader="\\"
nnoremap <leader>e :e **/
nnoremap <leader>r :so ~/.config/nvim/init.vim<cr>
nnoremap <leader>i gg=G
nnoremap <leader>/ :noh<cr>
