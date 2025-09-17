-- ~/.config/nvim/lua/plugins/nvim-comment.lua
return {
  "terrortylor/nvim-comment",
  config = function()
    require("nvim_comment").setup({
      line_mapping = "gcc", -- Mapping untuk komentar satu baris
      operator_mapping = "gc", -- Mapping untuk komentar banyak baris
    })
  end,
}
