syntax enable
set number 
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set nowrap
set clipboard=unnamedplus " Copy from / to system clipboard
autocmd BufEnter *.S setfiletype asm
autocmd BufEnter *.s setfiletype asm
autocmd BufEnter *.nim setfiletype nim

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Shougo/defx.nvim' 
Plug 'kassio/neoterm'
Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake'
Plug 'hrsh7th/nvim-compe'
Plug 'liuchengxu/vim-which-key'
Plug 'kevinhwang91/rnvimr'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'vlime/vlime'
Plug 'folke/tokyonight.nvim'
Plug 'romgrk/doom-one.vim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'tanvirtin/monokai.nvim'
Plug 'dracula/vim'

call plug#end()

" Colorscheme 
set termguicolors
"let g:tokyonight_transparent = 'true'
let g:tokyonight_style = "night"
colo tokyonight
"colo dracula

set timeoutlen=1000

luafile /home/tim/.config/nvim/lualine.lua
" lua block cause LSP and stuff
"
lua << EOF
-- this should really be a seperate file, but lazy

local dap = require('dap')

dap.adapters.python = {
      type = 'executable';
      command = '/usr/bin/python';
      args = { '-m', 'debugpy.adapter' };
    }

dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/usr/bin/python'
        end;
      },
    }

dap.adapters.lldb = {
    type = 'executable';
    command = '/usr/bin/lldb-vscode';
    name = "lldb";
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = true,
        signs = false,
        update_in_insert = false,
    }
)

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "jedi_language_server", "clangd", "hls", "nimls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF
" end lua block

" vlime leader
let g:vlime_leader = '<Space>m'

" Neomake Linters
let g:neomake_python_enabled_makers = ['pylint', 'python']
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_haskell_enabled_makers= ['hlint']

" Neoterm Config
set shell=/bin/zsh
let g:neoterm_default_mod='belowright' " position
let g:neoterm_size=16 " size
let g:neoterm_autoscroll=1
let g:neoterm_repl_python='ipython --no-autoindent'
let g:neoterm_repl_lisp='sbcl'

" virtual text debugging
let g:dap_virtual_text = v:true
" toggle the annoying highlighting after searching when pressing esc
nnoremap <silent> <esc> :noh<cr><esc>

" Keybindings
let g:mapleader = "\<Space>"
map <leader>n :Defx -split=vertical -winwidth=35 -direction=topleft -toggle<CR>
" window stuff
map <leader>w <C-w>
noremap <leader>qq :q!<CR>
noremap <leader>qa :qa!<CR>
nnoremap <leader>wd <C-w>q
nnoremap <leader>ot :Ttoggle<CR>
nnoremap <leader>oT :Tnew<CR>
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wo :only<CR>
inoremap <C-k> <ESC>
tnoremap <Esc> <C-\><C-n>


" REPL - Interaction for SPC r , works semi - well i guess
map <leader>or :TREPLSetTerm 1<CR>
map <leader>rf :TREPLSendFile<CR>
map <leader>rl :TREPLSendLine<CR>
map <leader>rs :TREPLSendSelection<CR>

" vim visual multi
let g:VM_leader = '<Space>e'

" Buffer - switching, deleting and the likes, also barbar config
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
"let bufferline.no_name_title = "Terminal"

nnoremap <leader>bn :BufferNext<CR>
nnoremap <silent> <TAB> :BufferNext<CR>
nnoremap <silent> <S-TAB> :BufferPrevious<CR>
nnoremap <leader>bp :BufferPrevious<CR>
nnoremap <leader>bd :BufferClose<CR>
nnoremap <leader>b1 :BufferGoto 1<CR>
nnoremap <leader>b2 :BufferGoto 2<CR>
nnoremap <leader>b3 :BufferGoto 3<CR>
nnoremap <leader>b4 :BufferGoto 4<CR>
nnoremap <leader>b5 :BufferGoto 5<CR>
nnoremap <leader>b6 :BufferGoto 6<CR>
nnoremap <leader>b7 :BufferGoto 7<CR>
nnoremap <leader>b8 :BufferGoto 8<CR>
nnoremap <leader>b9 :BufferGoto 9<CR>
nnoremap <leader>bs :BufferCloseAllButCurrent<CR>
nnoremap <leader>bp :BufferPick<CR>

"keybindings for insert mode movement , doesnt really work like i want it to
"inoremap <C-n> <ESC>ji
"inoremap <C-p> <ESC>ki
"inoremap <C-f> <ESC>li 
"inoremap <C-b> <ESC>hi 

" Basically everything with files for SPC F .
let g:rnvimr_enable_ex = 1
map <leader>ff :RnvimrToggle<CR> 
nnoremap <leader>fs :w<CR>

" Neomake execute
nmap <leader>pf :Neomake<CR>

" tagbar toggling
nmap <F2> :TagbarToggle<CR>
let g:tagbar_map_showproto = "w"  " honestly no idea why w but space annoys me cause leader stuff
" Stuff i yoinked from defx help
autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('preview')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_tree', 'toggle')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction

luafile /home/tim/.config/nvim/compe-config.lua
luafile /home/tim/.config/nvim/lua-lang.lua
" keybindings for debuggers
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dn :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>ds :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" Map arrow keys to resize Window
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

"Whichkey cause i have no clue what I'm actually doing here
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
