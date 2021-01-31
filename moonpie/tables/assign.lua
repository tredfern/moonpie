-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copyKeys = require "moonpie.tables.copy_keys"
local pack = require "moonpie.tables.pack"

return function(dest, ...)
  local values = pack(...)
  for i = 1,#values do
    local v = values[i]
    if type(v) == "table" then
      copyKeys(v, dest, true)
    end
  end
  return dest
end