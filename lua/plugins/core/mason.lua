return {
	"williamboman/mason.nvim",
	enabled = true,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer",
		"hrsh7th/cmp-nvim-lsp",
		"jay-babu/mason-nvim-dap.nvim",
	},

	config = function()
		-- Mason
		local mason = require("mason")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Mason-lsp
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"rust_analyzer",
				"eslint",
				"lua_ls",
				"pyright",
				"ruff",
				"yamlls",
				"html",
				"cssls",
				"tailwindcss",
			},
		})

		-- Config lsp servers

		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities =
			vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

		vim.lsp.config("*", {
			capabilities = capabilities, -- Your autocompletition capabilities
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- Linters and Formatters
		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				"jq",
				"prettierd",
				"stylua",
				"isort",
				"eslint_d",
				"htmlbeautifier",
				"sonarlint-language-server",
				"jsonlint",
			},
		})

		-- Debugger
		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "js" }, -- List of DAP adapters to install
			automatic_installation = true, -- Automatically install adapters if not already installed
		})
	end,
}

