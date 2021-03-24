-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, item)
  for i, v in ipairs(tbl) do
    if v == item then return i end
  end
end