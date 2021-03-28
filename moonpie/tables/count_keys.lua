-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl)
  local count = 0
  for _, _ in pairs(tbl) do count = count + 1 end
  return count
end