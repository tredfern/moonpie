-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(table, test)
  local result = true
  for i, v in ipairs(table) do
    result = test(v, i) and result
  end
  return result
end