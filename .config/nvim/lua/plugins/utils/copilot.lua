return {
	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			vim.g.copilot_node_command = "~/.asdf/shims/node"
		end,
	},
}
