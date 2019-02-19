-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Node = require(BASE .. "node")
local Text = require(BASE .. "text")
local Component = require(BASE .. "component")

local function build_item(item)
  local new_node = Node(item)
  if item.text then
    new_node:add(Text(item))
  end

  for _, v in ipairs(item) do
    new_node:add(build_item(v))
  end
  return new_node
end

return function(...)
 local r = Node(Component.root)

  for _, v in ipairs({...}) do
    r:add(build_item(v))
  end

  r:layout()

  return r
end
