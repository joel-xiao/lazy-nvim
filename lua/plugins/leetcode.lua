return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
      cn = {
        enabled = true,
        translator = true,
        translate_problems = true,
      },
      lang = 'javascript',
    },
}
