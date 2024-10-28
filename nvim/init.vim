" Instala vim-plug automáticamente si no está ya instalado
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
    silent !curl -fLo plug_path --create-dirs
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Inicia vim-plug
call plug#begin('~/.config/nvim/plugged')

" Plugins esenciales para la interfaz
Plug 'nvim-lua/plenary.nvim'                      " Funciones Lua compartidas
Plug 'kyazdani42/nvim-tree.lua'                   " Explorador de archivos
Plug 'nvim-telescope/telescope.nvim'              " Búsqueda avanzada
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Resaltado avanzado
Plug 'nvim-lualine/lualine.nvim'                  " Barra de estado
Plug 'folke/tokyonight.nvim'                      " Tema Tokyonight
Plug 'akinsho/bufferline.nvim'                    " Bufferline para cambiar entre archivos

" Plugins para desarrollo en C/C++
Plug 'neovim/nvim-lspconfig'                      " Configuración de LSP
Plug 'hrsh7th/nvim-cmp'                           " Autocompletado
Plug 'hrsh7th/cmp-nvim-lsp'                       " Fuente LSP para nvim-cmp
Plug 'L3MON4D3/LuaSnip'                           " Snippets
Plug 'saadparwaiz1/cmp_luasnip'                   " Integración de Luasnip con nvim-cmp
Plug 'mfussenegger/nvim-dap'                      " Depuración
Plug 'rcarriga/nvim-dap-ui'                       " Interfaz de usuario para DAP
Plug 'nvim-neotest/nvim-nio'                      " Requisito para nvim-dap-ui
Plug 'lewis6991/gitsigns.nvim'                    " Integración con Git

call plug#end()

" Opciones generales de Neovim
set number
set relativenumber
set mouse=a
set clipboard=unnamedplus
set splitright
set splitbelow
set nowrap
set termguicolors
colorscheme tokyonight

" Función Lua para mostrar el dashboard personalizado
lua << EOF
function _G.custom_dashboard()
    -- Borra cualquier buffer abierto y configura el entorno
    vim.cmd("enew")                       -- Abre un nuevo buffer
    vim.cmd("setlocal buftype=nofile")    -- Marca el buffer como no editable
    vim.cmd("setlocal nobuflisted")       -- Evita que el buffer aparezca en la lista de buffers
    vim.cmd("setlocal noswapfile")        -- Desactiva el archivo swap

    -- Contenido del banner
    local banner = {
        '▒███████▒ ██▓    ',
        '▒ ▒ ▒ ▄▀░▓██▒    ',
        '░ ▒ ▄▀▒░ ▒██░    ',
        '  ▄▀▒   ░▒██░    ',
        '▒███████▒░██████▒',
        '░▒▒ ▓░▒░▒░ ▒░▓  ░',
        '░░▒ ▒ ░ ▒░ ░ ▒  ░',
        '░ ░ ░ ░ ░  ░ ░    ',
        '  ░ ░        ░  ░',
        '░                 ',
    }

    -- Muestra el banner en el buffer
    for _, line in ipairs(banner) do
        vim.api.nvim_buf_set_lines(0, -1, -1, false, { line })
    end

    -- Opciones del menú de inicio
    local menu = {
        "",
        " [F]   ->  Buscar archivo",
        " [R]   ->  Archivos recientes",
        " [S]   ->  Configuración de Neovim",
        " [Q]   ->  Salir de Neovim",
        "",
        "Bienvenido a Z43L - entorno de desarrollo en C/C++",
    }

    -- Muestra las opciones en el buffer
    vim.api.nvim_buf_set_lines(0, -1, -1, false, menu)

    -- Mapeos para los accesos rápidos del menú
    vim.api.nvim_buf_set_keymap(0, "n", "F", ":Telescope find_files<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "R", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "S", ":e ~/.config/nvim/init.vim<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "Q", ":qa<CR>", { noremap = true, silent = true })
end
EOF

" Llama al dashboard solo cuando no hay archivos en el arranque
autocmd VimEnter * lua if vim.fn.argc() == 0 then _G.custom_dashboard() end

" Barra de estado personalizada
lua << EOF
require('lualine').setup {
    options = { theme = 'tokyonight' }
}
EOF

" Configuración de Bufferline
lua << EOF
require("bufferline").setup{}
EOF

" Configuración de Nvim-Tree
lua << EOF
require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    view = { width = 30, side = 'left' },
})
EOF

" Configuración de Telescope
lua << EOF
require('telescope').setup({
    defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➜ ",
        layout_config = { width = 0.9 },
    },
})
EOF

" Configuración de Treesitter para mejorar la sintaxis y el análisis de código
lua << EOF
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "lua" },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
})
EOF

" Configuración de LSP para C/C++ con Clangd
lua << EOF
require('lspconfig').clangd.setup{}
EOF

" Configuración de Autocompletado
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
        { name = 'luasnip' }
    }),
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
})
EOF

" Configuración de DAP (Depuración)
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

" Configuración de Gitsigns (Integración con Git)
lua << EOF
require('gitsigns').setup()
EOF

" Mapeos de Teclas
nnoremap <leader>w :w<CR>         " Guardar
nnoremap <leader>q :q<CR>         " Cerrar
nnoremap <leader>e :NvimTreeToggle<CR>  " Árbol de archivos
nnoremap <leader>bp :BufferLinePick<CR>  " Seleccionar buffer
nnoremap <leader>bd :BufferLinePickClose<CR> " Cerrar buffer seleccionado

" Mapeos de movimiento entre ventanas
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Mapeos para Telescope
nnoremap <leader>ff :Telescope find_files<CR>     " Buscar archivos
nnoremap <leader>fg :Telescope live_grep<CR>      " Buscar texto en archivos
nnoremap <leader>fb :Telescope buffers<CR>        " Ver buffers abiertos
nnoremap <leader>fh :Telescope help_tags<CR>      " Ayuda

" Mapeos para DAP (Depuración)
nnoremap <F5> :lua require("dap").continue()<CR>            " Continuar depuración
nnoremap <F10> :lua require("dap").step_over()<CR>          " Paso por encima
nnoremap <F11> :lua require("dap").step_into()<CR>          " Paso a paso
nnoremap <F12> :lua require("dap").step_out()<CR>           " Salir del paso
nnoremap <leader>db :lua require("dap").toggle_breakpoint()<CR>  " Punto de interrupción
nnoremap <leader>dr :lua require("dap").repl.open()<CR>     " Abrir REPL para DAP

