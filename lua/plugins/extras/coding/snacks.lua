return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.cmdline = opts.cmdline or {}
      opts.cmdline.enabled = not vim.g.lazyvim_blink_main
      return opts
    end,
  }
}

