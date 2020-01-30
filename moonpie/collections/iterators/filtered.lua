-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function filtered(set, filter)
  local index = 0

  return function()

    index = index + 1
    if set[index] == nil then return nil end

    local passed = filter(set[index])
    while ( not passed) do
      index = index + 1
      if set[index] == nil then return nil end
      passed = filter(set[index])
    end

    return set[index]
  end
end

return filtered
