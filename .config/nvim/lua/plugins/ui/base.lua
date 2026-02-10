return {
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { show_start = false, show_end = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local devicons = require("nvim-web-devicons")

			-- 一般的すぎるファイル名のリスト
			local common_filenames = {
				["index.ts"] = true,
				["index.tsx"] = true,
				["index.js"] = true,
				["index.jsx"] = true,
				["init.lua"] = true,
				["mod.rs"] = true,
				["main.go"] = true,
				["main.py"] = true,
			}

			require("incline").setup({
				render = function(props)
					local bufname = vim.api.nvim_buf_get_name(props.buf)
					local filename = vim.fn.fnamemodify(bufname, ":t")
					if filename == "" then
						filename = "[No Name]"
					end

					-- 一般的なファイル名の場合は親ディレクトリも表示
					local display_name = filename
					if common_filenames[filename] then
						local parent = vim.fn.fnamemodify(bufname, ":h:t")
						display_name = parent .. "/" .. filename
					end

					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified

					-- LSP Diagnosticsを取得
					local diagnostics = vim.diagnostic.get(props.buf)
					local errors = #vim.tbl_filter(function(d)
						return d.severity == vim.diagnostic.severity.ERROR
					end, diagnostics)
					local warnings = #vim.tbl_filter(function(d)
						return d.severity == vim.diagnostic.severity.WARN
					end, diagnostics)
					local hints = #vim.tbl_filter(function(d)
						return d.severity == vim.diagnostic.severity.HINT
					end, diagnostics)
					local info = #vim.tbl_filter(function(d)
						return d.severity == vim.diagnostic.severity.INFO
					end, diagnostics)

					-- inactiveの場合は存在感を弱める
					local gui = modified and "bold,italic" or "bold"

					local buffer = { " " }

					-- 診断情報を左側に表示 (Nerd Font icons)
					local icons = {
						error = "\u{f057}", -- nf-fa-times_circle (× in circle)
						warn = "\u{f071}", -- nf-fa-warning (! in triangle)
						info = "\u{f05a}", -- nf-fa-info_circle (i in circle)
						hint = "\u{f0eb}", -- nf-fa-lightbulb_o (bulb)
					}
					if errors > 0 then
						table.insert(buffer, { icons.error .. " " .. errors .. " ", guifg = "#e06c75" })
					end
					if warnings > 0 then
						table.insert(buffer, { icons.warn .. " " .. warnings .. " ", guifg = "#e5c07b" })
					end
					if info > 0 then
						table.insert(buffer, { icons.info .. " " .. info .. " ", guifg = "#61afef" })
					end
					if hints > 0 then
						table.insert(buffer, { icons.hint .. " " .. hints .. " ", guifg = "#98c379" })
					end

					-- ファイルアイコンとファイル名
					if ft_icon then
						table.insert(buffer, { ft_icon .. " ", guifg = ft_color })
					end
					table.insert(buffer, { display_name, gui = gui, blend = props.focused and 0 or 50 })

					-- 未保存マーク
					if modified then
						table.insert(buffer, { " ●", guifg = "#d19a66" })
					end

					table.insert(buffer, " ")
					return buffer
				end,
				window = {
					padding = 0,
					margin = { horizontal = 0, vertical = 0 },
				},
			})
		end,
	},
	{
		"mvllow/modes.nvim",
		event = "VeryLazy",
		config = function()
			require("modes").setup({
				colors = {
					copy = "#ffdd55",    -- 明るい黄色
					delete = "#ff6b6b",  -- 明るい赤
					insert = "#5cffb7",  -- 明るい緑
					visual = "#e0d0ff",  -- 淡い紫（白に近い）
				},
				line_opacity = 0.15,
				set_cursor = true,
				set_cursorline = true,
				set_number = true,
				ignore = { "NvimTree", "neo-tree", "TelescopePrompt" },
			})
		end,
	},
	{
		"WilliamHsieh/overlook.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>pd",
				function()
					require("overlook.api").peek_definition()
				end,
				desc = "Peek definition",
			},
			{
				"<leader>pp",
				function()
					require("overlook.api").peek_cursor()
				end,
				desc = "Peek cursor",
			},
			{
				"<leader>pc",
				function()
					require("overlook.api").close_all()
				end,
				desc = "Close all peeks",
			},
			{
				"<leader>pu",
				function()
					require("overlook.api").restore_popup()
				end,
				desc = "Restore popup",
			},
			{
				"<leader>pf",
				function()
					require("overlook.api").switch_focus()
				end,
				desc = "Switch focus",
			},
			{
				"<leader>ps",
				function()
					require("overlook.api").open_in_vsplit()
				end,
				desc = "Open in split",
			},
			{
				"<leader>po",
				function()
					require("overlook.api").open_in_original_window()
				end,
				{ desc = "Open popup in current window" },
			},
		},
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			integration = {
				["nvim-tree"] = {
					enable = true,
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"echasnovski/mini.statusline",
		version = false,
		event = "VeryLazy",
		config = function()
			local statusline = require("mini.statusline")
			statusline.setup({
				content = {
					active = function()
						local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
						local git = statusline.section_git({ trunc_width = 40 })
						local diff = statusline.section_diff({ trunc_width = 75 })
						local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
						local lsp = statusline.section_lsp({ trunc_width = 75 })
						local filename = statusline.section_filename({ trunc_width = 140 })
						local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
						local location = statusline.section_location({ trunc_width = 75 })
						local search = statusline.section_searchcount({ trunc_width = 75 })

						-- マクロ録画状態を表示
						local recording = vim.fn.reg_recording()
						local recording_status = ""
						if recording ~= "" then
							recording_status = " \u{f192} REC @" .. recording  -- nf-fa-dot_circle_o
						end

						return statusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = recording ~= "" and "MiniStatuslineRecording" or "MiniStatuslineFileinfo", strings = { recording_status } },
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
				},
			})

			-- 録画用ハイライトグループを定義
			vim.api.nvim_set_hl(0, "MiniStatuslineRecording", { fg = "#e06c75", bold = true })

			-- 録画開始/終了時にステータスラインを更新
			vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
				callback = function()
					vim.cmd("redrawstatus")
				end,
			})
		end,
	},
}
