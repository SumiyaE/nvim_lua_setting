-- Marksman の "Ambiguous link" 診断エラーのみを完全にフィルタリング
local original_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  -- "Ambiguous link" を含む診断を除外
  local filtered = vim.tbl_filter(function(d)
    return not (d.source == "Marksman" and d.message:match("Ambiguous link"))
  end, diagnostics)

  original_set(namespace, bufnr, filtered, opts)
end
