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
			{ import = "lazyvim.plugins.extras.lang.typescript" },
			{ import = "lazyvim.plugins.extras.linting.eslint" },
			{ import = "lazyvim.plugins.extras.formatting.prettier" },
			-- { import = "lazyvim.plugins.extras.coding.copilot" }, -- to use custome settings for copilot
			{ import = "lazyvim.plugins.extras.lang.json" },
			{ import = "lazyvim.plugins.extras.lang.rust" },
			{ import = "lazyvim.plugins.extras.lang.tailwind" },
			-- { import = "lazyvim.plugins.extras.ui.mini-animate" },
			-- { import = "lazyvim.plugins.extras.ui.edgy" },
			-- { import = "lazyvim.plugins.extras.dap.core" },
			-- { import = "lazyvim.plugins.extras.vscode" },
			-- { import = "lazyvim.plugins.extras.dap.nlua" },
			-- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
			-- { import = "lazyvim.plugins.extras.test.core" },
			-- { import = "lazyvim.plugins.extras.coding.yanky" },
			-- { import = "lazyvim.plugins.extras.editor.mini-files" },
			-- { import = "lazyvim.plugins.extras.util.project" },
			{ import = "plugins" },
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
