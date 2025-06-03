return {
	-- {
	-- 	"saghen/blink.cmp",
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	-- optional: provides snippets for the snippet source
	-- 	dependencies = "rafamadriz/friendly-snippets",
	--
	-- 	completion = {
	-- 		menu = { border = "round" },
	-- 		documentation = { window = { border = "round" } },
	-- 	},
	-- 	signature = { window = { border = "round" } },
	--
	-- 	-- use a release tag to download pre-built binaries
	-- 	version = "*",
	-- 	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- 	-- build = 'cargo build --release',
	-- 	-- If you use nix, you can build from source using latest nightly rust with:
	-- 	-- build = 'nix run .#build-plugin',
	--
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	-- 	opts = {
	-- 		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
	-- 		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
	-- 		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- 		--
	-- 		-- All presets have the following mappings:
	-- 		-- C-space: Open menu or open docs if already open
	-- 		-- C-e: Hide menu
	-- 		-- C-k: Toggle signature help
	-- 		--
	-- 		-- See the full "keymap" documentation for information on defining your own keymap.
	-- 		keymap = {
	-- 			preset = "default",
	-- 			["<C-n>"] = { "select_next" },
	-- 			["<C-p>"] = { "select_prev" },
	-- 			["<C-b>"] = { "scroll_documentation_up" },
	-- 			["<C-f>"] = { "scroll_documentation_down" },
	-- 			["<C-e>"] = { "hide", "fallback" },
	-- 			["<CR>"] = { "accept", "fallback" },
	-- 			["<C-CR>"] = { "hide", "fallback" },
	-- 		},
	--
	-- 		signature = {
	-- 			enabled = true,
	-- 			trigger = {
	-- 				enabled = true,
	-- 			},
	-- 		},
	--
	-- 		appearance = {
	-- 			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
	-- 			-- Useful for when your theme doesn't support blink.cmp
	-- 			-- Will be removed in a future release
	-- 			use_nvim_cmp_as_default = true,
	-- 			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 			-- Adjusts spacing to ensure icons are aligned
	-- 			nerd_font_variant = "mono",
	-- 		},
	--
	-- 		sources = {
	-- 			default = { "lsp", "path", "snippets", "buffer" },
	-- 		},
	--
	-- 		fuzzy = { implementation = "prefer_rust_with_warning" },
	-- 	},
	-- 	opts_extend = { "sources.default" },
	-- },
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
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
					expandable_indicator = true,
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
					{ name = "buffer" },
				}),
				performance = {
					throttle = 50, -- 補完結果の表示を遅延させる間隔(ms)。デフォルト30ms
					debounce = 20, -- 入力後の候補収集をグループ化する待ち時間(ms)。デフォルト60ms
					fetching_timeout = 200, -- ソースからの取得待ちタイムアウト(ms)
					max_view_entries = 20, -- 一度に表示する補完項目数の上限
				},
			})

			cmp.setup.cmdline("/", {
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.filetype("gitcommit", {
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "buffer" },
				}),
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
