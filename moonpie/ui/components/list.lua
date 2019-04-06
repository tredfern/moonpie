-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local list = require "moonpie.collections.list"

Component("list_item", function(props)
  return {
    id = props.id,
    props.item
  }
end)

Component("list", function(props)
  local out_list = list:new()

  for i, v in ipairs(props.items) do
    if type(v) == "string" then
      v = Component.text({ text = v })
    end
    out_list:add(
      Component.list_item({ id = string.format("list_item_%d", i), item = v })
    )
  end

  return out_list
end)