-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function default_value(item)
  return item
end

return function(array, get_value)
  get_value = get_value or default_value
  local m

  for _, v in ipairs(array) do
    if m then
      m = math.max(m, get_value(v))
    else
      m = get_value(v)
    end
  end

  return m
end