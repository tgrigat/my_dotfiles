local status_ok, ultisnips = pcall(require, "ultisnips")
if not status_ok then
  return
end

vim.cmd [[
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
]]



