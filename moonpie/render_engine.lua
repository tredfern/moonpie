-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require("moonpie.node")
local Components = require("moonpie.components")
local List = require("moonpie.collections.list")
local Layer = {}
local RenderEngine = {}

function Layer:render_all(...)
  self.root:clear_children()

  for _, v in ipairs({...}) do
    self.root:add(RenderEngine.build_node(v, self.root))
  end

  self.root:layout()
end

function Layer:add_node(node)
  node.parent = self.root
  node.box.parent = self.root.box
  self.root:add(node)
  self.root:layout()
end

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

function RenderEngine.add_node(node, parent)
  if node.target_layer then
    RenderEngine.layers[node.target_layer]:add_node(node)
  else
    parent:add(node)
  end
end

function RenderEngine.build_node(component, parent)
  local new_node = Node(component, parent)

  if component.render then
    local rendered = new_node:render()
    RenderEngine.add_node(RenderEngine.build_node(rendered, new_node), new_node)
  else
    for _, v in ipairs(component) do
      RenderEngine.add_node(RenderEngine.build_node(v, new_node), new_node)
    end
  end

  return new_node
end

function RenderEngine.find_by_component(component)
  for _, v in ipairs(RenderEngine.ordered_layers()) do
    local f = v:find_by_component(component)
    if f then return f end
  end
end

function RenderEngine.render_node(node)
  local rendered = node:render()
  node:clear_children()
  RenderEngine.add_node(RenderEngine.build_node(rendered, node), node)
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

function RenderEngine.update(mouse)
  for _, v in ipairs(RenderEngine.ordered_layers()) do
    v:update(mouse)
  end
end

function RenderEngine.validate_layer(layer_name)
  for _, v in ipairs(RenderEngine.layers.order) do
    if v == layer_name then return end
  end
  error(string.format("Layer %s is not supported", layer_name))
end

function RenderEngine.render_all(layer_name, ...)
  RenderEngine.validate_layer(layer_name)

  RenderEngine.layers[layer_name]:render_all(...)
  return RenderEngine.layers[layer_name]

end

for _, v in ipairs(RenderEngine.layers.order) do
  local layer = setmetatable({}, { __index = Layer })
  layer.root = Node(Components.root())
  RenderEngine.layers[v] = layer
end

setmetatable(RenderEngine, { __call = function(_, layer, ...) return RenderEngine.render_all(layer, ...) end })
return RenderEngine