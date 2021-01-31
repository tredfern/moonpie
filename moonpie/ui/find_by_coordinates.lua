-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function findByCoordinates(x, y, node, results)
  if node.hidden then return end
  if node.box:region():contains(x, y) then
    results[#results + 1] = node

    if node.children then
      for _, v in ipairs(node.children) do
        findByCoordinates(x, y, v, results)
      end
    end
  end
end

return function(x, y, tree)
  local r = {}

  findByCoordinates(x, y, tree, r)

  return r
end
