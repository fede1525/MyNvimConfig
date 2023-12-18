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

Plug 'https://github.com/nvim-treesitter/nvim-treesitter' " Tree sitter
Plug 'https://github.com/kepano/flexoki-neovim' " Color scheme
Plug 'https://github.com/preservim/nerdtree' " Nerd Tree
Plug 'https://github.com/ryanoasis/vim-devicons' " Dev icons
Plug 'https://github.com/vim-airline/vim-airline' " Vim-airline
Plug 'https://github.com/vim-airline/vim-airline-themes' " Airline themes
Plug 'https://github.com/tpope/vim-fugitive' " Fugitive
Plug 'https://github.com/nvim-telescope/telescope.nvim' " Telescope
Plug 'https://github.com/BurntSushi/ripgrep' " Ripgrep 
Plug 'https://github.com/sharkdp/fd' " Find
Plug 'williamboman/mason.nvim' " Mason
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'https://github.com/neovim/nvim-lspconfig' " LSP
Plug 'https://github.com/sheerun/vim-polyglot' " Language pack
Plug 'https://github.com/mfussenegger/nvim-dap'
Plug 'https://github.com/rcarriga/nvim-dap-ui'
Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim' " Linter
Plug 'https://github.com/ms-jpq/coq_nvim', {'branch': 'coq'} " Code completion
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " Snippets
Plug 'https://github.com/MunifTanjim/prettier.nvim' " Prettier
Plug 'https://github.com/nvim-lua/plenary.nvim' " Plenary
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " Md preview

call plug#end()

let g:airline_theme= 'distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:prettier#autoformat = 1
let g:prettier#config#trailing_comma = 'none'
let g:markdown_preview_browser = 'firefox'
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

