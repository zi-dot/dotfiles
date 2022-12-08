local status, cmp = pcall(require, "cmp")
if not status then
  return
end
local lspkind = require("lspkind")

if cmp == nil then
  return
end

local types = require("cmp.types")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
        local kind2 = entry2:get_kind()
        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Snippet then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Snippet then
            return true
          end
          local diff = kind1 - kind2
          if diff < 0 then
            return true
          elseif diff > 0 then
            return false
          end
        end
      end,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { name = "copilot", priority = 90 }, -- For luasnip users.
    { name = "nvim_lsp", priority = 100 },
    { name = "luasnip", priority = 20 }, -- For luasnip users.
    { name = "path", priority = 100 },
    { name = "emoji", insert = true, priority = 60 },
    { name = "nvim_lua", priority = 50 },
    { name = "nvim_lsp_signature_help", priority = 80 },
  }, {
    { name = "buffer", priority = 50 },
    -- { name = "omni", priority = 60 },
    { name = "spell", priority = 40 },
    { name = "calc", priority = 50 },
    { name = "treesitter", priority = 30 },
    { name = "dictionary", keyword_length = 2, priority = 10 },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
  },
})

cmp.setup.cmdline(":", {
  mapping = {
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "c" }),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "c" }),
    ["<C-y>"] = {
      c = cmp.mapping.confirm({ select = false }),
    },
    ["<C-q>"] = {
      c = cmp.mapping.abort(),
    },
  },
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

vim.cmd([[
  set completeopt=menu,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
