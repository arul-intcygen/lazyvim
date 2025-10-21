-- plugins/autopairs.lua

return {
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
  -- plugin autopairs favoritmu
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
}
