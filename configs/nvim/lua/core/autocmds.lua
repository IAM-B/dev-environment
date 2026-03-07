-- ============================================
-- AUTOCOMMANDS - Migrated from vimrc
-- ============================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Return to last position in file
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Filetype Edge (AdonisJS) - not natively detected
augroup("FileTypes", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = "FileTypes",
  pattern = "*.edge",
  callback = function()
    vim.bo.filetype = "edge"
    -- Disable treesitter for edge (uses classic vim syntax)
    vim.treesitter.stop()
  end,
})

-- Filetype-specific indentation
augroup("FileTypeIndent", { clear = true })
autocmd("FileType", {
  group = "FileTypeIndent",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "edge" },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- ============================================
-- TAILWIND - Wrap long classes
-- ============================================
local tw_max_width = 80

-- Split a class="..." line that is too long into multiline
local function wrap_tailwind_line(bufnr, lnum)
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1]
  if not line then return false end

  -- Detect class="..." on the line
  local indent, before, classes, after = line:match("^(%s*)(.-class=\")(.-)(\".*)$")
  if not indent or not classes then return false end

  -- Calculate base width (indentation + class=")
  local base_indent = indent .. string.rep(" ", #before - #indent)
  local first_line_max = tw_max_width - #indent - #before

  -- If the line already fits, do nothing
  if #line <= tw_max_width then return false end

  -- Split classes into words
  local words = {}
  for w in classes:gmatch("%S+") do
    table.insert(words, w)
  end
  if #words <= 1 then return false end

  -- Build the lines
  local lines = {}
  local current = ""
  for i, w in ipairs(words) do
    local max = (i == 1 or #lines == 0) and first_line_max or (tw_max_width - #base_indent)
    if current == "" then
      current = w
    elseif #current + 1 + #w <= max then
      current = current .. " " .. w
    else
      table.insert(lines, current)
      current = w
    end
  end
  if current ~= "" then
    table.insert(lines, current)
  end

  -- If only one line, no need to split
  if #lines <= 1 then return false end

  -- Reassemble
  local result = {}
  for i, l in ipairs(lines) do
    if i == 1 then
      table.insert(result, indent .. before .. l)
    elseif i == #lines then
      table.insert(result, base_indent .. l .. after)
    else
      table.insert(result, base_indent .. l)
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, lnum, lnum + 1, false, result)
  return true
end

-- Wrap all long classes in the buffer
local function wrap_tailwind_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local total = vim.api.nvim_buf_line_count(bufnr)
  local modified = false
  local lnum = 0
  while lnum < vim.api.nvim_buf_line_count(bufnr) do
    if wrap_tailwind_line(bufnr, lnum) then
      modified = true
    else
      lnum = lnum + 1
    end
  end
  if modified then
    vim.notify("Tailwind classes wrapped", vim.log.levels.INFO)
  end
end

-- Shortcut <leader>tw to wrap manually
vim.keymap.set("n", "<leader>tw", wrap_tailwind_buffer, { desc = "Wrap Tailwind classes" })

-- Auto wrap on save for Edge and HTML files
augroup("TailwindWrap", { clear = true })
autocmd("BufWritePre", {
  group = "TailwindWrap",
  pattern = { "*.edge", "*.html" },
  callback = function()
    wrap_tailwind_buffer()
  end,
})

-- Wrap Tailwind on all .edge files in the project
vim.api.nvim_create_user_command("TailwindWrapAll", function()
  local cwd = vim.fn.getcwd()
  local files = vim.fn.globpath(cwd, "**/*.edge", false, true)
  local count = 0
  for _, file in ipairs(files) do
    if not file:match("node_modules") then
      -- Read the file
      local f = io.open(file, "r")
      if f then
        local content = f:read("*a")
        f:close()
        -- Load into a hidden buffer
        local bufnr = vim.api.nvim_create_buf(false, true)
        local lines = vim.split(content, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        -- Wrap the classes
        local modified = false
        local lnum = 0
        while lnum < vim.api.nvim_buf_line_count(bufnr) do
          if wrap_tailwind_line(bufnr, lnum) then
            modified = true
          else
            lnum = lnum + 1
          end
        end
        -- Save if modified
        if modified then
          local new_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local out = io.open(file, "w")
          if out then
            out:write(table.concat(new_lines, "\n"))
            out:close()
            count = count + 1
          end
        end
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end
  vim.notify(count .. " .edge file(s) formatted", vim.log.levels.INFO)
end, {})

-- Custom commands
vim.api.nvim_create_user_command("FormatJSON", "%!python3 -m json.tool", {})
vim.api.nvim_create_user_command("ClearMarks", function()
  vim.cmd("delmarks A-Za-z")
  print("Markers cleared")
end, {})
vim.api.nvim_create_user_command("Count", function(opts)
  vim.cmd("%s/" .. opts.args .. "//gn")
end, { nargs = 1 })
vim.api.nvim_create_user_command("CopyPath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Path copied")
end, {})
vim.api.nvim_create_user_command("CopyRelPath", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  print("Relative path copied")
end, {})
vim.api.nvim_create_user_command("CopyFileName", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
  print("Filename copied")
end, {})
