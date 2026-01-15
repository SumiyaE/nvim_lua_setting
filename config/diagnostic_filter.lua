-- Marksman の不要な診断エラーをフィルタリング
local original_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  local filtered = vim.tbl_filter(function(d)
    if d.source == "Marksman" then
      -- "Ambiguous link" と "Link to non-existent document" を除外
      if d.message:match("Ambiguous link") or d.message:match("Link to non%-existent document") then
        return false
      end
    end
    return true
  end, diagnostics)

  original_set(namespace, bufnr, filtered, opts)
end
