-- plugins/autopairs.lua

return {
  "windwp/nvim-autopairs", -- Plugin nvim-autopairs
  event = "InsertEnter",
  -- Menggunakan 'keys' untuk konfigurasi dasar
  config = function()
    -- Memastikan nvim-autopairs diaktifkan dengan konfigurasi default yang sudah cerdas
    require("nvim-autopairs").setup({})
  end,
}
