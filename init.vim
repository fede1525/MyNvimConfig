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
set cursorline
set mouse=a
set ttyfast
set termguicolors
set encoding=UTF-8
cd C:\
filetype plugin on 
syntax on 
let mapleader = ";" 

call plug#begin()

Plug 'nvim-lua/plenary.nvim' " Plenary
Plug 'BurntSushi/ripgrep' " Ripgrep 
Plug 'sharkdp/fd' " Find
Plug 'preservim/nerdtree' " Nerd Tree
Plug 'nvim-treesitter/nvim-treesitter' " Tree sitter

" Color schemes
Plug 'kepano/flexoki-neovim'
Plug 'savq/melange-nvim'

Plug 'vim-airline/vim-airline' " Vim-airline
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'tpope/vim-fugitive' " Fugitive
Plug 'nvim-telescope/telescope.nvim' " Telescope
Plug 'ixru/nvim-markdown' " Markdown 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " Markdown preview

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lua' 
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'  
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'jose-elias-alvarez/null-ls.nvim' 

Plug 'm4xshen/autoclose.nvim' " Autoclose brackets
Plug 'MunifTanjim/prettier.nvim' " Prettier
Plug 'ryanoasis/vim-devicons' " Dev icons
Plug 'lambdalisue/glyph-palette.vim' " Icon colors 

call plug#end()

let g:airline_theme= 'distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:prettier#autoformat = 1
let g:prettier#config#trailing_comma = 'none'
colorscheme melange 

" Glyph config
augroup my-glyph-palette
  autocmd! *
  autocmd FileType nerdtree call glyph_palette#apply()
augroup END

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

" Telescope config
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:telescope_find_files_recursive = 1

" NerdTree config
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Icons 
let g:glyph_palette#palette = {
\ 'GlyphPalette1': [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPalette2': ['', ' ', ' ', ' ', ' ', ' ', '󰡄 ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPalette3': ['λ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', '', '', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPalette4': [' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPalette6': [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPalette7': [' ', ' ', ' ', ' ', ' ', ' ', ' ',
\ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '] ,
\ 'GlyphPalette9': [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
\ 'GlyphPaletteDirectory': [' ', ' ', ' ', ' ', ' ', ' '],}




" LUA Configurations

lua << EOF
require("mason").setup()
require("telescope").setup()
require("autoclose").setup()

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
      --  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
     -- completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, 
      { name = 'luasnip' }, 
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')
  local servers = {
  	'clangd',
	'asm_lsp',
	'cssls',
  	'eslint',
  	'html',
  	'lua_ls',
  	'pyright',
  	'rust_analyzer',
  	'tsserver',
  	'zls'
}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

	  end
})

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end

-- Prettier
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

EOF

