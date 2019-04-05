-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local list = require "moonpie.collections.list"

Component("list", function(props)
  local out_list = list:new()

  for i, v in ipairs(props.items) do
    if type(v) == "string" then
      v = Component.text({ text = v })
    end
    v.id = string.format("list_item_%d", i)
    out_list:add(v)
  end

  return out_list
end)