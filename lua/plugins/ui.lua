return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.statuscolumn = opts.statuscolumn or {}
      opts.statuscolumn.enabled = true

      opts.image = opts.image or {}
      opts.image.enabled = true
      return opts
    end,
  }
}
