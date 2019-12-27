set textwidth=80

set number
set ignorecase
set smartcase
set incsearch
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

" YOLO
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

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

" Open splits naturally
set splitbelow
set splitright

" Mouse support
set mouse=a

source /usr/share/doc/fzf/examples/fzf.vim

call plug#begin('~/.local/share/nvim/plugged')

Plug 'iCyMind/NeoSolarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'jreybert/vimagit'

Plug 'dag/vim-fish'

Plug 'pangloss/vim-javascript'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

Plug 'neomake/neomake'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'Shougo/denite.nvim'

Plug 'JCavallo/tryton-vim'

call plug#end()

syntax enable
set background=light
colorscheme NeoSolarized
let g:neosolarized_italic = 1

let g:airline_theme='solarized'
set noshowmode

" Hide fzf status bar
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
endif

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
    \ rg --column --line-number --no-heading --fixed-strings --follow --hidden --color=always --smart-case
    \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   g:rg_command .shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(),
  \   <bang>0)

" Same for Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nmap <C-p> :Files<Cr>
nmap <C-M-p> :Files <C-R>=expand('%:h')<Cr><Cr>
nmap <C-f> :Rg<Cr>
nmap <C-M-b> :Buffers<Cr>
nmap <C-M-h> :History<Cr>

let g:gitgutter_override_sign_column_highlight = 0

autocmd FileType fish compiler fish

if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

let g:deoplete#enable_at_startup = 1
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
