-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require "moonpie.ui.node"
local Components = require "moonpie.ui.components"
local List = require "moonpie.collections.list"
local safecall = require "moonpie.utility.safe_call"
local find_by_component = require "moonpie.ui.find_by_component"
local RenderEngine = {}

RenderEngine.layers = {
  order = { "background", "ui", "modal", "floating", "debug", "unit_test" }
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
    local layer = RenderEngine.layers[node.target_layer]
    node.parent = layer
    node.box.parent = layer.box
    layer:add(node)
    layer:layout()
  else
    parent:add(node)
  end
end

function RenderEngine.build_node(component, parent)
  local new_node = Node(component, parent)

  if new_node.render then
    local rendered = new_node:render()
    RenderEngine.add_node(RenderEngine.build_node(rendered, new_node), new_node)
  else
    for _, v in ipairs(component) do
      RenderEngine.add_node(RenderEngine.build_node(v, new_node), new_node)
    end
  end
  safecall(new_node.mounted, new_node)

  return new_node
end

function RenderEngine.find_by_component(component)
  for _, v in ipairs(RenderEngine.ordered_layers()) do
    local f = find_by_component(v, component)
    if f then return f end
  end
end

function RenderEngine.find_by_id(id)
  if not id then
    local logger = require "moonpie.logger"
    logger.info("RenderEngine.find_by_id called with nil")
    return
  end

  for _, layer in ipairs(RenderEngine.ordered_layers()) do
    local node = layer:find_by_id(id)
    if node then return node end
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
  local updates = false

  -- hidden components do nothing
  if node.is_hidden and node:is_hidden() then return end

  -- Removal gets rid of the entire tree, so take care of that
  if safecall(node.needs_removal, node) then
    RenderEngine.remove_node(node)
  else
    -- perform any updates
    if safecall(node.has_updates, node) then
      updates = true
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
    RenderEngine.refresh_style(v)
    v:paint()
  end
end

function RenderEngine.update(mouse)
  for _, v in ipairs(RenderEngine.ordered_layers()) do
    mouse:update(v)
    if RenderEngine.update_nodes(v) then
      v:layout()
    end
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

  local layer = RenderEngine.layers[layer_name]
  layer:clear_children()

  for _, v in ipairs({...}) do
    layer:add(RenderEngine.build_node(v, layer))
  end

  layer:layout()
  return layer
end

function RenderEngine.clear_all()
  for _, v in ipairs(RenderEngine.layers.order) do
    RenderEngine.layers[v] = Node(Components.root())
  end
end

RenderEngine.clear_all()

setmetatable(RenderEngine, { __call = function(_, layer, ...) return RenderEngine.render_all(layer, ...) end })
return RenderEngine