vim.api.nvim_set_keymap("n", "[fuzzy-finder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[fuzzy-finder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "z", "[fuzzy-finder]", {})
vim.api.nvim_set_keymap("v", "z", "[fuzzy-finder]", {})

vim.api.nvim_set_keymap("n", "[fuzzy-finder]g", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[fuzzy-finder]f", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true })

local telescope = require('telescope')

telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        }
    }
})
