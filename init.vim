set nocompatible
set showmatch
set showcmd
set hlsearch
set incsearch
set tabstop=4
set shiftwidth=4
set number
set ruler
set relativenumber
set wildmode=longest,list
set cc=90
set cursorline
set mouse=a
set ttyfast
set encoding=UTF-8
filetype plugin on 
syntax on

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter' " Tree sitter
Plug 'kepano/flexoki-neovim' " Color scheme
Plug 'preservim/nerdtree' " Nerd Tree
Plug 'ryanoasis/vim-devicons' " Dev icons
Plug 'vim-airline/vim-airline' " Vim-airline
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'tpope/vim-fugitive' " Fugitive
Plug 'nvim-telescope/telescope.nvim' " Telescope
Plug 'BurntSushi/ripgrep' " Ripgrep 
Plug 'sharkdp/fd' " Find
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'jose-elias-alvarez/null-ls.nvim' " Linter
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " Code completion
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " Snippets
Plug 'MunifTanjim/prettier.nvim' " Prettier
Plug 'nvim-lua/plenary.nvim' " Plenary

call plug#end()

let g:airline_theme= 'distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:prettier#autoformat = 1
let g:prettier#config#trailing_comma = 'none'
colorscheme flexoki-dark

let mapleader = ";" " Re-map leader key to => ;

" Terminal function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

map tv :lcd %:p:h<CR>:vs<CR><C-w><C-w>:set nonu<CR>:te<CR>i
map th :lcd %:p:h<CR>:sp<CR><C-w><C-w>:set nonu<CR>:te<CR>i
" Terminal function end

" Telescope config
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:telescope_find_files_recursive = 1
" Telescope end

