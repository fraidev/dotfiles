-- on startup, check if there exists a local version of prettier
-- in the project and use that. Otherwise, use the global version.
local prettier_path = "./node_modules/.bin/prettier"
if vim.fn.executable(prettier_path) ~= 1 then
  prettier_path = "prettier"
end

function prettier_config()
  return {
    exe = prettier_path,
    args = {
      "--config-precedence",
      "prefer-file",
      "--stdin-filepath",
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    },
    stdin = true
  }
end

function gofmt_config()
  return {
    exe = "gofmt",
    stdin = true,
  }
end

function ocamlformat_config()
  return {
    exe = "ocamlformat",
    stdin = true,
    args = {
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    }
  }
end


require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {
        prettier_config
      },
      typescript = {
        prettier_config
      },
      ["typescript.tsx"] = {
        prettier_config
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      go = {
        gofmt_config
      },
      ocaml = {
        ocamlformat_config
      }
    }
  }
)

-- vim.api.nvim_exec(
--   [[
-- augroup fmt
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
-- " augroup FormatAutogroup
-- "   autocmd!
-- "   autocmd BufWritePost * FormatWrite
-- "   " autocmd BufWritePost * call timer_start(1000, { tid -> execute('FormatWrite')})
-- "   " autocmd BufWritePost *.js,*.ts,*.tsx FormatWrite
-- "   " autocmd BufWritePost *.lua FormatWrite
-- "   " autocmd BufWritePost *.go FormatWrite
-- "   " autocmd BufWritePost *.rs FormatWrite
-- "   " autocmd BufWritePost *.ml,*mli FormatWrite
-- " augroup END
-- ]],
--   true
-- )
