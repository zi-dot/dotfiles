local notify = require("notify")
notify.setup({
  stages = "slide",
  top_down = false,
})
vim.notify = notify
