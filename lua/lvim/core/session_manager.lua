local M = {}

function M.setup()
  local status_ok, session_manager = pcall(require, "session_manager")
  if not status_ok then
    return
  end

  session_manager.setup({
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
  })

  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = function()
      if vim.fn.has('win32') == 1 then
        vim.cmd('silent! cd %:p:h')
        -- An empty file will be opened if you use right mouse click. So `bw!` to delete it.
        -- Once you delete the empty buffer, netrw won't popup. So you needn't do `vim.cmd('silent! au! FileExplorer *')` to silent netrw.
        vim.cmd('silent! bw!')
      end
      -- vim.fn.argc() is 1 (not 0) if you open from right mouse click on windows platform.
      -- So it can't be an instance that can be treated as in a workspace.
      if vim.fn.has('win32') == 1 or vim.fn.argc() == 0 then
        vim.cmd('silent! SessionManager load_current_dir_session')
      end
    end
  })

  vim.keymap.set('n', '<Leader>o', ':SessionManager load_session<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>O', ':SessionManager delete_session<CR>', { silent = true })
end

return M
