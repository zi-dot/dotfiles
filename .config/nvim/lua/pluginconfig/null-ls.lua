local nullls = require("null-ls")
local formatting = nullls.builtins.formatting

nullls.setup({
	sources = {
		formatting.prettier,
		formatting.stylelint,
		formatting.eslint_d,
		formatting.stylua,
		nullls.builtins.completion.spell,
	},
})
