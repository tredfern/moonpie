-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.ui.components

local function get_icons()
  local out = moonpie.collections.list:new()
  for k, v in pairs(moonpie.graphics.icons) do
    if type(v) == "string" then
      out:add(components.icon({ style = "icon-small", color = "white", backgroundColor = "black", icon = k }))
    end
  end
  return out
end

return function()
  return {
    get_icons()
  }
end
