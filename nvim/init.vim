call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'puremourning/vimspector'
Plug 'yggdroot/indentline'
Plug 'tanvirtin/monokai.nvim'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'yamatsum/nvim-cursorline', { 'branch': 'main' }
Plug 'sbdchd/neoformat'
Plug 'nvim-lua/plenary.nvim'
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/vim-vsnip'
call plug#end()

lua << EOF
local monokai = require('monokai')
local palette = monokai.pro
monokai.setup {
	custom_hlgroups = {
		SpecialComment = {
            fg = palette.orange,
			style = 'italic',
        },
	}
}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pylsp", "rust_analyzer" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { 
		on_attach = on_attach, 
		settings = {
			["rust-analyzer"] = {
				checkOnSave = "clippy"
			},
			pylsp = {
				plugins = {
					pycodestyle = {
						maxLineLength = 100
					}
				}
			}
		}
	}
end
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
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

"nerd-tree
nnoremap <C-n> :NERDTreeToggle<CR>

"ColorScheme
set termguicolors
set background=dark
colorscheme monokai_pro

"GitGutter: reducing latency for symbols to appear
set updatetime=100

"FloatTerm: mappings for opening and toggling the terminal
tnoremap <Esc> <C-\><C-n>
let g:floaterm_keymap_new = '<leader><leader>o'
let g:floaterm_keymap_prev = '<leader><leader>p'
let g:floaterm_keymap_next = '<leader><leader>n'
let g:floaterm_keymap_toggle = '<leader><leader>t'
let g:floaterm_width=0.95

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

"fzf: setting key map
nmap <leader>g :Files<CR>
"Ignore hidden files
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

"tagbar
nmap <leader><leader>r :TagbarToggle<CR>

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
