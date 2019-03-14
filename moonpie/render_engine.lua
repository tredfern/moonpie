-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require("moonpie.node")
local Components = require("moonpie.components")
local RenderEngine = {}

local function build_node(component, parent)
  local new_node = Node(component, parent)

  if component.render then
    local rendered = component:render()
    new_node:add(build_node(rendered, new_node))
  else
    for _, v in ipairs(component) do
      new_node:add(build_node(v, new_node))
    end
  end

  return new_node
end

function RenderEngine:paint()
  self.root:paint()
end

function RenderEngine:update(mouse)
  mouse:update(self.root)
end

return function(...)
  local renderer = setmetatable({}, { __index = RenderEngine })
  renderer.root = Node(Components.root())

  for _, v in ipairs({...}) do
    renderer.root:add(build_node(v, renderer.root))
  end

  renderer.root:layout()

  return renderer
end

