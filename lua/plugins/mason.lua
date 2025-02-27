return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- 自动安装的 LSP/DAP 列表
      ensure_installed = {
        -- Vue
        "vue-language-server",

        -- Web 基础
        "html-lsp",
        "css-lsp",
        "emmet-language-server",

        -- JavaScript/TypeScript
        "typescript-language-server",

        -- Node.js 相关
        "js-debug-adapter", -- 调试支持（可选）
      },

      -- 自动更新注册表
      -- registries = {
      --   "github:mason-org/mason-registry",
      -- },

      providers = {
        npm = {
          cmd = { "npm", "--userconfig", os.getenv("HOME") .. "/.npmrc" }, -- 显式指定 npm 配置
          install_script = [[
            npm install -g ${package}@${version}
          ]],
        },
      },

      -- 其他 Mason 配置
      ui = {
        icons = {
          package_installed = "✓",
        },
      },
    },
  },
}
