set textwidth=80

set ignorecase
set smartcase
set incsearch
set inccommand=split
set hlsearch
set encoding=utf-8
set fileencoding=utf8
set cursorline
set scrolloff=3
" Use system clipboard
set clipboard=unnamedplus

" Smart insert tab setting.
set smarttab
" Exchange tab to spaces.
set expandtab
" Substitute <Tab> with blanks.
set tabstop=4
" Spaces instead <Tab>.
set softtabstop=4
" Autoindent width.
set shiftwidth=4
" Round indent by shiftwidth.
set shiftround
" Enable smart indent.
set autoindent smartindent

let mapleader=" "

" YOLO
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

inoremap jj <ESC>

" Custom folding
set foldenable
set foldmethod=syntax
set foldlevelstart=1

" Fold on one line
function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction

set foldtext=CustomFoldText()

autocmd FileType javascript setlocal ts=2 sts=2 sw=2
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType pug setlocal ts=4 sts=4 sw=4 expandtab

" Open splits naturally
set splitbelow
set splitright

" Mouse support
set mouse=a

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'

Plug 'lifepillar/vim-solarized8'

" Plug 'christoomey/vim-tmux-navigator'
Plug 'knubie/vim-kitty-navigator'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-slash'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'jreybert/vimagit'

Plug 'easymotion/vim-easymotion'

Plug 'dag/vim-fish'

Plug 'pangloss/vim-javascript'
Plug 'stephpy/vim-yaml'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'jeetsukumaran/vim-pythonsense'

Plug 'neomake/neomake'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'Shougo/denite.nvim'

Plug 'JCavallo/tryton-vim'

Plug 'digitaltoad/vim-pug'
Plug 'dNitro/vim-pug-complete'

call plug#end()

set termguicolors
syntax on
set background=light
colorscheme solarized8_flat

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "[%{exists('g:loaded_fugitive') ? fugitive#head() : ''}] "
  let sep = ' %= '
  let pos = ' %(%l : %c%V%)'

  return fug.'%f %<'.mod.ro.ft.sep.pos
endfunction
let &statusline = s:statusline_expr()" set noshowmode

" Hide fzf status bar
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Preview for RipGrep
let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --follow --color=always --smart-case
    \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   g:rg_command .shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \   <bang>0)

" Same for Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nmap <C-p> :Files<CR>
nmap <C-M-p> :Files <C-R>=expand('%:h')<CR><CR>
nmap <C-f> :Rg<CR>
nmap <C-M-f> :Rg<C-R><C-W><CR>
nmap <C-M-b> :Buffers<CR>
nmap <C-M-h> :History<CR>
nmap <C-t> :Tags <C-R><C-W><CR>

let g:gitgutter_override_sign_column_highlight = 0

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Move to line

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

nnoremap <Leader>gs :G<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push mine HEAD<CR>
nnoremap <Leader>gP :Git pull origin HEAD<CR>
nnoremap <Leader>gk :Git branches<CR>

nmap <Leader>gh :diffget //2<CR>
nmap <Leader>gl :diffget //3<CR>

nnoremap <Leader>gv :GV!<CR>
nnoremap <Leader>gV :GV<CR>

autocmd FileType fish compiler fish

if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#ignore_errors = 1
let g:jedi#completions_enabled = 0

call neomake#configure#automake('nrw', 500)
let g:neomake_python_enabled_makers = ['flake8']

let g:tryton_default_mappings = 1
let g:tryton_trytond_path = "~/workspace/trytond"
let g:tryton_cache_dir = expand('~/.cache/unite/tryton')
let g:tryton_server_host_name = 'localhost'
let g:tryton_server_port = '8000'
let g:tryton_server_login = 'admin'
let g:tryton_server_password = 'admin'
let g:tryton_server_database = 'coog'
let g:tryton_model_match = {
    \ 'party': 'party.party',
    \ 'invoice': 'account.invoice',
    \ 'move': 'account.move',
    \ 'user': 'res.user',
    \ }

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType python,python.trpy,rst,xml,xml.trxml :call <SID>StripTrailingWhitespaces()
