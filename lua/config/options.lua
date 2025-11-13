vim.g.python3_host_prog = '~/.venvs/myenv/bin/python'
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    print("Neovim 当前用的 Python 环境：" .. vim.g.python3_host_prog)
  end
})

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- This file is automatically loaded by plugins.core
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- LazyVim auto format
vim.g.autoformat = false
vim.b.autoformat = false

vim.opt.guifont = {
  "JetBrainsMonoNL Nerd Font Propo:h14",
  "JetBrainsMono Nerd Font:h14",
  "JetBrains Mono:h14"
}

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
-- vim.g.ai_cmp = false

-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = true

-- 修复浮窗 / 图片偏移问题(禁用 noice.nvim 内置的 “WezTerm 偏移补偿” 逻辑)
vim.g.noice_no_wezterm_hack = true
