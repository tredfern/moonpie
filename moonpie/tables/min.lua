-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function default_value(item)
  return item
end

return function(array, getValue)
  getValue = getValue or default_value
  local m

  for _, v in ipairs(array) do
    if m then
      m = math.min(m, getValue(v))
    else
      m = getValue(v)
    end
  end

  return m
end