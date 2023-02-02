local null_ls = require('null-ls')
local mason_tool_installer = require('mason-tool-installer')
local lsp = require('lsp-zero')

-- Regular Null-ls servers.
local null_ls_formatters = {}
local null_ls_code_actions = { "eslint_d" }

-- Regular LSPs
local mason_lsps = {
	"ansiblels",
	"bashls",
	"cssls",
	"dockerls",
	"html",
	"jsonls",
	"tsserver",
	"pyright",
	"svelte",
	"tailwindcss",
	"yamlls",
}

-- beware beyond here...

-- Configure special Null-LS Servers
local null_ls_sources = {
	null_ls.builtins.formatting.prettierd.with({
		extra_filetypes = { "markdown", "svelte" }
	})
}
local mason_tools_lsps = { "prettierd" }

table.foreach(null_ls_formatters, function(_, formatter)
	table.insert(null_ls_sources, null_ls.builtins.formatting[formatter])
	table.insert(mason_tools_lsps, formatter)
end)

table.foreach(null_ls_code_actions, function(_, code_action)
	table.insert(null_ls_sources, null_ls.builtins.code_actions[code_action])
	table.insert(mason_tools_lsps, code_action)
end)

-- Installs the non-LSP servers (formatters, etc.)
mason_tool_installer.setup {
	ensure_installed = mason_tools_lsps,
	auto_update = false,
	run_on_start = true,
}

null_ls.setup({
	debug = true,
	sources = null_ls_sources
})

lsp.preset('recommended')
lsp.ensure_installed(mason_lsps)

-- Runs for each buffer
lsp.on_attach(function(_, bufnr)
	local noremap = { buffer = bufnr, remap = false }
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, noremap)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, noremap)
	vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, noremap)
end)

-- Allow lua to work in nvim config
lsp.nvim_workspace()
lsp.setup()
