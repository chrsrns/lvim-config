-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

lvim.plugins = {
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
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
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "tpope/vim-surround",

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  { "mg979/vim-visual-multi" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  },
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

lvim.builtin.nvimtree.active = false
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  t = { "<cmd>TroubleToggle<cr> }", "Toggle Trouble On/Off" },
}

lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.manual_mode = true
lvim.format_on_save.enabled = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.ic = false
vim.opt.guicursor = "i-ci-ve:hor30"
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 3

vim.filetype.add({
  extension = {
    webc = 'html'
  },
  filename = { ['.webc'] = 'html' },
  filetype = { ['.webc'] = 'html' }
})
vim.treesitter.language.register('html', 'webc')

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'

-- lvim.builtin.telescope.defaults.layout_strategy = 'vertical'
-- lvim.builtin.telescope.defaults.layout_config = {
--   width = 0.90, -- 0.90,
--   height = 0.4,
--   preview_height = 0.5,
-- }
require("lvim.lsp.manager").setup("emmet_ls")

-- lvim.format_on_save.timeout = 5000
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 5000 }
  end,
  "Format",
}
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { name = "prettier" },
  {
    name = "djlint",
    args = { "--indent", '2' }
  }
}

-- local opts = {
--   filetypes = { "html", "htmldjango", "webc" }
-- }
-- require("lvim.lsp.manager").setup("tailwindcss", opts)
require("lvim.lsp.manager").setup("tailwindcss")

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

-- lvim.builtin.telescope.defaults.initial_mode = "insert"
-- lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.defaults.prompt_prefix = "  "
lvim.builtin.telescope.defaults.selection_caret = "❯ "
-- lvim.builtin.telescope.defaults.mappings.i["<esc>"] = actions.close
lvim.builtin.telescope.defaults.winblend = 10

-- lvim.builtin.telescope.defaults.borderchars = {
--   prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
--   results = { " ", " ", " ", " ", " ", " ", " ", " " },
--   preview = { " ", " ", " ", " ", " ", " ", " ", " " },
-- }

lvim.builtin.telescope.defaults.borderchars = {
  prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
  results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

-- lvim.builtin.telescope.defaults.layout_strategy = "vertical"
-- lvim.builtin.telescope.defaults                = {
--   vimgrep_arguments = {
--     "rg",
--     "--color=never",
--     "--no-heading",
--     "--with-filename",
--     "--line-number",
--     "--column",
--     "--smart-case",
--   },
--   prompt_prefix = "   ",
--   selection_caret = "  ",
--   entry_prefix = "  ",
--   initial_mode = "insert",
--   selection_strategy = "reset",
--   sorting_strategy = "ascending",
--   layout_strategy = "horizontal",
--   layout_config = {
--     horizontal = {
--       prompt_position = "top",
--       preview_width = 0.55,
--       results_width = 0.8,
--     },
--     vertical = {
--       mirror = false,
--     },
--     width = 0.87,
--     height = 0.80,
--     preview_cutoff = 120,
--   },
--   file_sorter = require("telescope.sorters").get_fuzzy_file,
--   file_ignore_patterns = { "node_modules" },
--   generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--   path_display = { "truncate" },
--   winblend = 0,
--   border = {},
--   borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--   color_devicons = true,
--   set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--   file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--   grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--   qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--   -- Developer configurations: Not meant for general override
--   buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
--   mappings = {
--     n = { ["q"] = require("telescope.actions").close },
--   }
-- }
-- lvim.builtin.treesitter.context_commentstring.enable_autocmd = true
-- lvim.builtin.treesitter.context_commentstring.config.lua = { "//%s", "[[%s]]" }

-- DISABLED since neotree is used instead
-- local function natural_cmp(left, right)
--   if left.type ~= "directory" and right.type == "directory" then
--     return false
--   elseif left.type == "directory" and right.type ~= "directory" then
--     return true
--   end

--   if left.type ~= "link" and right.type == "link" then
--     return false
--   elseif left.type == "link" and right.type ~= "link" then
--     return true
--   end

--   left = left.name:lower()
--   right = right.name:lower()

--   if left == right then
--     return false
--   end


--   for i = 1, math.max(string.len(left), string.len(right)), 1 do
--     local l = string.sub(left, i, -1)
--     local r = string.sub(right, i, -1)

--     if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
--       local l_number = tonumber(string.match(l, "^[0-9]+"))
--       local r_number = tonumber(string.match(r, "^[0-9]+"))

--       if l_number ~= r_number then
--         return l_number < r_number
--       end
--     elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
--       return l < r
--     end
--   end
-- end

-- lvim.builtin.nvimtree.setup.sort_by = function(nodes)
--   table.sort(nodes, natural_cmp)
-- end

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
}
