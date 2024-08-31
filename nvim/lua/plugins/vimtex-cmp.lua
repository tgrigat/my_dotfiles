return {
  "micangl/cmp-vimtex",
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      opts = {
        sources = {
          { name = "vimtex" },
        },
      },
    },
  },
}
