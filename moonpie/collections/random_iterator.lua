-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(t)
  local replaced = {}
  local size = #t

  --[[ Chooses an item and maintains a list of replaced entries
  -- in a table. Swaps the last index into the space of the
  -- randomly chosen entry. ]]
  return function()
    if size == 0 then
      return nil
    end

    local i = math.random(size)
    local item = replaced[i] or t[i]
    replaced[i] = replaced[size] or t[size]
    size = size - 1
    return item
  end
end
