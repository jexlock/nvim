local null_ls = require('null-ls')
local mason_tool_installer = require('mason-tool-installer')
local lsp = require('lsp-zero')

-- Regular Null-ls servers.
local null_ls_formatters = {"prettierd"}
local null_ls_code_actions = {}
local null_ls_linters = {}

-- Regular LSPs
local mason_lsps = {
	"ansiblels",
	"bashls",
	"cssls",
    "gopls",
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
	}),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.gospel,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.luacheck
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

table.foreach(null_ls_linters, function(_, linter)
	table.insert(null_ls_sources, null_ls.builtins.code_actions[linter])
	table.insert(mason_tools_lsps, linter)
end)

-- Installs the non-LSP servers (formatters, etc.)
mason_tool_installer.setup {
	ensure_installed = mason_tools_lsps,
	auto_update = false,
	run_on_start = true,
}

null_ls.setup({
	sources = null_ls_sources
})

lsp.preset('recommended')
lsp.ensure_installed(mason_lsps)

-- Runs for each buffer
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
	local noremap = { buffer = bufnr, remap = false }
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, noremap)
	vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, noremap)
end)

-- Allow lua to work in nvim config
lsp.nvim_workspace()
lsp.setup()

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
	window = {
		completion = {
			col_offset = -3,
			side_padding = 0
		}
	},
	preselect = cmp.PreselectMode.None,
	experimental = {
		ghost_text = true,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item = lspkind.cmp_format({
				mode = "symbol",
				menu = ({
					buffer = "",
					nvim_lsp = "",
					luasnip = "",
				})
			})(entry, vim_item)
			vim_item.kind = " " .. (vim_item.kind or "") .. " "
			return vim_item
		end
	}
})
