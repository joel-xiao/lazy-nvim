return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --
      -- setup = {
      --   defaults = {
      --     capabilities = {
      --       documentFormattingProvider = false,
      --       documentRangeFormattingProvider = false,
      --     },
      --   },
      -- },

      -- 不再需要 ensure_installed 字段
      servers = {
        -- Vue3 (Volar)
        volar = {
          -- 关闭 Volar 自带的模板格式化
          init_options = {
            vue = {
              hybridMode = false,
              -- format = {
              --   enable = false, -- 彻底关闭 Vue 模板格式化
              -- },
            },
          },
          -- -- 阻止自动注册格式化命令
          -- commands = {
          --   VueFormatDocument = false,
          --   VueFormatSelection = false,
          -- },
          -- -- 关键配置：禁用所有格式化功能
          -- capabilities = {
          --   documentFormattingProvider = false,
          --   documentRangeFormattingProvider = false,
          -- },
        },

        -- HTML
        html = {
          filetypes = { "html" },
        },

        -- CSS/SCSS
        cssls = {
          filetypes = { "css", "scss" },
          settings = {
            css = {
              validate = true,
            },
            scss = {
              validate = true,
            },
          },
        },

        -- JavaScript/TypeScript
        tsserver = {
          filetypes = { "js", "ts" },
          root_dir = function()
            return vim.fn.getcwd()
          end,
          single_file_support = false,
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },

        -- Emmet 支持
        emmet_ls = {
          filetypes = { "html", "css", "scss" },
        },
      },
    },
  },
}
