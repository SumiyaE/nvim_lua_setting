-- ===================================================================
-- グローバルキーマッピング設定
-- ===================================================================
-- このファイルはプラグインに依存しないグローバルなキーマッピングを管理します

local keymap = vim.keymap.set

-- ===== モード切替 =====
keymap("i", "jj", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "Exit insert mode",
})

-- ===== バッファ操作 =====
keymap("n", "<Tab>", ":bnext<CR>", {
	noremap = true,
	silent = true,
	desc = "Next buffer",
})

keymap("n", "<S-Tab>", ":bprevious<CR>", {
	noremap = true,
	silent = true,
	desc = "Previous buffer",
})

keymap("n", "<C-x>", ":bd<CR>", {
	noremap = true,
	silent = true,
	desc = "Close buffer",
})

-- ===== LSP =====
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {
	desc = "LSP: Go to references",
})

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {
	desc = "LSP: Go to definition",
})

-- ===== Markdown画像貼り付け =====
keymap("i", "vv", function()
	vim.api.nvim_input("<Esc>")
	local output = vim.fn.system("paste_image_on_vim_markdown")
	vim.fn.setline(".", vim.trim(output))
end, {
	noremap = true,
	silent = true,
	desc = "Insert image from clipboard (Markdown)",
})

-- ===== ファイル参照コピー =====
-- 共通関数: パスと行番号をコピー
local function copy_file_reference(use_absolute_path)
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local path = use_absolute_path and vim.fn.expand("%:p") or vim.fn.expand("%:.")
	local result
	if start_line == end_line then
		result = path .. ":" .. start_line
	else
		result = path .. ":" .. start_line .. "-" .. end_line
	end

	vim.fn.setreg("+", result)
	vim.notify("Copied: " .. result, vim.log.levels.INFO)

	-- ビジュアルモード終了
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "n", false)
end

-- 相対パス
keymap("v", "<leader>yr", function()
	copy_file_reference(false)
end, {
	noremap = true,
	silent = true,
	desc = "Copy file:line reference (relative)",
})

-- 絶対パス
keymap("v", "<leader>yR", function()
	copy_file_reference(true)
end, {
	noremap = true,
	silent = true,
	desc = "Copy file:line reference (absolute)",
})
