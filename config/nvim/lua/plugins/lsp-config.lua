return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["ruby_ls"] = function()
          _timers = {}

          -- textDocument/diagnostic support until 0.10.0 is released
          local setup_diagnostics = function(client, buffer)
            if require("vim.lsp.diagnostic")._enable then
              return
            end

            local diagnostic_handler = function()
              local params =
                  vim.lsp.util.make_text_document_params(buffer)
              client.request(
                "textDocument/diagnostic",
                { textDocument = params },
                function(err, result)
                  if err then
                    local err_msg = string.format(
                      "diagnostics error - %s",
                      vim.inspect(err)
                    )
                    vim.lsp.log_error(err_msg)
                  end
                  local diagnostic_items = {}
                  if result then
                    diagnostic_items = result.items
                  end
                  vim.lsp.diagnostic.on_publish_diagnostics(
                    nil,
                    vim.tbl_extend(
                      "keep",
                      params,
                      { diagnostics = diagnostic_items }
                    ),
                    { client_id = client.id }
                  )
                end
              )
            end

            diagnostic_handler()

            vim.api.nvim_buf_attach(buffer, false, {
              on_lines = function()
                if _timers[buffer] then
                  vim.fn.timer_stop(_timers[buffer])
                end
                _timers[buffer] =
                    vim.fn.timer_start(200, diagnostic_handler)
              end,
              on_detach = function()
                if _timers[buffer] then
                  vim.fn.timer_stop(_timers[buffer])
                end
              end,
            })
          end

          -- adds ShowRubyDeps command to show dependencies in the quickfix list.
          -- add the `all` argument to show indirect dependencies as well
          local add_ruby_deps_command = function(client, buffer)
            vim.api.nvim_buf_create_user_command(
              buffer,
              "ShowRubyDeps",
              function(opts)
                local params =
                    vim.lsp.util.make_text_document_params()
                local show_all = opts.args == "all"

                client.request(
                  "rubyLsp/workspace/dependencies",
                  params,
                  function(err, result)
                    if err then
                      print("Error showing deps: " .. err)
                      return
                    end

                    local qf_list = {}
                    for _, item in ipairs(result) do
                      if show_all or item.dependency then
                        table.insert(qf_list, {
                          text = string.format(
                            "%s (%s) - %s",
                            item.name,
                            item.version,
                            item.dependency
                          ),
                          filename = item.path,
                        })
                      end
                    end

                    vim.fn.setqflist(qf_list)
                    vim.cmd("copen")
                  end,
                  buffer
                )
              end,
              {
                nargs = "?",
                complete = function()
                  return { "all" }
                end,
              }
            )
          end

          lspconfig.ruby_ls.setup({
            capabilities = capabilities,
            on_attach = function(client, buffer)
              setup_diagnostics(client, buffer)
              add_ruby_deps_command(client, buffer)
            end,
          })
        end,
        ["rubocop"] = function()
          lspconfig.rubocop.setup({
            capabilities = capabilities,
            cmd = {
              "bundle",
              "exec",
              "rubocop",
              "--lsp",
            },
          })
        end,
        ["solargraph"] = function()
          lspconfig.solargraph.setup({
            capabilities = capabilities,
            cmd = {
              "mise",
              "exec",
              "ruby",
              "--",
              "solargraph",
              "stdio",
            },
          })
        end,
      },
    })

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, {
        buffer = true,
        remap = false,
        desc = "LSP: " .. desc,
      })
    end

    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  end,
}
