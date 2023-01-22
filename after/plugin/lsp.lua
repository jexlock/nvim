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

-- Completion Settings 
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] =  cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] =  cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] =  cmp.mapping.confirm({select = true }),
	['<C-Space>'] =  cmp.mapping.complete(),
})	

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()