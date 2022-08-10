local nullls = require("null-ls")
local formatting = nullls.builtins.formatting

nullls.setup({
	sources = {
		formatting.prettier.with({
			condition = function()
				return vim.fn.executable("prettier") > 0
			end,
		}),
		formatting.stylelint.with({
			condition = function()
				return vim.fn.executable("stylelint") > 0
			end,
		}),
		formatting.stylua,
		nullls.builtins.completion.spell,
		nullls.builtins.code_actions.eslint_d,
	},
})
