return {
	{
		"folke/neodev.nvim",
		opts = {
			debug = true,
			experimental = {
				pathStrict = true,
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"typescript-language-server",
				"rust-analyzer",
				"luacheck",
				"shellcheck",
				"shfmt",
				"lua-language-server",
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
			servers = {
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				lua_ls = {
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
			setup = {},
		},
		keys = {
			{ "<C-j>", vim.diagnostic.goto_next },
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = { virtual_text = { prefix = "icons" } },
			setup = {
				clangd = function(_, opts)
					opts.capabilities.offsetEncoding = { "utf-16" }
				end,
			},
		},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.diagnostics.eslint_d.with({
					diagnostics_format = "[eslint] #{m}\n(#{c})",
				}),
				nls.builtins.diagnostics.fish,
				nls.builtins.diagnostics.markdownlint,
				nls.builtins.diagnostics.luacheck.with({
					condition = function(utils)
						return utils.root_has_file({ ".luacheckrc" })
					end,
				}),
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.prettier,
				nls.builtins.formatting.eslint_d,
			})
			opts.on_attach = function(client, bufnr)
				local augroup_format = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_format })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup_format,
						buffer = 0,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end
		end,
	},

	{
		"hrsh7th/cmp-cmdline",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
}
