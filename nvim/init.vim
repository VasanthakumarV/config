call plug#begin()
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
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
Plug 'ayu-theme/ayu-vim'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'hrsh7th/nvim-compe'
Plug 'sbdchd/neoformat'
call plug#end()

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

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

"nvim-tree toggle shortcut
nnoremap <C-n> :NvimTreeToggle<CR>

"nvim-compe to avoid 'Pattern not found'
set shortmess+=c

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
filetype plugin indent on
"usr_09.txt
set selectmode+=mouse
"For the theme
syntax on
set termguicolors
"Max line length
set colorcolumn=100
set hidden

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
set background=dark
let ayucolor="dark"
colorscheme ayu

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
nmap <C-p> :Files<CR>
"Ignore hidden files
let $FZF_DEFAULT_COMMAND = 'rg --files'

"tagbar
nmap <leader><leader>r :TagbarToggle<CR>

"Neoformat
nmap <space>f :Neoformat<CR>
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
