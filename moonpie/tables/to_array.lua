-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl)
  local out = {}
  for _, v in pairs(tbl) do
    out[#out + 1] = v
  end

  return out
end