### Plugins Esenciales para la Interfaz

---

| Plugin                                | Descripción                                                    | Comando/Atajo                             |
|---------------------------------------|----------------------------------------------------------------|-------------------------------------------|
| `plenary.nvim`                        | Librería de funciones en Lua usadas por otros plugins.         | No requiere comandos específicos          |
| `nvim-tree.lua`                       | Explorador de archivos en un panel lateral.                    | `:NvimTreeToggle`, `<leader>e`            |
| `telescope.nvim`                      | Búsqueda avanzada de archivos y contenido.                     | `:Telescope find_files`, `<leader>ff` para buscar archivos, `<leader>fg` para buscar texto, `<leader>fb` ver buffers abiertos |
| `nvim-treesitter`                     | Resaltado de sintaxis avanzado y plegado de código.            | Instalación automática con `:TSUpdate`    |
| `lualine.nvim`                        | Barra de estado personalizable con información del archivo.    | Se muestra automáticamente al instalar    |
| `tokyonight.nvim`                     | Tema de color que mejora la apariencia de Neovim.              | `colorscheme tokyonight` en `init.vim`    |
| `bufferline.nvim`                     | Barra de buffers para cambiar entre archivos.                  | Automático, `:BufferLinePick` para seleccionar buffer, `<leader>bp` para abrir buffer, `<leader>bd` para cerrar buffer |
| `Comment.nvim`                        | Comentar/descomentar líneas de forma rápida.                   | `gc` para comentar/descomentar líneas     |
| `auto-pairs`                          | Emparejamiento automático de paréntesis, llaves, etc.          | Funciona automáticamente                  |
| `nvim-surround`                       | Añadir, cambiar o quitar caracteres envolventes (paréntesis, comillas). | `ysiw)` para añadir paréntesis, `ds)` para quitar |
| `hop.nvim`                            | Navegación rápida en el archivo.                               | `:HopWord` para saltar a una palabra      |
| `neorg`                               | Herramienta de toma de notas en formato Markdown.              | `:Neorg workspace <nombre>`               |
| `trouble.nvim`                        | Muestra errores y advertencias en una ventana lateral.         | `:TroubleToggle`                          |
| `lspsaga.nvim`                        | Mejora la interfaz LSP para ver errores, documentación y acciones. | `:Lspsaga show_line_diagnostics` para errores, `:Lspsaga lsp_finder` para ir a la definición |
| `which-key.nvim`                      | Muestra un menú de combinaciones de teclas.                    | Presiona `<leader>` y espera unos segundos |
| `markdown-preview.nvim`               | Vista previa de archivos Markdown en el navegador.             | `:MarkdownPreview`                        |

---

### Plugins para Desarrollo en C/C++

---

| Plugin                                | Descripción                                                    | Comando/Atajo                             |
|---------------------------------------|----------------------------------------------------------------|-------------------------------------------|
| `nvim-lspconfig`                      | Configura el servidor de lenguaje para resaltado y sugerencias.| Se configura en `init.vim`                |
| `nvim-cmp`                            | Sistema de autocompletado flexible.                            | Funciona automáticamente                  |
| `cmp-nvim-lsp`                        | Fuente de autocompletado LSP para `nvim-cmp`.                  | Configuración automática                  |
| `LuaSnip`                             | Sistema de snippets para insertar fragmentos de código.        | Configuración automática                  |
| `cmp_luasnip`                         | Integración de LuaSnip con `nvim-cmp`.                         | Configuración automática                  |
| `nvim-dap`                            | Depurador para C/C++ con capacidades de punto de interrupción. | `<F5>` continuar depuración, `<F10>` paso por encima, `<F11>` paso a paso, `<F12>` salir de la función |
| `nvim-dap-ui`                         | Interfaz de usuario para el depurador DAP.                     | `:DapUiToggle`, `<leader>db` para punto de interrupción, `<leader>dr` para abrir REPL |
| `nvim-nio`                            | Requisito para `nvim-dap-ui`.                                  | No requiere comandos adicionales          |
| `gitsigns.nvim`                       | Integración con Git para mostrar cambios en el margen izquierdo.| Cambios visibles automáticamente          |

---

### Resumen Rápido de Comandos y Atajos

---

| Función                               | Comando/Atajo                             |
|---------------------------------------|-------------------------------------------|
| **Abrir Nvim-Tree**                   | `:NvimTreeToggle`, `<leader>e`            |
| **Guardar archivo**                   | `<leader>w`                               |
| **Cerrar archivo**                    | `<leader>q`                               |
| **Navegar entre ventanas**            | `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`        |
| **Buscar archivo (Telescope)**        | `:Telescope find_files`, `<leader>ff`     |
| **Buscar texto en archivos**          | `<leader>fg`                              |
| **Ver buffers abiertos**              | `<leader>fb`                              |
| **Ver ayuda de Neovim**               | `<leader>fh`                              |
| **Ver errores (Trouble)**             | `:TroubleToggle`                          |
| **Ir a definición (LSP)**             | `:Lspsaga lsp_finder`                     |
| **Mostrar errores LSP (Lspsaga)**     | `:Lspsaga show_line_diagnostics`          |
| **Comentarios (Comment.nvim)**        | `gc` para comentar, `gc` para descomentar |
| **Vista previa de Markdown**          | `:MarkdownPreview`                        |
| **Depuración (DAP)**                  | `<F5>` continuar, `<F10>` paso, `<F11>` entrar, `<F12>` salir, `<leader>db` punto de interrupción, `<leader>dr` REPL |
