-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Import plugins from plugin module
require("plugins")
require("base")
require("telescope")

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
