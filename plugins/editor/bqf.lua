return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  opts = {
    auto_enable = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border = "rounded",
      winblend = 0,
    },
    func_map = {
      open = "<CR>",
      openc = "o",
      split = "<C-s>",
      vsplit = "<C-v>",
      tab = "t",
      prevfile = "<C-p>",
      nextfile = "<C-n>",
      prevhist = "<",
      nexthist = ">",
      stoggleup = "K",
      stoggledown = "J",
      quit = "q",
    },
  },
  config = function(_, opts)
    require("bqf").setup(opts)

    -- quickfix用のキーマップ
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "qf",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Y: 相対パス:行番号をコピー
        vim.keymap.set("n", "Y", function()
          local line = vim.fn.line(".")
          local qflist = vim.fn.getqflist()
          if qflist[line] then
            local item = qflist[line]
            local filepath = vim.fn.bufname(item.bufnr)
            local relative = vim.fn.fnamemodify(filepath, ":.")
            local result = relative .. ":" .. item.lnum
            vim.fn.setreg("+", result)
            vim.notify("Copied: " .. result)
          end
        end, { buffer = bufnr, desc = "Copy relative path:line" })

        -- gy: 絶対パス:行番号をコピー
        vim.keymap.set("n", "gy", function()
          local line = vim.fn.line(".")
          local qflist = vim.fn.getqflist()
          if qflist[line] then
            local item = qflist[line]
            local filepath = vim.fn.bufname(item.bufnr)
            local absolute = vim.fn.fnamemodify(filepath, ":p")
            local result = absolute .. ":" .. item.lnum
            vim.fn.setreg("+", result)
            vim.notify("Copied: " .. result)
          end
        end, { buffer = bufnr, desc = "Copy absolute path:line" })

        -- <leader>gy: GitHubリンクをコピー
        vim.keymap.set("n", "<leader>gy", function()
          local line = vim.fn.line(".")
          local qflist = vim.fn.getqflist()
          if qflist[line] then
            local item = qflist[line]
            local filepath = vim.fn.bufname(item.bufnr)
            local absolute = vim.fn.fnamemodify(filepath, ":p")
            local lnum = item.lnum

            -- ファイルを開いてカーソルを移動
            vim.cmd("edit " .. vim.fn.fnameescape(absolute))
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })

            -- 少し遅延してGitLinkを実行
            vim.defer_fn(function()
              vim.cmd("GitLink")
            end, 100)
          end
        end, { buffer = bufnr, desc = "Copy GitHub link" })

        -- <leader>gY: GitHubリンクをブラウザで開く
        vim.keymap.set("n", "<leader>gY", function()
          local line = vim.fn.line(".")
          local qflist = vim.fn.getqflist()
          if qflist[line] then
            local item = qflist[line]
            local filepath = vim.fn.bufname(item.bufnr)
            local absolute = vim.fn.fnamemodify(filepath, ":p")
            local lnum = item.lnum

            -- ファイルを開いてカーソルを移動
            vim.cmd("edit " .. vim.fn.fnameescape(absolute))
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })

            -- 少し遅延してGitLink!を実行
            vim.defer_fn(function()
              vim.cmd("GitLink!")
            end, 100)
          end
        end, { buffer = bufnr, desc = "Open GitHub link in browser" })
      end,
    })
  end,
}
