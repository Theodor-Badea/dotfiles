require "nvchad.options"

-- Base46 caches generated highlights. Reapply the transparent backgrounds at
-- startup so this remains effective even when that cache predates chadrc.lua.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for _, group in ipairs {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "EndOfBuffer",
      "StatusLine",
      "StatusLineNC",
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "TelescopeNormal",
      "TelescopePrompt",
      "TelescopeResults",
    } do
      local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
      highlight.bg = nil
      highlight.ctermbg = nil
      vim.api.nvim_set_hl(0, group, highlight)
    end
  end,
  desc = "Keep Neovim UI backgrounds transparent",
})

vim.wo.relativenumber = true

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--


-- so c has extensions
vim.filetype.add({
  extension = {
    c = "c",
  },
})
