-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


return function(x, y, tree)
  local r = {}
  if tree.box:region():contains(x, y) then
    r[#r + 1] = tree
  end
  return r
end
