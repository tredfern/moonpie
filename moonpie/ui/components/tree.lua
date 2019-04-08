-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

Component("tree_item", function(props)
  local children = { }
  for i, v in ipairs(props) do
    children[i] = Component.tree_item(v)
  end
  return {
    props.leaf,
    children
  }
end)

Component("tree", function(props)
  local t = Component.tree_item(props.tree)
  return t
end)