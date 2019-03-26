-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require("moonpie.node")
local Components = require("moonpie.components")
local RenderEngine = {}

function RenderEngine:build_node(component, parent)
  local new_node = Node(component, parent)

  if component.render then
    local rendered = component:render()
    new_node:add(RenderEngine:build_node(rendered, new_node))
  else
    for _, v in ipairs(component) do
      new_node:add(RenderEngine:build_node(v, new_node))
    end
  end

  return new_node
end

function RenderEngine:render_node(node)
  local rendered = node:render()
  node:clear_children()
  node:add(RenderEngine:build_node(rendered, node))
end

function RenderEngine:paint()
  self:refresh_style(self.root)
  self.root:paint()
end

function RenderEngine:refresh_style(node)
  node:refresh_style()
  for _, v in ipairs(node.children) do
    self:refresh_style(v)
  end
end

function RenderEngine:find_by_component(c, node)
  node = node or self.root
  if node.component == c then
    return node
  end

  for _, v in ipairs(node.children) do
    local r = self:find_by_component(c, v)
    if r then
      return r
    end
  end
end

function RenderEngine:update(mouse)
  mouse:update(self.root)
  self:update_nodes(self.root)
end

function RenderEngine:update_nodes(node)
  if node.is_hidden and node:is_hidden() then return end
  if node.has_updates and node:has_updates() then
    RenderEngine:render_node(node)
    node:layout()
    node:flag_updates(false)
  else
    for _, v in ipairs(node.children) do
      self:update_nodes(v)
    end
  end
end

function RenderEngine:render_all(...)
  local renderer = setmetatable({}, { __index = RenderEngine })
  renderer.root = Node(Components.root())

  for _, v in ipairs({...}) do
    renderer.root:add(renderer:build_node(v, renderer.root))
  end

  renderer.root:layout()

  return renderer
end

setmetatable(RenderEngine, { __call = RenderEngine.render_all })
return RenderEngine

