local status, mason = pcall(require, "mason")
if not status then
	return
end
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end
local status3, nvim_lsp = pcall(require, "lspconfig")
if not status3 then
	return
end

mason.setup({})

mason_lspconfig.setup({
	function(server_name)
		local node_root_dir = nvim_lsp.util.root_pattern("package.json")
		local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

		local opts = {}

		if server_name == "tsserver" then
			if is_node_repo then
				return
			end

			opts.root_dir = node_root_dir
		elseif server_name == "eslint" then
			if not is_node_repo then
				return
			end

			opts.root_dir = node_root_dir
		elseif server_name == "denols" then
			if is_node_repo then
				return
			end

      opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
      opts.init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://cdn.nest.land"] = true,
              ["https://crux.land"] = true
            }
          }
        }
      }
		end

    opts.on_attach = function(_, buftr)
    end

    nvim_lsp[server_name].setup(opts)
	end,
})
