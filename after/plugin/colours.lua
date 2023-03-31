
function HuffTheMarkers(colour)
	colour = colour or "everforest"
	vim.cmd.colorscheme(colour)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

HuffTheMarkers()

