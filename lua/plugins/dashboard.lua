return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = "  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞  ",
        keys = {
          { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
          },
          { icon = " ", key = "s", desc = "Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
