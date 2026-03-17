return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope: Find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope: Live grep" },
		{ "<leader>fg", '"zy<cmd>Telescope grep_string search=<C-r>z<CR>', mode = "v", desc = "Telescope: Grep selection" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Telescope: Find buffers" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope: Help tags" },
		{ "<leader>fr", function() require("telescope.builtin").resume() end, desc = "Telescope: Resume last search" },
		{ "<leader>fo", function() require("telescope.builtin").oldfiles({ only_cwd = true, include_current_session = true }) end, desc = "Telescope: Recent files (cwd)" },
		{ "<leader>fO", function() require("telescope.builtin").oldfiles({ include_current_session = true }) end, desc = "Telescope: Recent files (global)" },
	},
	opts = {
		defaults = {
			file_ignore_patterns = { "%.git/" },
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	},
}
