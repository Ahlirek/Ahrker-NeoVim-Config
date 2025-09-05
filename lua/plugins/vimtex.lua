return {
	"lervag/vimtex",
	enables = true,
	lazy = false, -- we don't want to lazy load VimTeX
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
	end,
	config = function() -- Optional for keymaps
		vim.keymap.set("n", "<leader>xl", "<plug>(vimtex-compile)", { silent = true })
	end,
}

