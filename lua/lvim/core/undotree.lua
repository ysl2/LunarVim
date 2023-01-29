local M = {}

function M.setup()
  vim.g.undotree_WindowLayout = 3
  if vim.fn.has('persistent_undo') == 1 then
    local target_path = vim.fn.expand(vim.fn.stdpath('data') .. '/.undodir')
    if vim.fn.isdirectory(target_path) == 0 then
      vim.fn.mkdir(target_path, 'p')
    end
    vim.cmd("let &undodir='" .. target_path .. "'")
    vim.cmd('set undofile')
  end

  vim.keymap.set('n', '<Leader>u', ':UndotreeToggle<CR>', { silent = true })
end

return M
