-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Import plugins from plugin module
require("plugins")
require("base")

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

-- Added explicit list for telescope to ignore
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "^po/*",
  "vendor/*",
  "%.lock",
  "__pycache__/*",
  "%.sqlite3",
  "%.ipynb",
  "node_modules/*",
  "%.jpg",
  "%.jpeg",
  "%.png",
  "%.svg",
  "%.otf",
  "%.ttf",
  ".git/",
  "%.webp",
  ".dart_tool/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vscode/",
  "__pycache__/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "target/",
  "%.pdb",
  "%.dll",
  "%.class",
  "%.exe",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
  "%.po",
  "smalljre_*/*",
  ".vale/",
}

-- Changed telescope layout (text search, etc)
lvim.builtin.telescope.defaults.layout_config = {
  prompt_position = "top",
  height = 0.9,
  width = 0.9,
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    width = 0.5,
  },
  cursor = {
    preview_cutoff = 40,
  },
  horizontal = {
    preview_cutoff = 120,
    preview_width = 0.6,
  },
  vertical = {
    preview_cutoff = 40,
  },
  flex = {
    flip_columns = 150,
  },
}
for key, _ in pairs(lvim.builtin.telescope.pickers) do
  if key ~= "planets" then
    lvim.builtin.telescope.pickers[key].previewer = nil
    lvim.builtin.telescope.pickers[key].theme = nil
    lvim.builtin.telescope.pickers[key].layout_strategy = nil
  end
end
lvim.builtin.telescope.pickers.git_files.previewer = nil
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.defaults.prompt_prefix = "  "
lvim.builtin.telescope.defaults.selection_caret = "❯ "
lvim.builtin.telescope.defaults.winblend = 10
lvim.builtin.telescope.defaults.borderchars = {
  prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
  results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

-- Added linter for typscript and javascript
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
}
