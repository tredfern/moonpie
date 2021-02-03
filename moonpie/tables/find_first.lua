-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(set, query)
  for i, v in ipairs(set) do
    if query(v) then return v, i end
  end
end