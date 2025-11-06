return {
	"williamboman/mason.nvim",
	version = "^1.0.0", -- v1 系に固定
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- mason自体のセットアップ
		require("mason").setup()

		-- mason-lspconfigのセットアップ
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
}
