-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Minimum lsps we want installed
lsp.ensure_installed({
	'tsserver',
	'eslint',
	'sumneko_lua',
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
