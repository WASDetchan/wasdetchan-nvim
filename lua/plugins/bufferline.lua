local buffer_order = { maxn = 0 }

local function buffer_position(bufnr)
  local pos = buffer_order[bufnr]
  if not pos then
    pos = -1
    print("ohno", bufnr)
  end
  return pos
end


local function is_in_bufferline(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return false
  end
  if vim.bo[bufnr].buftype ~= "" then
    return false
  end
  return true
end
local function assign_buffer(bufnr)
  if is_in_bufferline(bufnr) and not buffer_order[bufnr] then
    buffer_order.maxn = buffer_order.maxn + 1
    buffer_order[bufnr] = buffer_order.maxn
  end
end

local function remove_buffer(bufnr)
  local pos = buffer_order[bufnr]
  buffer_order[bufnr] = nil
  if not pos then return end
  for k, v in pairs(buffer_order) do
    if type(k) == "number" and v > pos then
      buffer_order[k] = v - 1
    end
  end
  buffer_order.maxn = buffer_order.maxn - 1
end

local function delete_all_except(bufnr)
  local pos = buffer_order[bufnr]
  buffer_order[bufnr] = nil
  if not pos then return end
  local to_delete = {}

  for k in pairs(buffer_order) do
    if type(k) == "number" then
      table.insert(to_delete, k)
    end
  end
  for _, k in ipairs(to_delete) do
    if type(k) == "number" then
      buffer_order[k] = nil
      vim.api.nvim_buf_delete(k, {})
    end
  end
  buffer_order[bufnr] = 1
  buffer_order.maxn = 1
end

local function move_left(bufnr)
  local pos = buffer_order[bufnr]
  if not pos or pos == 1 then return end
  for k, v in pairs(buffer_order) do
    if type(k) == "number" and v == pos - 1 then
      buffer_order[k] = pos
    end
  end
  buffer_order[bufnr] = pos - 1
end

local function move_right(bufnr)
  local pos = buffer_order[bufnr]
  if not pos or pos == buffer_order.maxn then return end
  for k, v in pairs(buffer_order) do
    if type(k) == "number" and v == pos + 1 then
      buffer_order[k] = pos
    end
  end
  buffer_order[bufnr] = pos + 1
end

return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local opts = {
        options = {
          diagnostics = "nvim_lsp",
          sort_by = function(buf_a, buf_b)
            local pos_a = buffer_position(buf_a.id)
            local pos_b = buffer_position(buf_b.id)
            return pos_a < pos_b
          end
        }
      }
      require('bufferline').setup(opts)

      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function(args)
          assign_buffer(args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("BufDelete", {
        callback = function(args)
          remove_buffer(args.buf)
        end
      })

      vim.keymap.set('n', 'H', function() vim.cmd('BufferLineCyclePrev') end)
      vim.keymap.set('n', 'L', function() vim.cmd('BufferLineCycleNext') end)
      vim.keymap.set('n', '<C-H>', function()
        local bufnr = vim.api.nvim_get_current_buf()
        move_left(bufnr)
        vim.cmd("redraw!")
      end)
      vim.keymap.set('n', '<C-L>', function()
        local bufnr = vim.api.nvim_get_current_buf()
        move_right(bufnr)
        vim.cmd("redraw!")
      end)

      -- buffer operations (+ fuzzy search in telescope config)
      vim.keymap.set("n", "<leader>bd", function() vim.api.nvim_buf_delete(0, {}) end, { silent = true })
      vim.keymap.set("n", "<leader>bo", function() delete_all_except(vim.api.nvim_get_current_buf()) end,
        { silent = true })
    end
  }
}
