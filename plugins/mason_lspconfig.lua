return {
	-- Mason: ツールの管理UI
	{
		"williamboman/mason.nvim",
		config = true,
	},

	-- mason-lspconfig: mason と lspconfig の橋渡し
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig", -- 各言語のLSP設定ライブラリ
		},
		config = function()
			-- LSPサーバーを自動でインストール
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "terraformls", "marksman" },
			})

			-- LSPサーバーを自動で lspconfig に渡す
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
}
