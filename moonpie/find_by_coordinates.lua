-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function search_by_coord(x, y, node, results)
  if node.box:region():contains(x, y) then
    results[#results + 1] = node

    for _, v in ipairs(node.children) do
      search_by_coord(x, y, v, results)
    end
  end
end

return function(x, y, tree)
  local r = {}

  search_by_coord(x, y, tree, r)

  return r
end
