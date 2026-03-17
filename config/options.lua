-- ===================================================================
-- Neovim基本設定
-- ===================================================================
-- このファイルはNeovimのグローバル設定を管理します

local opt = vim.opt
local g = vim.g

-- ===== Leader設定 =====
g.mapleader = " "

-- ===== netrw無効化（neo-treeで置き換え） =====
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- ===== タイミング設定 =====
opt.timeoutlen = 300 -- leaderキーの反応速度

-- ===== UI設定 =====
opt.number = true -- 行番号の表示
opt.cursorline = true -- カーソル行をハイライト
opt.termguicolors = true -- True colorサポート
opt.conceallevel = 1 -- Obsidian.nvimのUI機能用

-- ===== ファイル保護設定 =====
opt.swapfile = false -- スワップファイルを無効化（git + undofileで十分）
opt.undofile = true -- undo履歴をファイルに保存（Neovim再起動後もundo可能）

-- ===== 編集設定 =====
opt.clipboard:append({ "unnamedplus" }) -- システムクリップボードを使用

-- タブ設定（グローバル）
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- ===== セッション設定 =====
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ===== View設定 =====
opt.viewoptions:remove("options") -- viewにオプションを保存しない

-- ===== LSP診断設定 =====
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
