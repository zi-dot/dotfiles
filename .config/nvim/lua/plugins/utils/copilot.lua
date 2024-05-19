return {
  {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = false,
					prev = "<M-[>",
					next = "<M-]>",
				},
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
			local copilot_suggestion = require("copilot.suggestion")
			vim.keymap.set("i", "<Tab>", function()
				if copilot_suggestion.is_visible() then
					copilot_suggestion.accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
				end
			end)
		end,
	}
}
