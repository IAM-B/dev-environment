-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================
-- EDGE (AdonisJS) - Filetype & treesitter
-- ============================================
augroup("EdgeFileType", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = "EdgeFileType",
  pattern = "*.edge",
  callback = function()
    vim.bo.filetype = "edge"
    vim.treesitter.stop()
  end,
})

-- ============================================
-- TAILWIND - Wrap long classes (edge-safe)
-- ============================================
local tw_max_width = 80

local function wrap_tailwind_line(bufnr, lnum)
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1]
  if not line then return false end

  local indent, before, classes, after = line:match("^(%s*)(.-class=\")(.-)(\".*)$")
  if not indent or not classes then return false end

  -- Skip lines with Edge expressions inside class to avoid breaking {{ }}
  if classes:find("{{") then return false end

  local base_indent = indent .. string.rep(" ", #before - #indent)
  local first_line_max = tw_max_width - #indent - #before

  if #line <= tw_max_width then return false end

  local words = {}
  for w in classes:gmatch("%S+") do
    table.insert(words, w)
  end
  if #words <= 1 then return false end

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

  if #lines <= 1 then return false end

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

local function wrap_tailwind_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum = 0
  local modified = false
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

vim.keymap.set("n", "<leader>tw", wrap_tailwind_buffer, { desc = "Wrap Tailwind classes" })

augroup("TailwindWrap", { clear = true })
autocmd("BufWritePre", {
  group = "TailwindWrap",
  pattern = { "*.edge", "*.html" },
  callback = wrap_tailwind_buffer,
})

-- Wrap all .edge files in the project
vim.api.nvim_create_user_command("TailwindWrapAll", function()
  local cwd = vim.fn.getcwd()
  local files = vim.fn.globpath(cwd, "**/*.edge", false, true)
  local count = 0
  for _, file in ipairs(files) do
    if not file:match("node_modules") then
      local f = io.open(file, "r")
      if f then
        local content = f:read("*a")
        f:close()
        local bufnr = vim.api.nvim_create_buf(false, true)
        local file_lines = vim.split(content, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, file_lines)
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
