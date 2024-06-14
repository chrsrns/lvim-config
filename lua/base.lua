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
vim.opt.foldlevel = 1
vim.opt.foldclose = "all"

-- Show both absolute and relative line numbering
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "

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

-- Clear highlighting on escape
lvim.keys.normal_mode["<esc>"] = ':nohl<CR>'

-- Extended timeout for LSP format to 5s, since some formatters are too slow.
-- Without this, some formatters are killed before finishing.
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 5000 }
  end,
  "Format",
}
