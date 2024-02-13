local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
	vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

---@param opts LazyConfig
return function(opts)
	opts = vim.tbl_deep_extend("force", {
		spec = {
			{
				"LazyVim/LazyVim",
				import = "lazyvim.plugins",
			},
			{
				import = "plugins",
			},
		},
		defaults = { lazy = true },
		checker = { enabled = true },
		performance = {
			cache = {
				enable = true,
			},
		},
	}, opts or {})
	require("lazy").setup(opts)
end
