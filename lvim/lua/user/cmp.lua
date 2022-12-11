-- local cmp = require("lvim.core.cmp")
local cmp = require("cmp")

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { {
        name = "buffer",
    } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- local hi = vim.api.nvim_set_hl

-- hi(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
-- hi(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

-- hi(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
-- hi(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

-- hi(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
-- hi(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

-- hi(0, "CmpItemKindField", { fg = "#B5585F", bg = "NONE" })
-- hi(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
-- hi(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

-- hi(0, "CmpItemKindText", { fg = "#9FBD73", bg = "NONE" })
-- hi(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
-- hi(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

-- hi(0, "CmpItemKindConstant", { fg = "#D4BB6C", bg = "NONE" })
-- hi(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
-- hi(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

-- hi(0, "CmpItemKindFunction", { fg = "#A377BF", bg = "NONE" })
-- hi(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
-- hi(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
-- hi(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
-- hi(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

-- hi(0, "CmpItemKindVariable", { fg = "#7E8294", bg = "NONE" })
-- hi(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

-- hi(0, "CmpItemKindUnit", { fg = "#D4A959", bg = "NONE" })
-- hi(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
-- hi(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

-- hi(0, "CmpItemKindMethod", { fg = "#6C8ED4", bg = "NONE" })
-- hi(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
-- hi(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

-- hi(0, "CmpItemKindInterface", { fg = "#58B5A8", bg = "NONE" })
-- hi(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
-- hi(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
