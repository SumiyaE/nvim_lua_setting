-- ===================================================================
-- lazy.nvim セットアップ
-- ===================================================================
-- このファイルはlazy.nvimのブートストラップとプラグイン読み込みを管理します
-- 設定は以下のファイルに分割されています：
--   - config/options.lua: グローバル設定
--   - config/keymaps.lua: グローバルキーマッピング
--   - config/autocmds.lua: Autocmd定義

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

-- Load configuration modules
require("config.options") -- グローバル設定
require("config.keymaps") -- グローバルキーマッピング
require("config.autocmds") -- Autocmd定義

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
})
