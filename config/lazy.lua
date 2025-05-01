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

-- 行番号の表示
vim.opt.number = true

-- nvim-treeを使用するため、netrwを無効化
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)

-- nnoremap <silent> tt <cmd>terminal<CR>に相当。
-- 新規タブでターミナルモードを起動
-- vim.keymap.set('n', 'tt', '<cmd>terminal<CR>', {silent = true})
vim.keymap.set("n", "tt", "<cmd>tabnew | terminal<CR>", { silent = true })
-- 下分割でターミナルモードを起動
vim.keymap.set("n", "tx", "<cmd>belowright new<CR><cmd>terminal<CR>", { silent = true })

-- tnoremap <ESC> <c-\><c-n>に相当。
-- ターミナルモードでESCでノーマルモードに戻る
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>", { silent = true })

-- bufferを切り替えるためのキーマッピング
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true }) -- 次のバッファ
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true }) -- 前のバッファ
vim.keymap.set("n", "<C-x>", ":bd<CR>", { noremap = true, silent = true }) -- バッファを閉じる

--vim.api.nvim_create_autocmd("FileType", {
--	pattern = "markdown",
--	callback = function()
--		vim.opt_local.conceallevel = 2
--	end,
--})

-- Telescopeの設定
vim.keymap.set("n", "sf", '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true })
vim.keymap.set("n", "sb", '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true })
vim.keymap.set("n", "sh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', { noremap = true })

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

-- ターミナルモードで起動時にinsertモードにする
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	command = "startinsert",
})
-- eqaul to below setting
-- vim.cmd 'autocmd TermOpen * startinsert'

-- ターミナルモードで起動時に行番号を非表示にする
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})

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

-- set space tab
-- vim.opt.expandtab = true
-- vim.o.tabstop = 2
-- vim.o.shiftwidth = 2
-- vim.o.softtabstop = 2
