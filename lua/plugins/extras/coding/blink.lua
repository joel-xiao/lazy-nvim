return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.cmdline = opts.cmdline or {}
      opts.cmdline.enabled = true
      return opts
    end,
  }
}
