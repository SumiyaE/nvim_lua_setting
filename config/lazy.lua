-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "

-- leaderキーの反応速度を上げる（デフォルト: 1000ms → 300ms）
vim.opt.timeoutlen = 300

-- 行番号の表示
vim.opt.number = true

-- nvim-treeを使用するため、netrwを無効化
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)

-- ウィンドウ移動とリサイズは smart-splits.nvim で管理
-- （plugins/smart-splits.lua を参照）

-- bufferを切り替えるためのキーマッピング
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true }) -- 次のバッファ
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true }) -- 前のバッファ
vim.keymap.set("n", "<C-x>", ":bd<CR>", { noremap = true, silent = true }) -- バッファを閉じる

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 1
	end,
})

-- LSPの診断表示設定（エラーや警告の表示）
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- LSPの設定
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")

-- jjでインサートモードからノーマルモードに変更
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- vvでクリップボードの画像をマークダウン形式で貼り付け
-- vim.keymap.set('i', 'vv', function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
--   vim.cmd('r! paste_image_on_vim_markdown')
-- end, { noremap = true, silent = true, desc = "Insert image from clipboard (Markdown)" })
vim.keymap.set("i", "vv", function()
	vim.api.nvim_input("<Esc>")
	local output = vim.fn.system("paste_image_on_vim_markdown")
	vim.fn.setline(".", vim.trim(output))
end, { noremap = true, silent = true, desc = "Insert image from clipboard (Markdown)" })

vim.opt.termguicolors = true

-- システムクリップボードを使用
vim.opt.clipboard:append({ "unnamedplus" })

-- 保存時に view を保存
-- こうすることで、vimを終了しても折りたたみやカーソル位置が保存される
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("mkview")
		end
	end,
})

-- 読み込み時に view を読み込む
-- こうすることで、vimを起動するたびに折りたたみやカーソル位置が復元される
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" and not vim.bo.buftype:match("nofile") then
			vim.cmd("silent! loadview")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- view にオプションを保存しない
vim.opt.viewoptions:remove("options")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})
