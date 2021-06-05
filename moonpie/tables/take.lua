-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, count)
  local out = {}
  for i = 1, count do
    out[i] = table.remove(tbl, 1)
  end
  return out
end