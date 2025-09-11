return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		version = "*",
		opts = {
			keymap = { preset = "enter" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				documentation = { auto_show = true, window = { border = "rounded" } },
				menu = {
					auto_show = true,
					border = "rounded",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				min_keyword_length = function(ctx)
					-- :wq, :qa -> menu doesn't popup
					-- :Lazy, :wqa -> menu popup
					if ctx.mode == "cmdline" and ctx.line:find("^%l+$") ~= nil then
						return 3
					end
					return 0
				end,
			},
			fuzzy = {
				-- versionを指定してないとバイナリが特定できずLuaにfallbackするwarningが表示される
				implementation = "prefer_rust_with_warning",
			},
			cmdline = {
				keymap = { preset = "inherit", ["<CR>"] = { "accept_and_enter", "fallback" } },
				completion = {
					menu = {
						auto_show = function(ctx)
							return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
						end,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false, -- last release is way too old
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"hrsh7th/cmp-path",
	-- 		"onsails/lspkind-nvim",
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		cmp.setup({
	-- 			window = {
	-- 				completion = cmp.config.window.bordered({
	-- 					winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None",
	-- 					col_offset = 1,
	-- 					side_padding = 0,
	-- 				}),
	-- 				documentation = cmp.config.window.bordered({
	-- 					winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:Visual,Search:None",
	-- 				}),
	-- 			},
	-- 			formatting = {
	-- 				fields = { "abbr", "kind", "menu" },
	-- 				format = function(entry, vim_item)
	-- 					local kind = require("lspkind").cmp_format({
	-- 						mode = "symbol_text",
	-- 						maxwidth = 50,
	-- 						ellipsis_char = "…",
	-- 					})(entry, vim_item)
	-- 					return kind
	-- 				end,
	-- 				expandable_indicator = true,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<CR>"] = function(fallback)
	-- 					if cmp.visible() then
	-- 						if cmp.confirm({ select = true }) then
	-- 							return
	-- 						end
	-- 					end
	-- 					return fallback()
	-- 				end,
	-- 				["<S-CR>"] = cmp.mapping.confirm({
	-- 					behavior = cmp.ConfirmBehavior.Replace,
	-- 					select = true,
	-- 				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	-- 				["<C-CR>"] = function(fallback)
	-- 					cmp.abort()
	-- 					fallback()
	-- 				end,
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "path" },
	-- 				{ name = "buffer" },
	-- 			}),
	-- 			performance = {
	-- 				throttle = 50, -- 補完結果の表示を遅延させる間隔(ms)。デフォルト30ms
	-- 				debounce = 20, -- 入力後の候補収集をグループ化する待ち時間(ms)。デフォルト60ms
	-- 				fetching_timeout = 200, -- ソースからの取得待ちタイムアウト(ms)
	-- 				max_view_entries = 20, -- 一度に表示する補完項目数の上限
	-- 			},
	-- 		})
	--
	-- 		cmp.setup.cmdline("/", {
	-- 			completion = { completeopt = "menu,menuone,noselect" },
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "buffer" },
	-- 			},
	-- 		})
	--
	-- 		cmp.setup.filetype("gitcommit", {
	-- 			completion = { completeopt = "menu,menuone,noselect" },
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "path" },
	-- 				{ name = "buffer" },
	-- 			}),
	-- 		})
	--
	-- 		cmp.setup.cmdline(":", {
	-- 			completion = { completeopt = "menu,menuone,noselect" },
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "path" },
	-- 			}, {
	-- 				{
	-- 					name = "cmdline",
	-- 					option = {
	-- 						ignore_cmds = { "Man", "!" },
	-- 					},
	-- 				},
	-- 			}),
	-- 		})
	-- 	end,
	-- },
}
