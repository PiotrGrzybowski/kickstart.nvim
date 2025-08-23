-- lua/tag_ref_lsp.lua
local M = {}

-- Function to extract tags from the current buffer
function M.get_tags()
  local tags = {}
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    for tag in line:gmatch '\\tag{(.-)}' do
      table.insert(tags, tag)
    end
  end
  return tags
end

-- Function to provide completion for \ref{}
function M.complete_ref(findstart, base)
  if findstart == 1 then
    -- Completion start position
    local cursor_pos = vim.fn.col '.' - 1
    local line = vim.fn.getline '.'
    local ref_start = line:sub(1, cursor_pos):find '\\ref{[^}]*$'
    return ref_start or -1
  else
    -- Provide the actual completion items
    local tags = M.get_tags()
    local matches = {}
    for _, tag in ipairs(tags) do
      if tag:match('^' .. base) then
        table.insert(matches, tag)
      end
    end
    return matches
  end
end

-- Setup omnifunc for Markdown
function M.setup()
  vim.api.nvim_command 'setlocal omnifunc=v:lua.require"tag_ref_lsp".complete_ref'
end

return M
