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
vim.g.maplocalleader = "\\"

-- 行番号の表示
vim.opt.number = true

-- set space tab
vim.opt.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- nnoremap <silent> tt <cmd>terminal<CR>に相当。
-- 新規タブでターミナルモードを起動
-- vim.keymap.set('n', 'tt', '<cmd>terminal<CR>', {silent = true})
vim.keymap.set("n", "tt", "<cmd>tabnew | terminal<CR>", { silent = true })
-- 下分割でターミナルモードを起動
vim.keymap.set("n", "tx", "<cmd>belowright new<CR><cmd>terminal<CR>", { silent = true })

-- tnoremap <ESC> <c-\><c-n>に相当。
-- ターミナルモードでESCでノーマルモードに戻る
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>", { silent = true })

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

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})
