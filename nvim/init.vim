let mapleader = " "

" Instala vim-plug automáticamente
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  silent !curl -fLo plug_path --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Plugins esenciales
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'kylechui/nvim-surround'
Plug 'phaazon/hop.nvim'
Plug 'nvim-neorg/neorg'
Plug 'folke/trouble.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/which-key.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

" Plugins para desarrollo en C/C++
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-neotest/nvim-nio'
Plug 'lewis6991/gitsigns.nvim'

" Plugins para Desarrollo Web (JavaScript, HTML, CSS)
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'
Plug 'mattn/emmet-vim'

" Plugins Específicos para Frameworks

" React / React Native
Plug 'git@github.com:leafOfTree/vim-javascript-refactor.git' " Usando SSH
Plug 'pantharshit00/vim-prisma', {'for': 'typescriptreact'} "Opcional, Si trabajas con Prisma
Plug 'jparise/vim-graphql', {'for': ['graphql', 'typescriptreact', 'javascriptreact']} "Opcional, resaltado de sintaxis para GraphQL.

" Angular
" Plug 'pmv-soft/typescript-tools.nvim'  " TypeScript Tools (reemplaza tsserver)  COMENTADO TEMPORALMENTE


call plug#end()

" --- Configuraciones Generales ---
set number
set relativenumber
set mouse=a
set clipboard=unnamedplus  " Intenta usar el portapapeles del sistema
set splitright
set splitbelow
set nowrap
set termguicolors
colorscheme tokyonight

" --- Funciones Lua ---
lua << EOF
function _G.custom_dashboard()
  vim.cmd("enew")
  vim.cmd("setlocal buftype=nofile")
  vim.cmd("setlocal nobuflisted")
  vim.cmd("setlocal noswapfile")

  local banner = {
    '▒███████▒ ██▓     ',
    '▒ ▒ ▒ ▄▀░▓██▒     ',
    '░ ▒ ▄▀▒░ ▒██░     ',
    '  ▄▀▒   ░▒██░     ',
    '▒███████▒░██████▒',
    '░▒▒ ▓░▒░▒░ ▒░▓  ░',
    '░░▒ ▒ ░ ▒░ ░ ▒  ░',
    '░ ░ ░ ░ ░  ░ ░    ',
    '  ░ ░      ░  ░',
    '░               ',
  }
  for _, line in ipairs(banner) do
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { line })
  end

  local menu = {
    "",
    " [F]  ->  Buscar archivo",
    " [R]  ->  Archivos recientes",
    " [S]  ->  Configuración de Neovim",
    " [Q]  ->  Salir de Neovim",
    "",
    "Bienvenido a Z43L - entorno de desarrollo en C/C++, React, React Native y Angular",
  }
  vim.api.nvim_buf_set_lines(0, -1, -1, false, menu)

  vim.api.nvim_buf_set_keymap(0, "n", "F", ":Telescope find_files<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "R", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "S", ":e ~/.config/nvim/init.vim<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "Q", ":qa<CR>", { noremap = true, silent = true })
end
EOF

autocmd VimEnter * lua if vim.fn.argc() == 0 then _G.custom_dashboard() end

lua << EOF
require('lualine').setup {
  options = { theme = 'tokyonight' }
}
EOF

lua << EOF
require("bufferline").setup{}
EOF

lua << EOF
require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  view = { width = 30, side = 'left' },
})
EOF

lua << EOF
require('telescope').setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "➜ ",
    layout_config = { width = 0.9 },
  },
})
EOF

" --- Configuración de Treesitter ---
lua << EOF
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "lua", "javascript", "typescript", "html", "css", "tsx", "jsx", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  }
})
EOF



" --- Configuración de LSP (TypeScript Tools y clangd) ---
lua << EOF
require('lspconfig').clangd.setup{}

--[[ COMENTADO TEMPORALMENTE
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('typescript-tools').setup {
    on_attach = function(_, bufnr)
         --  No hay configuración on_attach para el formateo si usas Prettier
    end,
    capabilities = capabilities,
    settings = {
      tsserver_locale = "en", -- o "es-ES"
    }
 }
 --]]

 --Opcional, si usas angular y quieres usar angular language server
 require('lspconfig').angularls.setup{}
EOF

" --- Configuración de Autocompletado ---
lua << EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  }),
 mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
	['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
   formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function (entry, vim_item)
                return vim_item
            end
        })
    }
})
EOF

lua << EOF
require('Comment').setup()
EOF

" --- Configuración de DAP (Depuración - Sin cambios, solo para C/C++) ---
lua << EOF
local dap = require('dap')
local dapui = require('dapui')
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF

lua << EOF
local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/ruta/al/directorio/cpptools/extension/debugAdapters/bin/OpenDebugAD7', -- ¡Asegúrate de que esta ruta sea correcta!
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local dbg_files = vim.fn.glob(cwd .. '/*.dbg', false, true)
      if #dbg_files > 0 then
        return dbg_files[1]
      else
        return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
      end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}
dap.configurations.c = dap.configurations.cpp
EOF

lua << EOF
require('hop').setup()
EOF

" --- Mapeos de Teclas ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>bp :BufferLinePick<CR>
nnoremap <leader>bd :BufferLinePickClose<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

nnoremap <F5> :lua require("dap").continue()<CR>
nnoremap <F10> :lua require("dap").step_over()<CR>
nnoremap <F11> :lua require("dap").step_into()<CR>
nnoremap <F12> :lua require("dap").step_out()<CR>
nnoremap <leader>db :lua require("dap").toggle_breakpoint()<CR>
nnoremap <leader>dr :lua require("dap").repl.open()<CR>

" --- Configuración de Prettier ---
lua << EOF
require("prettier").setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
   cli_options = {
     print_width = 100,
     tab_width = 2,
     use_tabs = false,
     semi = true,
     single_quote = true,
   },
});

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.scss", "*.html", "*.json", "*.md" },
  callback = function()
    vim.cmd("Prettier")
  end,
})
EOF

" --- Configuración de null-ls (para ESLint) ---
lua << EOF
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({'.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json'})
      end
    }),
  },
})
EOF

" --- Configuraciones específicas para React ---

lua << EOF
-- Mapeos de teclas para JSX (opcional)
vim.api.nvim_set_keymap('n', '<leader>cx', '"+ygv"=p', { noremap = true, silent = true }) -- Copiar y pegar como JSX

-- Configuración de Emmet para JSX
vim.g.user_emmet_settings = {
  javascript = {
    extends = 'jsx', -- Habilita Emmet para JSX
  },
}
EOF

" Configuracion del portapapeles para WSL
if executable('win32yank.exe')
  let g:clipboard = {
  \   'name': 'win32yank-wsl',
  \   'copy': {
  \      '+': 'win32yank.exe -i --crlf',
  \      '*': 'win32yank.exe -i --crlf',
  \    },
  \   'paste': {
  \      '+': 'win32yank.exe -o --lf',
  \      '*': 'win32yank.exe -o --lf',
  \   },
  \   'cache_enabled': 1,
  \ }
endif
