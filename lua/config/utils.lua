local M = {}

M.telescope_git_or_file = function()
  local path = vim.fn.expand("%:p:h")
  local git_dir = vim.fn.finddir(".git", path .. ";")
  if #git_dir > 0 then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

M.toggle_set_color_column = function()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "80"
  else
    vim.wo.colorcolumn = ""
  end
end

M.toggle_cursor_line = function()
  if vim.wo.cursorline then
    vim.wo.cursorline = false
  else
    vim.wo.cursorline = true
  end
end

M.toggle_go_test = function()
  -- Get the current buffer's file name
  local current_file = vim.fn.expand("%:p")
  if string.match(current_file, "_test.go$") then
    -- If the current file ends with '_test.go', try to find the corresponding non-test file
    local non_test_file = string.gsub(current_file, "_test.go$", ".go")
    if vim.fn.filereadable(non_test_file) == 1 then
      -- Open the corresponding non-test file if it exists
      vim.cmd.edit(non_test_file)
    else
      print("No corresponding non-test file found")
    end
  else
    -- If the current file is a non-test file, try to find the corresponding test file
    local test_file = string.gsub(current_file, ".go$", "_test.go")
    if vim.fn.filereadable(test_file) == 1 then
      -- Open the corresponding test file if it exists
      vim.cmd.edit(test_file)
    else
      print("No corresponding test file found")
    end
  end
end

-- Copy the current file path and line number to the clipboard, use GitHub URL if in a Git repository
M.copyFilePathAndLineNumber = function()
  local current_file = vim.fn.expand("%:p")
  local current_line = vim.fn.line(".")
  local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

  if is_git_repo then
    local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
    local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

    -- Convert Git URL to GitHub web URL format
    current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
    current_repo = current_repo:gsub("%.git$", "")

    -- Remove leading system path to repository root
    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if repo_root then
      current_file = current_file:sub(#repo_root + 2)
    end

    local url = string.format("%s/blob/%s/%s#L%s", current_repo, current_branch, current_file, current_line)
    vim.fn.setreg("+", url)
    print("Copied to clipboard: " .. url)
  else
    -- If not in a Git directory, copy the full file path
    vim.fn.setreg("+", current_file .. "#L" .. current_line)
    print("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
  end
end

-- Copy the current file path to the clipboard, use GitHub URL if in a Git repository
M.copyFilePath = function()
  local current_file = vim.fn.expand("%:p")
  local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

  if is_git_repo then
    local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
    local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

    -- Convert Git URL to GitHub web URL format
    current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
    current_repo = current_repo:gsub("%.git$", "")

    -- Remove leading system path to repository root
    local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if repo_root then
      current_file = current_file:sub(#repo_root + 2)
    end

    local url = string.format("%s/blob/%s/%s", current_repo, current_branch, current_file)
    vim.fn.setreg("+", url)
    print("Copied to clipboard: " .. url)
  else
    -- If not in a Git directory, copy the full file path
    vim.fn.setreg("+", current_file)
    print("Copied full path to clipboard: " .. current_file)
  end
end

M.interactiveRebase = function()
  local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
  local base_branch = vim.fn.system(get_default_branch) or "main"

  vim.fn.system("git fetch origin " .. base_branch .. ":" .. base_branch)
  vim.cmd(":Git rebase -i " .. base_branch)
  M.checkRebaseStatus()
end

-- M.interactiveRebase = function()
--   local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
--   local base_branch = vim.fn.system(get_default_branch):gsub("%s+", "") or "main"
--
--   vim.fn.system("git fetch origin " .. base_branch .. ":" .. base_branch)
--   local rebase_buf = nil
--   local stdout_data = {}
--
--   vim.fn.jobstart("git rebase -i " .. base_branch, {
--     on_stdout = function(_, data)
--       if data then
--         for _, line in ipairs(data) do
--           if line ~= "" then
--             table.insert(stdout_data, line)
--           end
--         end
--       end
--     end,
--     on_stderr = function(_, data)
--       if data and #data > 0 then
--         print("Rebase error: " .. table.concat(data, "\n"))
--       end
--     end,
--     on_exit = function(_, exit_code)
--       if exit_code == 0 and #stdout_data > 0 then
--         -- Create a new buffer for the rebase
--         rebase_buf = vim.api.nvim_create_buf(false, true)
--         vim.api.nvim_buf_set_lines(rebase_buf, 0, -1, false, stdout_data)
--         vim.api.nvim_set_current_buf(rebase_buf)
--         vim.bo[rebase_buf].filetype = 'gitrebase'
--         vim.cmd('setlocal nomodified')
--
--         -- Set up autocmd to check for buffer write
--         vim.cmd([[
--           augroup RebaseComplete
--           autocmd!
--           autocmd BufWritePost <buffer> lua require('git_utils').checkRebaseStatus(]] .. rebase_buf .. [[)
--           augroup END
--         ]])
--       else
--         print("Failed to start rebase. Please check your git status.")
--         vim.fn.system("git rebase --abort")
--       end
--     end
--   })
-- end

M.checkRebaseStatus = function()
  local rebase_status = vim.fn.system("git rebase --show-current-patch"):gsub("%s+", "")

  if rebase_status == "" then
    -- Rebase is complete, clean up
    -- vim.cmd("autocmd! RebaseComplete")
    -- vim.api.nvim_buf_delete(buf, { force = true })

    -- Show the confirmation dialog
    M.showForcePushDialog()
  end
end

M.showForcePushDialog = function()
  vim.ui.select(
    { "Yes", "No" },
    { prompt = "Force push rebased changes?" },
    function(choice)
      if choice == "Yes" then
        local push_output = vim.fn.system("git push --force")
        if vim.v.shell_error == 0 then
          print("Changes force pushed successfully.")
        else
          print("Force push failed: " .. push_output)
        end
      else
        print("Force push cancelled.")
      end
    end
  )
end

return M
