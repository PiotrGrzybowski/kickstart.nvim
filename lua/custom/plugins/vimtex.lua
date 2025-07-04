return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_method = 'latexmk'
    -- vim.g.vimtex_root_markers = { 'main.tex' }
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      out_dir = 'build',
      aux_dir = 'build',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end,
}
