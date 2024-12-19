return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup()
			mason_lspconfig.setup_handlers({
				function(server_name)
					local lspconfig = require("lspconfig")
					if server_name == "tsserver" then
						lspconfig["tsserver"].setup({
							initialization_options = {
								maxTsServerMemory = 16384,
							},
							inlay_hints = {
								enabled = true,
							},
						})
					else
						lspconfig[server_name].setup({})
					end
				end,
			})
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
		end,
		keys = {
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Goto Definition",
			},
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{
				"gI",
				function()
					require("telescope.builtin").lsp_implementations({ reuse_win = true })
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
				end,
				desc = "Goto Type Definition",
			},
			{
				"K",
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Hover",
			},
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
			{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename", mode = { "n" } },
			{ "<C-j>", vim.diagnostic.goto_next, desc = "Go to Next Diagnostic", mode = { "n" } },
		},
	},
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				symbols = {
					win = { position = "bottom" },
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>td",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>tdb",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"stylua",
				"typescript-language-server",
				"rust-analyzer",
				"luacheck",
				"shellcheck",
				"shfmt",
				"lua-language-server",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufEnter",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "stylelint", "prettier" },
				javascript = { "eslint", "prettier" },
				typescript = { "eslint", "prettier" },
				typescriptreact = { "eslint", "prettier" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
			notify_on_error = true,
		},
		keys = {
			{
				"<leader>fmt",
				function()
					require("conform").format()
				end,
				desc = "format by conform",
			},
		},
	},
}
