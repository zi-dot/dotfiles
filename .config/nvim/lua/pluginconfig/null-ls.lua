local nullls = require "null-ls"
nullls.setup {
  sources = {
    nullls.builtins.formatting.stylua,
    nullls.builtins.diagnostics.eslint,
    nullls.builtins.completion.spell,
    nullls.builtins.formatting.prettier,
  },
}
