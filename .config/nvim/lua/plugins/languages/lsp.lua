local function find_nearest_dir(patterns)
	local fpath = vim.api.nvim_buf_get_name(0)
	local dir = vim.fn.fnamemodify(fpath, ":p:h")

	while dir ~= "/" do
		for _, pattern in ipairs(patterns) do
			local target = dir .. "/" .. pattern
			if vim.fn.filereadable(target) == 1 then
				return dir
			end
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end

	return nil
end

local function on_init(client)
	if client.server_capabilities then
		client.server_capabilities.semanticTokensProvider = false
	end
end

local function on_attach()
	vim.keymap.set({ "n" }, "gd", function()
		require("telescope.builtin").lsp_definitions()
	end, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "gr", function()
		require("telescope.builtin").lsp_references()
	end, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "gI", function()
		require("telescope.builtin").lsp_implementations({ reuse_win = true })
	end, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "gy", function()
		require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
	end, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "K", function()
		vim.cmd("Lspsaga hover_doc")
	end, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "gK", vim.lsp.buf.signature_help, { noremap = true, silent = true })
	vim.keymap.set({ "i" }, "<C-k>", vim.lsp.buf.signature_help, { noremap = true, silent = true })
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>cc", vim.lsp.codelens.run, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>cC", vim.lsp.codelens.refresh, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
	vim.keymap.set({ "n" }, "<C-j>", vim.diagnostic.goto_next, { noremap = true, silent = true })
end

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = {
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		dependencies = {
			{ "williamboman/mason.nvim" },
		},
		opts = {
			ensure_installed = {
				"actionlint",
				"astro",
				"eslint_d",
				"goimports",
				"gopls",
				"lua_ls",
				"prettierd",
				"rust_analyzer",
				"stylelint",
				"stylua",
				"terraformls",
				"textlint",
				"ts_ls",
				"typos-lsp",
				"vimls",
			},
			run_on_start = false,
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimdev/lspsaga.nvim",
			"neovim/nvim-lspconfig",
		},
		init = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"

			local signs = {
				{ name = "DiagnosticSignError", text = "•" },
				{ name = "DiagnosticSignWarn", text = "•" },
				{ name = "DiagnosticSignHint", text = "•" },
				{ name = "DiagnosticSignInfo", text = "•" },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			vim.diagnostic.config({
				float = { border = "rounded" },
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = {
						spacing = 2,
					},
					signs = {
						active = signs,
					},
				})

			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local default_capabilities = vim.lsp.protocol.make_client_capabilities()
			local opts = {
				on_init = on_init,
				on_attach = on_attach,
				capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities),
			}

			vim.lsp.config("*", opts)
			vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = { "LspAttach" },
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		on_init = on_init,
	-- 		on_attach = on_attach,
	-- 		settings = {
	-- 			expose_as_code_action = "all",
	-- 		},
	-- 	},
	-- },
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
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPost",
			"BufWritePost",
			"InsertLeave",
			"TextChanged",
		},
		config = function()
			local lint = require("lint")

			local eslint_d = lint.linters.eslint_d
			lint.linters.eslint_d = vim.tbl_extend("force", eslint_d, {
				parser = function(output, bufnr)
					-- Suppress "No ESLint found" error
					local result = eslint_d.parser(output, bufnr)
					if #result == 1 then
						local msg = result[1].message
						if string.match(msg, "No ESLint found") then
							return {}
						end
						if string.match(msg, "Could not find config file") then
							return {}
						end
					end
					return result
				end,
			})

			local actionlint = lint.linters.actionlint
			lint.linters.actionlint = vim.tbl_extend("force", actionlint, {
				parser = function(output, bufnr)
					-- Only GHA files
					local fpath = vim.api.nvim_buf_get_name(bufnr)
					if fpath:match("^.*%.github/.+%.y[a]?ml$") == nil then
						return {}
					end
					return actionlint.parser(output, bufnr)
				end,
			})

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				css = { "stylelint" },
				yaml = { "actionlint" },
				terraform = { "tflint" },
			}

			local check_local = {
				"eslint_d",
				"stylelint",
			}

			local function contains(table, elements)
				for _, value in ipairs(table) do
					for _, element in ipairs(elements) do
						if value == element then
							return true
						end
					end
				end
				return false
			end

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" }, {
				callback = function()
					local names = lint.linters_by_ft[vim.bo.filetype]
					if names and contains(names, check_local) then
						lint.try_lint(nil, {
							cwd = find_nearest_dir({ "package.json" }),
						})
					else
						lint.try_lint()
					end
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					css = { "stylelint", "prettier" },
					javascript = { "eslint_d", "prettier" },
					typescript = { "eslint_d", "prettier" },
					typescriptreact = { "eslint_d", "prettier" },
					rust = { "rustfmt" },
				},
				format_on_save = {
					timeout_ms = 5000,
					lsp_fallback = true,
				},
				notify_on_error = true,
			})
		end,
		keys = {
			{
				"<leader>fmt",
				function()
					require("conform").format({
						async = true,
					})
				end,
				mode = { "n" },
				noremap = true,
				silent = true,
				desc = "format by conform",
			},
		},
	},
}
