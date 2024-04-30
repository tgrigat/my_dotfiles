---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>ty"] = { function() require("yazi").yazi() end, desc = "Yazi" },
          },
        },
      },
    },
  },
}
