-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(list)
  if list == nil or #list == 0 then return nil end
  local index = math.random(1, #list)

  return table.remove(list, index)
end