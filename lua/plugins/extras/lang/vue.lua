-- npm install -g @vue/language-server
-- stylua: ignore
return {
  -- Vue 3 / Volar / @vue/language-server 配置
  {
    "neovim/nvim-lspconfig",
    -- @class PluginLspOpts
    opts = {
      -- @type lspconfig.options
      servers = {
        vuels = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              target = nil,
              hybridMode = true,
              optionsApi = { enabled = true },
            },
          },
          settings = {
            vue = {
              javascript = { enabled = true },
              template = {
                compilerOptions = { compatConfig = { MODE = 3 } },
              },
            },
          },
          -- 指定全局安装的 @vue/language-server 路径
          cmd = { "vue-language-server", "--stdio" },
        },
      },
    },
  },
}
