-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require("moonpie.node")
local Components = require("moonpie.components")
local List = require("moonpie.collections.list")
local Layer = {}
local RenderEngine = {}

function Layer:paint()
  RenderEngine.refresh_style(self.root)
  self.root:paint()
end

function Layer:update(mouse)
  mouse:update(self.root)
  RenderEngine.update_nodes(self.root)
end

function Layer:find_by_component(c, node)
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

RenderEngine.layers = {
  order = { "ui", "modal", "floating", "debug" }
}

function RenderEngine.build_node(component, parent)
  local new_node = Node(component, parent)

  if component.render then
    local rendered = component:render()
    new_node:add(RenderEngine.build_node(rendered, new_node))
  else
    for _, v in ipairs(component) do
      new_node:add(RenderEngine.build_node(v, new_node))
    end
  end

  return new_node
end

function RenderEngine.render_node(node)
  local rendered = node:render()
  node:clear_children()
  node:add(RenderEngine.build_node(rendered, node))
end


function RenderEngine.refresh_style(node)
  node:refresh_style()
  for _, v in ipairs(node.children) do
    RenderEngine.refresh_style(v)
  end
end


function RenderEngine.update_nodes(node)
  if node.is_hidden and node:is_hidden() then return end
  if node.has_updates and node:has_updates() then
    RenderEngine.render_node(node)
    node:layout()
    node:flag_updates(false)
  else
    for _, v in ipairs(node.children) do
      RenderEngine.update_nodes(v)
    end
  end
end

function RenderEngine.ordered_layers()
  local list = List:new()

  for _, v in pairs(RenderEngine.layers.order) do
    list:add(RenderEngine.layers[v])
  end

  return list
end

function RenderEngine.paint()
  for _, v in ipairs(RenderEngine.ordered_layers()) do
    v:paint()
  end
end

function RenderEngine.render_default(...)
  return RenderEngine.render_all("ui", ...)
end

function RenderEngine.render_all(layer_name, ...)
  local layer = setmetatable({}, { __index = Layer })
  layer.root = Node(Components.root())

  for _, v in ipairs({...}) do
    layer.root:add(RenderEngine.build_node(v, layer.root))
  end

  layer.root:layout()
  RenderEngine.layers[layer_name] = layer
  return layer
end

setmetatable(RenderEngine, { __call = function(_, ...) return RenderEngine.render_default(...) end })
return RenderEngine

