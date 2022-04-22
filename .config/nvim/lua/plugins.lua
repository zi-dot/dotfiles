local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command("silent !git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
if vim.fn.executable("python3") == 1 then
	vim.cmd(
		[[let g:python_version = substitute(system("python3 -c 'from sys import version_info as v; print(v[0] * 100 + v[1])'"), '\n', '', 'g')]]
	)
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

  use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      event = "VimEnter",
      requires = {
          "nvim-lua/plenary.nvim",
          "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim"
      },
      config = function()
          require("pluginconfig/neo-tree")
      end,
  }
  -- Auto Completion
  use({
  	"hrsh7th/nvim-cmp",
  	requires = {
  		{ "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
  		{ "windwp/nvim-autopairs", opt = true, event = "VimEnter" },
  	},
  	after = { "lspkind-nvim", "LuaSnip", "nvim-autopairs" },
  	config = function()
  		require("pluginconfig/nvim-cmp")
  	end,
  })
  	use({
		"onsails/lspkind-nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/lspkind-nvim")
		end,
	})

    use({
		"tamago324/nlsp-settings.nvim",
		after = { "nvim-lspconfig" },
		config = function()
			require("pluginconfig/nlsp-settings")
		end,
	})

    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "zbirenbaum/copilot-cmp", after = { "nvim-cmp", "copilot.lua" } })
	-- use({ "hrsh7th/cmp-copilot", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })

    use({ "github/copilot.vim", cmd = { "Copilot" } })
	use({
		"zbirenbaum/copilot.lua",
		after = "copilot.vim",
		config = function()
			vim.schedule(function()
				require("copilot")
			end)
		end,
	})

    -- Language Server Protocol(LSP)
	use({
		"neovim/nvim-lspconfig",
		after = "cmp-nvim-lsp",
		config = function()
			require("pluginconfig/nvim-lspconfig")
		end,
	})
	use({
		"williamboman/nvim-lsp-installer",
		requires = { { "RRethy/vim-illuminate", opt = true } },
		after = { "nvim-lspconfig", "vim-illuminate", "nlsp-settings.nvim" },
		config = function()
			require("pluginconfig/nvim-lsp-installer")
		end,
	})

    	use({
		"RRethy/vim-illuminate",
		event = "VimEnter",
		config = function()
			require("pluginconfig/vim-illuminate")
		end,
	})

    use ({'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}, 
    config = function()
        require('/pluginconfig/navigator')
    end,
})
    use {
  "ray-x/lsp_signature.nvim",
}
--    	use({
--		"windwp/nvim-autopairs",
--		event = "VimEnter",
--		config = function()
--			require("pluginconfig/nvim-autopairs")
--		end,
--	})
--
    use({
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/telescope")
		end,
	})
end)
