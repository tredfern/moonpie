-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(set, sort_by)
  local out = {}
  for k, v in pairs(set) do
    out[#out + 1] = {
      key = k,
      value = v,
      sort_key = sort_by(k, v)
    }
  end
  table.sort(out, function(a, b) return a.sort_key < b.sort_key end)
  return out
end