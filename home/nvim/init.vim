lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_flags = {
	-- This will be the default in neovim 0.7+
	debounce_text_changes = 150,
}
for _, lsp in pairs({'pyright', 'tsserver'}) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = lsp_flags,
  }
end
require('lspconfig')['rust_analyzer'].setup {
	on_attach = on_attach,
    flags = lsp_flags,
	settings = {
		['rust-analyzer'] = {
			checkOnSave = {
				allTargets = false
			},
		}
	}
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- luasnip setup
local luasnip = require "luasnip"

-- nvim-cmp setup
local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"}
    }
}

-- lsp-signature
require "lsp_signature".setup()

-- tree-sitter
require "nvim-treesitter.configs".setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true
    },
    indent = {
        enable = true
    }
}

-- autopairs
require "nvim-autopairs".setup{}

-- colorscheme
require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})
vim.cmd("colorscheme nightfox")

require('nvim-tree').setup {
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}
EOF

set number
set relativenumber
set ignorecase
set noshowmode
"usr_05.txt from :help
set autoindent
set ruler
set showcmd
set incsearch
set hlsearch
set nolangremap
set mouse=a
"filetype plugin indent on
set selectmode+=mouse
"For the theme
syntax on
set hidden
"Set space count for tab
set tabstop=4
set shiftwidth=4
" highlight current line
set cursorline

"Cursor: changing shape in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

"Adding <space>a as an alt binding for <Esc>
nmap <leader>w :w<CR>
nnoremap <leader>a <Esc>
inoremap <leader>a <Esc>
vnoremap <leader>a <Esc>
snoremap <leader>a <Esc>
xnoremap <leader>a <Esc>
cnoremap <leader>a <Esc>
onoremap <leader>a <Esc>
lnoremap <leader>a <Esc>
tnoremap <leader>a <Esc>

"ColorScheme
set termguicolors

"GitGutter: reducing latency for symbols to appear
set updatetime=100

"FloatTerm: mappings for opening and toggling the terminal
tnoremap <Esc> <C-\><C-n>
let g:floaterm_keymap_new = '<leader><leader>o'
let g:floaterm_keymap_prev = '<leader><leader>p'
let g:floaterm_keymap_next = '<leader><leader>n'
let g:floaterm_keymap_toggle = '<leader><leader>t'
let g:floaterm_width=0.95

"File explorer: nvim tree lua
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

"vim-markdown avoid folding
let g:vim_markdown_folding_disabled = 1
"vim-markdown avoid hiding elements
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"VimSpector: Mapping for debugging
"VimSpector: conf ref: https://puremourning.github.io/vimspector-web/demo-setup.html
let g:vimspector_enable_mappings = 'HUMAN'
" for normal mode - the word under the cursor
nmap <leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <leader>di <Plug>VimspectorBalloonEval

"telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Neoformat
nmap <leader>f :Neoformat<CR>
let g:neoformat_enabled_python = ['black']

"easymotion
map  <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>b <Plug>(easymotion-bd-w)
nmap <Leader>b <Plug>(easymotion-overwin-w)
