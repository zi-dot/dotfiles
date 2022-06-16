local lightspeed = require("lightspeed")

lightspeed.setup({
	disable_default_mappings = true,
})

vim.keymap.set("n", "<S-s>", "<Plug>Lightspeed_s", {})
vim.keymap.set("n", "<C-s>", "<Plug>Lightspeed_S", {})
