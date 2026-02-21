return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- セッション復元: 不要バッファを掃除してから復元
		local function restore_session()
			-- 空の[No Name]バッファを削除
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == "" then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
			-- セッション復元
			require("persistence").load()
			-- 不要バッファを掃除 (alpha, neo-tree, ディレクトリ等)
			local cleanup_filetypes = { "alpha", "neo-tree", "NvimTree" }
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local ft = vim.bo[buf].filetype
				local bt = vim.bo[buf].buftype
				local name = vim.api.nvim_buf_get_name(buf)
				if
					vim.tbl_contains(cleanup_filetypes, ft)
					or (name == "" and bt == "")
					or (name ~= "" and vim.fn.isdirectory(name) == 1)
				then
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
				end
			end
			-- Treesitterハイライトを再適用（現在のバッファを再読み込み）
			vim.cmd("silent! edit")
		end
		_G.__alpha_restore_session = restore_session

		-- === 自動セッション復元 ===
		-- ファイル指定起動の場合はスキップ
		local has_file_args = false
		for _, arg in ipairs(vim.fn.argv()) do
			local stat = vim.uv.fs_stat(arg)
			if stat and stat.type == "file" then
				has_file_args = true
				break
			end
		end

		if not has_file_args then
			-- セッションファイルの存在チェック (persistence.nvim のパス組み立てを再現)
			local session_dir = vim.fn.stdpath("state") .. "/sessions/"
			local name = vim.fn.getcwd():gsub("[\\/:]+", "%%")

			-- ブランチ付きセッションを優先確認
			local branch_file = nil
			if vim.fn.isdirectory(".git") == 1 then
				local branch = vim.fn.systemlist("git branch --show-current")[1]
				if vim.v.shell_error == 0 and branch and branch ~= "main" and branch ~= "master" then
					branch_file = session_dir .. name .. "%%" .. branch:gsub("[\\/:]+", "%%") .. ".vim"
				end
			end

			local session_file = session_dir .. name .. ".vim"
			local target = (branch_file and vim.fn.filereadable(branch_file) == 1 and branch_file)
				or (vim.fn.filereadable(session_file) == 1 and session_file)

			if target then
				restore_session()
				return
			end
		end

		-- === セッションがない場合: alpha ダッシュボードを表示 ===
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")

		-- ヘッダーを大きく中央に
		startify.section.header.val = {
			[[                                                    ]],
			[[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
			[[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
			[[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
			[[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
			[[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
			[[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			[[                                                    ]],
		}
		startify.section.header.opts = { hl = "Type", position = "center" }

		-- ボタン
		startify.section.top_buttons.val = {
			startify.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
			startify.button("g", "  Find text", ":Telescope live_grep <CR>"),
			startify.button("s", "  Restore session", "<cmd>lua _G.__alpha_restore_session()<cr>"),
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		}

		startify.section.bottom_buttons.val = {
			startify.button("l", "󰒲  Lazy", ":Lazy <CR>"),
			startify.button("q", "  Quit", ":qa<CR>"),
		}

		-- カレントディレクトリの最近のファイル（10件）
		startify.section.mru_cwd.val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "  Recent Files (Current Directory)", opts = { hl = "SpecialComment", shrink_margin = false } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { startify.mru(0, vim.fn.getcwd(), 10) }
				end,
				opts = { shrink_margin = false },
			},
		}

		-- グローバルの最近のファイル（3件）
		startify.section.mru.val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "  Recent Files (Global)", opts = { hl = "SpecialComment", shrink_margin = false } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { startify.mru(10, false, 3) }
				end,
				opts = { shrink_margin = false },
			},
		}

		alpha.setup(startify.opts)

		-- nvim . でディレクトリを開いた場合、ディレクトリバッファを閉じてalphaを表示
		if vim.fn.argc(-1) == 1 then
			local stat = vim.uv.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				vim.cmd.bdelete()
				require("alpha").start()
			end
		end
	end,
}
