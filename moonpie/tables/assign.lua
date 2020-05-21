-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copy_keys = require "moonpie.tables.copy_keys"
local pack = require "moonpie.tables.pack"

return function(dest, ...)
  local values = pack(...)
  for i = 1,#values do
    local v = values[i]
    if type(v) == "table" then
      copy_keys(v, dest, true)
    end
  end
  return dest
end