--- Menonaktifkan modul mini-pairs

return {
  -- Menimpa/Override Plugin inti LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      -- Menonaktifkan modul mini.pairs
      colorscheme = "tokyonight", -- tetap pertahankan warna skema kamu
      -- Tambahkan opsi untuk menonaktifkan mini.pairs
      defaults = {
        -- ini menonaktifkan fitur mini.pairs yang ada di plugin inti LazyVim
        -- 'pairs' adalah nama modul di mini.nvim
        pairs = false,
      },
    },
  },
}
