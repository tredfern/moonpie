-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require "moonpie.ui.node"
local Components = require "moonpie.ui.components"
local List = require "moonpie.collections.list"
local safecall = require "moonpie.utility.safe_call"
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
  if RenderEngine.update_nodes(self.root) then
    self.root:layout()
  end
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

function RenderEngine.remove_component_if_exists(component)
  local n = RenderEngine.find_by_component(component)
  if n then
    RenderEngine.remove_node(n)
  end
end

function RenderEngine.remove_node(node)
  node.parent.children:remove(node)
  node:destroy()
end

function RenderEngine.add_node(node, parent)
  RenderEngine.remove_component_if_exists(node.component)
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
  if node.render then
    local rendered = node:render()
    node:clear_children()
    RenderEngine.add_node(RenderEngine.build_node(rendered, node), node)
  end
end


function RenderEngine.refresh_style(node)
  node:refresh_style()
  for _, v in ipairs(node.children) do
    RenderEngine.refresh_style(v)
  end
end


function RenderEngine.update_nodes(node)
  local updates = safecall(node.has_updates, node)

  -- hidden components do nothing
  if node.is_hidden and node:is_hidden() then return end

  -- Removal gets rid of the entire tree, so take care of that
  if safecall(node.needs_removal, node) then
    RenderEngine.remove_node(node)
  else
    -- perform any updates
    if safecall(node.has_updates, node) then
      RenderEngine.render_node(node)
      node:layout()
      node.component:flag_updates(false)
    end

    for _, v in ipairs(node.children) do
      updates = RenderEngine.update_nodes(v) or updates
    end
  end
  return updates
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

function RenderEngine.clear_all()
  for _, v in ipairs(RenderEngine.layers.order) do
    local layer = setmetatable({}, { __index = Layer })
    layer.root = Node(Components.root())
    RenderEngine.layers[v] = layer
  end
end

RenderEngine.clear_all()

setmetatable(RenderEngine, { __call = function(_, layer, ...) return RenderEngine.render_all(layer, ...) end })
return RenderEngine