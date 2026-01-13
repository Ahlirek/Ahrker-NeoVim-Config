return {
	"neovim/nvim-lspconfig",
	enabled = true,
	dependencies = {
		"j-hui/fidget.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("fidget").setup({})
		local keymap = vim.keymap
		local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format, { desc = "[F]ormat code using [L]SP" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
			desc = "Sets up an autocommand group and callback for when an LSP server attaches to a buffer.",
			callback = function(event)
				local function create_opts(desc)
					return { buffer = event.buf, desc = desc }
				end

				keymap.set("n", "gd", function()
					-- vim.lsp.buf.definition()
					builtin.lsp_definitions()
				end, create_opts("Go to definition"))

				keymap.set("n", "gD", function()
					vim.lsp.buf.declaration()
				end, create_opts("Go to declaration"))

				keymap.set("n", "<leader>vi", function()
					-- vim.lsp.buf.implementation()
					builtin.lsp_implementations()
				end, create_opts("Show LSP implementation"))

				keymap.set("n", "<leader>vt", function()
					-- vim.lsp.buf.type_definition()
					builtin.lsp_type_definitions()
				end, create_opts("Show LSP type definitions"))

				keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, create_opts("Show hover information"))

				keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, create_opts("Search workspace symbols"))

				keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, create_opts("Show diagnostics"))

				keymap.set("n", "<leader>vD", function()
					builtin.diagnostics({ bufnr = 0 })
				end, create_opts("Show diagnostics for file"))
				-- keymap.set("n", "<leader>vq", function()
				-- 	vim.diagnostic.setloclist()
				-- end, create_opts("Open diagnostic Quickfix"))

				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, create_opts("Go to next diagnostic"))

				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, create_opts("Go to previous diagnostic"))

				keymap.set({ "n", "v" }, "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, create_opts("Show code actions"))

				keymap.set("n", "<leader>vrr", function()
					-- vim.lsp.buf.references()
					builtin.lsp_references()
				end, create_opts("Show LSP references"))

				keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, create_opts("Rename symbol"))

				keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, create_opts("Signature help"))
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
				},
			},
			-- Optional: Additional diagnostic options
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = {
				prefix = "●",
			},
		})
	end,
}

