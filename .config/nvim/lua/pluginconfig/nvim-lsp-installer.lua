local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
end


local server_configs = {
    ["sumneko_lua"] = {
        settings = {
            Lua = {
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    -- library = vim.api.nvim_get_runtime_file("", true),
                    preloadFileSize = 500,
                    -- very slow
                    -- library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = { enable = false },
            },
        },
    },
}

local node_root_dir = lspconfig.util.root_pattern("package.json", "node_modules")
local buf_name = vim.api.nvim_buf_get_name(0)
local current_buf = vim.api.nvim_get_current_buf()
local is_node_repo = node_root_dir(buf_name, current_buf) ~= nil

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "tsserver" or server.name == "eslint" then
        opts.autostart = is_node_repo
    elseif server.name == "denols" then
        opts.autostart = not (is_node_repo)
        opts.init_options = { lint = true, unstable = true, }
    end
    if server_configs[server.name] then
        opts = vim.tbl_deep_extend("force", opts, server_configs[server.name])
    end

    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
end)
