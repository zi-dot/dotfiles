return {
	{ "folke/neodev.nvim", opts = {} },
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
					require("lspconfig")[server_name].setup({
						inlay_hints = {
							enable = true,
						},
						codelens = {
							enabled = true,
						},
					})
				end,
			})
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
		end,
		keys = {
			{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
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
				desc = "Goto T[y]pe Definition",
			},
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
			{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename", mode = { "n" } },
			{ "<C-j>", vim.diagnostic.goto_next, desc = "Go to Next Diagnostic", mode = { "n" } },
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
				css = { "stylelint", "prettierd", "prettier" },
				javascript = { { "eslint", "prettierd", "prettier" } },
				typescript = { { "eslint", "prettierd", "prettier" } },
				typescriptreact = { { "eslint", "prettierd", "prettier" } },
				rust = { "rustfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
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
