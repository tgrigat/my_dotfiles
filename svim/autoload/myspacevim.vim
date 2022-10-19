" function! myspacevim#before() abort
"     let g:neomake_c_enabled_makers = ['clang']
"     " you can defined mappings in bootstrap function
"     " for example, use kj to exit insert mode.
"     inoremap kj <Esc>
" endfunction
"
"

function! myspacevim#before() abort
let g:pydocstring_doq_path = '/home/yang/.local/bin/doq'
let g:pydocstring_formatter = 'google'
call SpaceVim#custom#SPC('nnoremap', ['h', 's'], 'help spacevim', 'Show spacevim doc', 1)
" for ultisnip
endfunction


function! myspacevim#after() abort
    " " you can remove key binding in bootstrap_after function
" call doge#install()
" iunmap kj
let g:doge_doc_standard_python = 'numpy'
let g:doge_mapping = '<Leader>d'
set wrap
let g:CtrlSpaceProjectRootMarkers = [
     \ ".cs_workspaces",
     \ ".git",
     \ ]
let g:vimtex_view_method = 'zathura'
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
"
" change tab to 4 spaces
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" clipboard setting
set clipboard+=unnamedplus

call SpaceVim#custom#SPC('nnoremap', ['l', 'u'], 'UltiSnipsEdit', 'Add Ultisnippet', 1)
" lua setup
lua << EOF
require'lspconfig'.clang.setup{}
require'lspconfig'.pyright.setup{}
EOF
endfunction

