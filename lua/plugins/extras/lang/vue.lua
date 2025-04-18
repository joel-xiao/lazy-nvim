
return {
  -- 配置 LSP 插件，添加 volar 和 tsserver 配置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,  -- 启用 hybridMode 支持 Vue 的 <script> 和 <template>
            },
          },
        },
        -- tsserver 插件禁用，确保只使用 volar
        vtsls = {},
      },
    },
  },

  -- 配置 tsserver 插件，确保 tsserver 支持 Vue 文件，且不会与 volar 冲突
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 确保 tsserver 支持 vue 文件
      table.insert(opts.servers.vtsls.filetypes, "vue")
      -- 添加 Vue TypeScript 插件配置
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@vue/typescript-plugin",
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
