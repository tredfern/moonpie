-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(set, func)
  if func == nil then return #set end

  local c = 0
  for _, v in ipairs(set) do
    if func(v) then c = c + 1 end
  end
  return c
end