return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
      },
      adapters = {
        perplexity = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "perplexity",
            url = "https://api.perplexity.ai/",
            env = {
              api_key = os.getenv("PERPLEXITY_API_KEY"),
            },
          })
        end,
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },
}
