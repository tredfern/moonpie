-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, operation)
  if not tbl then return end
  local out = {}
  local index = 1

  for i, v in pairs(tbl) do
    out[index] = operation(v, i)
    index = index + 1
  end

  return out
end