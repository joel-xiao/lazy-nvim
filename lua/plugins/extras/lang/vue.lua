
return {
  -- 配置 LSP 插件，添加 volar 和 tsserver 配置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Vue 3 使用 volar
        volar = {
          enabled = true,  -- 启用 Vue 3 项目使用 volar
          init_options = {
            vue = {
              hybridMode = true,  -- 启用 hybridMode 支持 Vue 的 <script> 和 <template>
            },
          },
        },

        -- Vue 2 使用 vls
        vls = {
          enabled = true,  -- 启用 Vue Language Server
        },

        -- 确保 tsserver 插件启用，支持 JavaScript 和 TypeScript 提示
        tsserver = {
          enabled = true,  -- 启用 tsserver 插件
        },
      },
    },
  },
}
