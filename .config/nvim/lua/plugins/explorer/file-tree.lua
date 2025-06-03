return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "neo-tree",
				callback = function()
					vim.keymap.set("n", "z.", function()
						vim.cmd("normal! zz")
					end, { buffer = true, desc = "Center cursor in Neo-tree" })
				end,
			})

			require("neo-tree").setup({
				close_if_last_window = true,
				enable_git_status = true,
				enable_diagnostics = true,
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
					follow_current_file = {
						enabled = true,
					},
				},
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
				event_handlers = {
					{
						event = "file_opened",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			})
		end,
		keys = {
			{
				"<c-e>",
				"<cmd>Neotree toggle<cr>",
				desc = "toggle neotree",
			},
		},
	},
}
