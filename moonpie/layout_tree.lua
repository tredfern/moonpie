-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require("moonpie.node")
local Components = require("moonpie.components")

local function build_item(item)
  local new_node = Node(item)

  for _, v in ipairs(item) do
    new_node:add(build_item(v))
  end
  return new_node
end

return function(...)
 local r = Node(Components.root)

  for _, v in ipairs({...}) do
    r:add(build_item(v))
  end

  r:layout()

  return r
end
