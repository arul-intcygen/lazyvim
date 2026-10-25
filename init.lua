-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.o.number = true
vim.o.relativenumber = false
vim.opt.clipboard = "unnamedplus"

-- ==========================================================
-- LOGIKA KONDISIONAL (VS Code vs Terminal)
-- Menggunakan pendekatan "Environment Awareness"
-- ==========================================================
if vim.g.vscode then
  -- --- PENGATURAN KHUSUS VS CODE ---
  -- Mengatasi "Snap Back" saat klik setelah scroll
  vim.opt.scrolloff = 0
  -- Mengatasi glitch saat seleksi teks (Normal Mode)
  vim.opt.mouse = ""
else
  -- --- PENGATURAN KHUSUS TERMINAL ---
  -- Memberikan jarak pandang 8 baris saat scrolling di terminal
  vim.opt.scrolloff = 8
end
