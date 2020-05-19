-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(set, test)
  local result = false
  for i, v in ipairs(set) do
    result = test(v, i) or result
  end
  return result
end