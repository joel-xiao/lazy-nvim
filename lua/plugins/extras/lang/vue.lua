
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          enabled = true,
          filetypes = { "vue" },
          init_options = {
            vue = {
              target = nil,
              hybridMode = true,
              optionsApi = {
                enabled = true
              }
            }
          },
          settings = {
            vue = {
              javascript = {
                enabled = true
              },
              -- typescript = {
              --   enabled = false
              -- },
              template = {
                compilerOptions = {
                  compatConfig = {
                    MODE = 3
                  }
                }
              }
            }
          }
        },

        -- tsserver = {
        --   enabled = false
        -- }
      },
    },
  },
}
