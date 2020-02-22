-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, operation)
  local out = {}
  for _, v in ipairs(tbl) do
    out[#out + 1] = operation(v)
  end
  return out
end