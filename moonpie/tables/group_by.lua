-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function get_groupBy(value, func)
  if func == nil then
    return value
  end

  if type(func) == "string" and type(value) == "table" then
    return value[func]
  end

  return func(value)
end

return function(set, groupBy)
  local out = {}

  for _, v in ipairs(set) do
    local grouping = get_groupBy(v, groupBy)
    if grouping then
      if not out[grouping] then
        out[grouping] = {}
      end
      local group = out[grouping]
      group[#group + 1] = v
    end
  end
  return out
end