require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.api.nvim_set_keymap('i', '<S-Up>', '<Esc>vki', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '<Esc>vji', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Left>', '<Esc>vhi', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Right>', '<Esc>vli', { noremap = true })

vim.cmd("filetype plugin indent on")
vim.o.smartindent = true
vim.o.autoindent = true

vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move the selected lines down
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
