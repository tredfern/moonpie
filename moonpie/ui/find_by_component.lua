-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function search_imp(n, c)
  if n.component == c then
    return n
  end

  for _, v in ipairs(n.children) do
    local found = search_imp(v, c)
    if found then return found end
  end

  return nil
end

return search_imp