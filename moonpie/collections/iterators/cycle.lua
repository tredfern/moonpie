-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function cycle(set, count)
  local index = 0
  local passes = 0
  local c = {}

  c.next = function()
    index = index + 1

    if set[index] == nil then
      index = 1
      passes = passes + 1
      if count and count <= passes then
        return nil
      end
    end

    return set[index], index
  end

  c.previous = function()
    index = index - 1
    if set[index] == nil then
      index = #set
    end

    return set[index], index
  end

  setmetatable(c, { __call = c.next })
  return c
end

return cycle
