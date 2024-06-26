-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Import plugins from plugin module
require("plugins")
require("base")
require("telescope_conf")

lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.which_key.mappings["e"] = {
  "<cmd>Neotree toggle<CR>", "Neotree Explorer"
}

-- Added minimap toggle shortcut
lvim.builtin.which_key.mappings["m"] = {
  "<cmd>MinimapToggle<CR>", "Toggle Minimap"
}

-- Added Format on Save tobble shortcut
lvim.builtin.which_key.mappings["bS"] = {
  "<cmd>LvimToggleFormatOnSave<CR>", "Toggle Format on Save"
}

lvim.builtin.which_key.mappings["p"] = {
  "<cmd>Precognition toggle<CR>", "Toggle Precognition"
}

lvim.builtin.which_key.mappings["o"] = {
  name = "Bookmarks",
  l = { "<cmd>BookmarksListAll<CR><cmd>lcl<CR><cmd>Telescope loclist<CR>", "Show all on Telescope" },
}

lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- Post plugin declaration setup for `lsp_signature`
lvim.lsp.on_attach_callback = function(client, bufnr)
  -- …
  require "lsp_signature".on_attach()
  -- …
end

-- Added to prevent CSSLS unknown at rule. This would make working with TailwindCSS cleaner.
require("lvim.lsp.manager").setup("cssls", {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  },
})
-- Added more formatters. I don't remember what these are for
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { name = "prettier" },
  {
    name = "djlint",
    args = { "--indent", '2' }
  }
}

-- Added tailwindcss LSP
require("lvim.lsp.manager").setup("tailwindcss")

-- Added linter for typscript and javascript
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
}
