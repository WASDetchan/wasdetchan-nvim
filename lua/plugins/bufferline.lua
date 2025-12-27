local buffer_order = { maxn = 0 }

local function buffer_position(bufnr)
  local pos = buffer_order[bufnr]
  if not pos then
    pos = -1
    print("ohno")
  end
  return pos
end

local function assign_buffer(bufnr)
  if not buffer_order[bufnr] then
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

      vim.api.nvim_create_autocmd("BufAdd", {
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
    end
  }
}
