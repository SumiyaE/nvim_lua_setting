return {
	-- mason: ツールの管理ui
	{
		"williamboman/mason.nvim",
		version = "^1.0.0", -- v1 系に固定
		config = true,
	},

	-- mason-lspconfig: mason と lspconfig の橋渡し
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0", -- v1 系に固定
		dependencies = {
			"neovim/nvim-lspconfig", -- 各言語のlsp設定ライブラリ
		},
		config = function()
			-- lspサーバーを自動でインストール
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "terraformls", "marksman", "clangd" },
			})

			-- lspサーバーを自動で lspconfig に渡す
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local opts = {
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					}

					-- .luaを起動した際に、"vim"のグローバル変数に対する警告を無視する。
					if server_name == "lua_ls" then
						opts.settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						}
					end
					require("lspconfig")[server_name].setup(opts)
				end,
			})
		end,
	},
}
