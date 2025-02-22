return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      intelephense = {
        enabled = true,
        settings = {
          filetypes = { "php", "blade" },
          settings = {
            intelephense = {
              filetypes = { "php", "blade" },
              files = {
                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                maxSize = 5000000,
              },
            },
          },
        },
      },
      jdtls = {
        enabled = true,
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = "JavaSE-17", path = "/path/to/java17", default = true },
                { name = "JavaSE-11", path = "/path/to/java11" },
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              hashCodeEquals = {
                useInstanceof = true,
              },
              useBlocks = true,
            },
          },
        },
        -- keys = {
        --   {
        --     "<leader>cj",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })
        --     end,
        --     desc = "Organize Imports (Java)",
        --   },
        --   {
        --     "<leader>cg",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.generate" } } })
        --     end,
        --     desc = "Generate Code (Java)",
        --   },
        --   {
        --     "<leader>cc",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "refactor.extract.function" } } })
        --     end,
        --     desc = "Extract Function (Java)",
        --   },
        --   {
        --     "<leader>cv",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "refactor.extract.variable" } } })
        --     end,
        --     desc = "Extract Variable (Java)",
        --   },
        --   {
        --     "<leader>cr",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "refactor.rename" } } })
        --     end,
        --     desc = "Rename (Java)",
        --   },
        --   {
        --     "<leader>ci",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.generate.accessors" } } })
        --     end,
        --     desc = "Generate Accessors",
        --   },
        --   {
        --     "<leader>cC",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.generate.constructors" } } })
        --     end,
        --     desc = "Generate Constructors",
        --   },
        --   {
        --     "<leader>cH",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.generate.hashCodeEquals" } } })
        --     end,
        --     desc = "Generate hashCode & equals",
        --   },
        --   {
        --     "<leader>cT",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "source.generate.toString" } } })
        --     end,
        --     desc = "Generate toString",
        --   },
        --   {
        --     "<leader>cm",
        --     function()
        --       vim.lsp.buf.code_action({ context = { only = { "refactor.move" } } })
        --     end,
        --     desc = "Move (Java)",
        --   },
        -- },
      },
      volar = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },

      vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
        keys = {
          {
            "gD",
            function()
              local params = vim.lsp.util.make_position_params()
              LazyVim.lsp.execute({
                command = "typescript.goToSourceDefinition",
                arguments = { params.textDocument.uri, params.position },
                open = true,
              })
            end,
            desc = "Goto Source Definition",
          },
          {
            "gR",
            function()
              LazyVim.lsp.execute({
                command = "typescript.findAllFileReferences",
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              })
            end,
            desc = "File References",
          },
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
          {
            "<leader>cM",
            LazyVim.lsp.action["source.addMissingImports.ts"],
            desc = "Add missing imports",
          },
          {
            "<leader>cu",
            LazyVim.lsp.action["source.removeUnused.ts"],
            desc = "Remove unused imports",
          },
          {
            "<leader>cD",
            LazyVim.lsp.action["source.fixAll.ts"],
            desc = "Fix all diagnostics",
          },
          {
            "<leader>cV",
            function()
              LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
            end,
            desc = "Select TS workspace version",
          },
        },
      },
    },
    setup = {
      eslint = function()
        -- disable eslint
        return true
      end,
      cssls = function()
        -- disable cssls
        return true
      end,
      tsserver = function()
        -- disable tsserver
        return true
      end,
      vtsls = function(_, opts)
        LazyVim.lsp.on_attach(function(client, buffer)
          client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
            ---@type string, string, lsp.Range
            local action, uri, range = unpack(command.arguments)

            local function move(newf)
              client.request("workspace/executeCommand", {
                command = command.command,
                arguments = { action, uri, range, newf },
              })
            end

            local fname = vim.uri_to_fname(uri)
            client.request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = {
                "getMoveToRefactoringFileSuggestions",
                {
                  file = fname,
                  startLine = range.start.line + 1,
                  startOffset = range.start.character + 1,
                  endLine = range["end"].line + 1,
                  endOffset = range["end"].character + 1,
                },
              },
            }, function(_, result)
              ---@type string[]
              local files = result.body.files
              table.insert(files, 1, "Enter new path...")
              vim.ui.select(files, {
                prompt = "Select move destination:",
                format_item = function(f)
                  return vim.fn.fnamemodify(f, ":~:.")
                end,
              }, function(f)
                if f and f:find("^Enter new path") then
                  vim.ui.input({
                    prompt = "Enter move destination:",
                    default = vim.fn.fnamemodify(fname, ":h") .. "/",
                    completion = "file",
                  }, function(newf)
                    return newf and move(newf)
                  end)
                elseif f then
                  move(f)
                end
              end)
            end)
            table.insert(opts.servers.vtsls.filetypes, "vue")
            LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
              {
                name = "@vue/typescript-plugin",
                location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              },
            })
          end
        end, "vtsls")

        -- copy typescript settings to javascript
        opts.settings.javascript =
          vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
      end,
      jdtls = function(_, opts)
        return true
      end,
    },
  },
}
