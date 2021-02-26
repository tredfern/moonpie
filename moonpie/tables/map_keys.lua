-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, operation)
  if not tbl then return end
  local out = {}
  local index = 1

  for k, v in pairs(tbl) do
    out[index] = operation(v, k)
    index = index + 1
  end

  return out
end