-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function cycle(set, count)
  local index = 0
  local passes = 0

  return function()
    index = index + 1

    if set[index] == nil then
      index = 1
      passes = passes + 1
      if count and count <= passes then
        return nil
      end
    end

    return set[index]
  end
end

return cycle
