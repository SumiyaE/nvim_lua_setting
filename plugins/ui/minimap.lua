return {
  "echasnovski/mini.map",
  event = "VeryLazy",
  keys = {
    { "<leader>mm", function() require("mini.map").toggle() end, desc = "Toggle minimap" },
  },
  opts = function()
    local map = require("mini.map")
    return {
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
      },
      window = {
        side = "right",
        width = 10,
        winblend = 15,
        show_integration_count = false,
      },
    }
  end,
  config = function(_, opts)
    local map = require("mini.map")
    map.setup(opts)
    map.open() -- 起動時に自動で開く
  end,
}
