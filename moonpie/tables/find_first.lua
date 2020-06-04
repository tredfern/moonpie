-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(set, query)
  for _, v in ipairs(set) do
    if query(v) then return v end
  end
end