-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, operation)
  local out = {}
  for i, v in ipairs(tbl) do
    out[i] = operation(v, i)
  end
  return out
end