return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			return {
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None",
						col_offset = 1,
						side_padding = 0,
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None",
					}),
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							ellipsis_char = "…",
						})(entry, vim_item)
						return kind
					end,
				},
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = function(fallback)
						if cmp.visible() then
							if cmp.confirm({ select = true }) then
								return
							end
						end
						return fallback()
					end,
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				sorting = defaults.sorting,
			}
		end,
	},

	{
		"hrsh7th/cmp-cmdline",
		event = "BufEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup.cmdline("/", {
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				completion = { completeopt = "menu,menuone,noselect" },
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
