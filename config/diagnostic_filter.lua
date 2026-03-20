-- Marksman の不要な診断エラーをフィルタリング
local original_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  local filtered = vim.tbl_filter(function(d)
    if d.source == "Marksman" then
      return false
    end
    return true
  end, diagnostics)

  original_set(namespace, bufnr, filtered, opts)
end
