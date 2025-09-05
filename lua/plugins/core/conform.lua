return {
	"stevearc/conform.nvim",
	enable = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		local format_opts = {
			lsp_format = "fallback",
			async = false,
			timeout_ms = 500,
		}
		local function add_new_line()
			local last_line = vim.fn.getline("$")
			-- print("Last line: " .. last_line)
			if last_line ~= "" then
				vim.fn.append(vim.fn.line("$"), "")
				-- print("Appended newline")
			end
			-- print("end ")
		end

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "htmlbeautifier" },
				css = { "prettierd" },
				json = { "jq", "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
				lua = { "stylua" },
				python = { "isort", "black" },
				terraform = { "terraform" },
			},
			formatters = {
				prettierd = {
					command = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				},
			},

			-- format_on_save = format_opts,
			format_on_save = function(bufnr)
				conform.format(vim.tbl_extend("force", format_opts, { bufnr = bufnr }), add_new_line)
			end,
		})

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		vim.keymap.set({ "n", "v" }, "<leader>fp", function()
			conform.format(format_opts, add_new_line)
		end, { desc = "[F]ormat [P]retty file or range (in visual mode)" })
	end,
}

