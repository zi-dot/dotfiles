vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "[dev]", "<Nop>", { silent = true })

vim.keymap.set("", "<Tab>", "<Nop>") -- special case
vim.keymap.set("n", "<C-s>", "<Nop>")

vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("n", "U", "<C-r>", { silent = true })

vim.keymap.set("n", "p", "]p`]", { silent = true })
vim.keymap.set("n", "P", "]P`]", { silent = true })

vim.keymap.set("n", "+", "<C-a>", { silent = true })
vim.keymap.set("n", "-", "<C-x>", { silent = true })

vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

vim.keymap.set("t", "jj", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "s", "<Nop>", { silent = true })

vim.keymap.set("n", "ss", ":split<Return>", { silent = true, remap = true })
vim.keymap.set("n", "sv", ":vsplit<Return>", { silent = true, remap = true })

vim.keymap.set({ "n" }, "sh", "<C-w>h", { silent = true })
vim.keymap.set({ "n" }, "sk", "<C-w>k", { silent = true })
vim.keymap.set({ "n" }, "sj", "<C-w>j", { silent = true })
vim.keymap.set({ "n" }, "sl", "<C-w>l", { silent = true })

vim.keymap.set({ "n" }, "<D-v>", "p", { silent = true, remap = true })
vim.keymap.set({ "i" }, "<D-v>", "<C-o>p", { silent = true, remap = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>cp", function()
	local file_path = vim.fn.expand("%:p")
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git_root then
		local relative_path = file_path:sub(#git_root + 2)
		vim.fn.setreg("*", relative_path)
		vim.notify("Copied: " .. relative_path)
	else
		vim.fn.setreg("*", file_path)
		vim.notify("Copied (absolute): " .. file_path)
	end
end, { silent = true })

vim.keymap.set("n", "<leader>deleteswap", ":!rm ~/.local/state/nvim/swap/*", { silent = true })

vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true })

vim.keymap.set("n", "cp", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "cn", ":cnext<CR>", { silent = true })

vim.keymap.set({ "n" }, "n", "nzz", { noremap = true, silent = true })
vim.keymap.set({ "n" }, "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set({ "n" }, "*", "*zz", { noremap = true, silent = true })

vim.keymap.set({ "n" }, "st", ":tabnew %<CR>", { silent = true })
vim.keymap.set({ "n" }, "<leader>ba", ":%bdelete<CR>", { silent = true, desc = "Delete all buffers" })
vim.keymap.set({ "n" }, "sn", ":tabnext<CR>", { silent = true })
vim.keymap.set({ "n" }, "sp", ":tabprevious<CR>", { silent = true })
vim.keymap.set({ "n" }, "sc", ":tabclose<CR>", { silent = true })

for _, quote in ipairs({ '"', "'", "`" }) do
	vim.keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

vim.api.nvim_create_user_command("GitDiff", function()
	vim.cmd("new")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "delete"
	vim.bo.swapfile = false
	vim.bo.filetype = "gitcommit"
	vim.cmd("read !git diff #")
	vim.bo.readonly = true
	vim.bo.buflisted = false
	vim.cmd("normal! gg")
end, {})
