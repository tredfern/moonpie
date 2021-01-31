-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local groupBy = require "moonpie.tables.group_by"

return function(set, func)
  local g = groupBy(set, func)
  local out = {}
  for k, v in pairs(g) do
    out[k] = #v
  end
  return out
end