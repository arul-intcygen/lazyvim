---@diagnostic disable: undefined-global
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opt = { silent = true, noremap = true }
local map = vim.api.nvim_set_keymap
map("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<CR>', opt)
map("n", "<leader>bco", ":BufferLineCloseOthers<CR>", opt)
map("i", "<C-e>", "<Esc>A", opt)

-- ========== FLOATING WINDOW PREVIEW FUNCTION ==========
local function preview_lines_in_float(start_line, end_line)
  local current_buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buf, start_line - 1, end_line, false)

  -- Create floating buffer
  local float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)

  -- Set buffer options
  vim.api.nvim_buf_set_option(float_buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(float_buf, "filetype", vim.bo.filetype)

  -- Calculate window size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.8))

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    anchor = "NW",
    style = "minimal",
    border = "rounded",
    title = string.format("Lines %d-%d Preview", start_line, end_line),
    title_pos = "center",
  }

  local win = vim.api.nvim_open_win(float_buf, true, opts)

  -- Set window options
  vim.api.nvim_win_set_option(win, "cursorline", true)
  vim.api.nvim_win_set_option(win, "number", true)

  -- Close with q or Escape
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = float_buf })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = float_buf })
end

-- ========== PREVIEW KEYMAPS ==========
-- Interactive preview with input
vim.keymap.set("n", "<leader>pv", function()
  vim.ui.input({ prompt = "Start line: " }, function(start)
    if start then
      vim.ui.input({ prompt = "End line: " }, function(stop)
        if stop then
          preview_lines_in_float(tonumber(start), tonumber(stop))
        end
      end)
    end
  end)
end, { desc = "Preview lines in floating window" })

-- Quick shortcuts
vim.keymap.set("n", "<leader>p1", function()
  preview_lines_in_float(1, 20)
end, { desc = "Preview first 20 lines" })

vim.keymap.set("n", "<leader>pt", function()
  local total = vim.api.nvim_buf_line_count(0)
  preview_lines_in_float(math.max(1, total - 19), total)
end, { desc = "Preview last 20 lines" })

-- ========== PREVIEW COMMAND ==========
vim.api.nvim_create_user_command("PreviewLines", function(opts)
  local range = opts.args
  local start_line, end_line = range:match("(%d+),(%d+)")

  if start_line and end_line then
    preview_lines_in_float(tonumber(start_line), tonumber(end_line))
  else
    vim.notify("Usage: :PreviewLines start,end (e.g., :PreviewLines 1,10)")
  end
end, {
  nargs = 1,
  desc = "Preview lines in floating window",
})

-- FLOATING WINDOW EDIT FUNCTION
local function edit_lines_in_float(start_line, end_line)
  local current_buf = vim.api.nvim_get_current_buf()
  -- Ambil isi baris yang ingin diedit
  local lines = vim.api.nvim_buf_get_lines(current_buf, start_line - 1, end_line, false)

  -- Buat buffer baru untuk editing (buffer normal, bukannya [nofile])
  local edit_buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_lines(edit_buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(edit_buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(edit_buf, "filetype", vim.bo.filetype)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.8))
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    anchor = "NW",
    style = "minimal",
    border = "rounded",
    title = string.format("Edit Lines %d-%d", start_line, end_line),
    title_pos = "center",
  }
  local win = vim.api.nvim_open_win(edit_buf, true, opts)
  vim.api.nvim_win_set_option(win, "cursorline", true)
  vim.api.nvim_win_set_option(win, "number", true)

  -- Keymap untuk simpan hasil edit kembali ke buffer asal
  vim.keymap.set("n", "<leader>se", function()
    local new_lines = vim.api.nvim_buf_get_lines(edit_buf, 0, -1, false)
    vim.api.nvim_buf_set_lines(current_buf, start_line - 1, end_line, false, new_lines)
    vim.api.nvim_win_close(win, true)
  end, { buffer = edit_buf, desc = "Save EditLines to main buffer" })

  -- Keymap untuk batal/keluar tanpa menyimpan perubahan
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = edit_buf })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = edit_buf })
end

vim.keymap.set("n", "<leader>ev", function()
  vim.ui.input({ prompt = "Start line (edit): " }, function(start)
    if start then
      vim.ui.input({ prompt = "End line (edit): " }, function(stop)
        if stop then
          edit_lines_in_float(tonumber(start), tonumber(stop))
        end
      end)
    end
  end)
end, { desc = "Edit lines in floating window" })

-- Keymap "EditLines"
vim.api.nvim_create_user_command("EditLines", function(opts)
  local range = opts.args
  local start_line, end_line = range:match("(%d+),(%d+)")
  if start_line and end_line then
    edit_lines_in_float(tonumber(start_line), tonumber(end_line))
  else
    vim.notify("Usage: :EditLines start,end (e.g., :EditLines 5,20)")
  end
end, {
  nargs = 1,
  desc = "Edit lines in floating window",
})
