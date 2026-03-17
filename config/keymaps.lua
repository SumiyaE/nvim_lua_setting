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

-- ===== Claude Code通知 =====
keymap("n", "<leader>an", "<cmd>ClaudeNotify<cr>", {
	desc = "Send Claude Code notification",
})
