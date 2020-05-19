-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, query)
  local result = {}

  for _, v in ipairs(tbl) do
    if query(v) then
      result[#result + 1] = v
    end
  end

  return result
end