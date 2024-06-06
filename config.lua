-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    -- configure and set on startup
    config = function()
      vim.g.adwaita_darker = false            -- for darker version
      vim.g.adwaita_disable_cursorline = true -- to disable cursorline
      vim.g.adwaita_transparent = true        -- makes the background transparent
      lvim.colorscheme = "adwaita"
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({})
    end
  },
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    lazy = false,
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    init = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 0
      vim.g.minimap_auto_start_win_enter = 0
      vim.g.minimap_highlight_range = true
      vim.g.minimap_highlight_search = true
    end,
  },
  {
    "tpope/vim-surround",
  },
  { "mg979/vim-visual-multi" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      vim.keymap.set('n', 's', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
      vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)')
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }
}

lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.which_key.mappings["e"] = {
  "<cmd>Neotree toggle<CR>", "Neotree Explorer"
}

-- Added minimap toggle shortcut
lvim.builtin.which_key.mappings["m"] = {
  "<cmd>MinimapToggle<CR>", "Toggle Minimap"
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

-- Added to set project detection method
lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.manual_mode = true

-- My normal vim config + lvim's format on save
lvim.format_on_save.enabled = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.ic = false
vim.opt.guicursor = "i-ci-ve:hor30"
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 3

-- WebC configuration
vim.filetype.add({
  extension = {
    webc = 'html'
  },
  filename = { ['.webc'] = 'html' },
  filetype = { ['.webc'] = 'html' }
})
vim.treesitter.language.register('html', 'webc')

-- Make deletion command not add to clipboard
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'


-- Extended timeout for LSP format to 5s, since some formatters are too slow.
-- Without this, some formatters are killed before finishing.
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 5000 }
  end,
  "Format",
}

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
