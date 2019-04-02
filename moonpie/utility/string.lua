-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local str = {}
local list = require "moonpie.collections.list"

function str.split(text, sep)
  local r = list:new()
  sep = sep or "%s"
  for s in string.gmatch(text, "([^" .. sep .. "]+)") do
    r:add(s)
  end
  return r
end

return str
