return {
	"lervag/vimtex",
	enables = true,
	lazy = false, -- we don't want to lazy load VimTeX
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0 -- Default 2 (open error window automatically - VimtexErrors)
	end,
}

