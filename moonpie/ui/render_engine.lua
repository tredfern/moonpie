-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Node = require "moonpie.ui.node"
local Components = require "moonpie.ui.components"
local List = require "moonpie.collections.list"
local safe_call = require "moonpie.utility.safe_call"
local findByComponent = require "moonpie.ui.find_by_component"
local update_queue = require "moonpie.ui.update_queue"
local tables = require "moonpie.tables"
local RenderEngine = {}

RenderEngine.layers = {
  order = { "background", "ui", "modal", "floating", "debug", "unit_test" }
}

function RenderEngine.removeComponentIfExists(component)
  local n = RenderEngine.findByComponent(component)
  if n then
    RenderEngine.removeNode(n)
  end
end

function RenderEngine.removeNode(node)
  node.parent.children:remove(node)
  node:destroy()
end


function RenderEngine.addNode(node, parent)
  RenderEngine.removeComponentIfExists(node.component)
  if node.targetLayer then
    local layer = RenderEngine.layers[node.targetLayer]
    layer:add(node)
    layer:layout()
  else
    parent:add(node)
  end
end

function RenderEngine.buildNode(component, parent)
  local new_node = Node(component, parent)

  if new_node.render then
    local rendered = new_node:render()
    RenderEngine.addNode(RenderEngine.buildNode(rendered, new_node), new_node)
  else
    for _, v in ipairs(component) do
      RenderEngine.addNode(RenderEngine.buildNode(v, new_node), new_node)
    end
  end
  safe_call(new_node.mounted, new_node)

  return new_node
end

function RenderEngine.findByComponent(component)
  for _, v in ipairs(RenderEngine.orderedLayers()) do
    local f = findByComponent(v, component)
    if f then return f end
  end
end

function RenderEngine.findByID(id)
  if not id then
    local logger = require "moonpie.logger"
    logger.info("RenderEngine.findByID called with nil")
    return
  end

  for _, layer in ipairs(RenderEngine.orderedLayers()) do
    local node = layer:findByID(id)
    if node then return node end
  end
end

function RenderEngine.findByPosition(x, y)
  local findByCoordinates = require "moonpie.ui.find_by_coordinates"
  local out = {}

  for _, v in ipairs(RenderEngine.orderedLayers()) do
    out = tables.join(out, findByCoordinates(x, y, v))
  end

  return out
end

function RenderEngine.renderNode(node)
  if node.render then
    local rendered = node:render()
    node:clear_children()
    RenderEngine.addNode(RenderEngine.buildNode(rendered, node), node)
  end
end

function RenderEngine.updateNode(node)
  -- hidden components do nothing
  if node.isHidden and node:isHidden() then return end

  -- Removal gets rid of the entire tree, so take care of that
  if safe_call(node.needsRemoval, node) then
    RenderEngine.removeNode(node)
  else
    RenderEngine.renderNode(node)
    node.component:flagUpdates(false)
  end
  return true
end

function RenderEngine.orderedLayers()
  local list = List:new()

  for _, v in pairs(RenderEngine.layers.order) do
    list:add(RenderEngine.layers[v])
  end

  return list
end

function RenderEngine.paint()
  for _, v in ipairs(RenderEngine.orderedLayers()) do
    v:paint()
  end
end

local function getNodeLayer(node)
  local layer = node.parent
  while layer.parent ~= nil and layer.parent.parent ~= nil do
    layer = layer.parent
  end
  return layer
end

function RenderEngine.update()
  local changed_layers = {}
  while not update_queue:isEmpty() do
    local next = update_queue:pop()
    if next.node then
      local layer = getNodeLayer(next.node)
      if RenderEngine.updateNode(next.node) then
        changed_layers[layer] = true
      end
    end
  end

  for _, v in ipairs(RenderEngine.orderedLayers()) do
    if changed_layers[v] then
      v:layout()
    end
  end
end

function RenderEngine.validateLayer(layer_name)
  for _, v in ipairs(RenderEngine.layers.order) do
    if v == layer_name then return end
  end
  error(string.format("Layer %s is not supported", layer_name))
end

function RenderEngine.renderAll(layer_name, ...)
  RenderEngine.validateLayer(layer_name)

  local layer = RenderEngine.layers[layer_name]
  layer:clear_children()

  for _, v in ipairs({...}) do
    layer:add(RenderEngine.buildNode(v, layer))
  end

  layer:layout()
  return layer
end

function RenderEngine.clearAll()
  for _, v in ipairs(RenderEngine.layers.order) do
    RenderEngine.layers[v] = Node(Components.root())
  end
end

RenderEngine.clearAll()

setmetatable(RenderEngine, { __call = function(_, layer, ...) return RenderEngine.renderAll(layer, ...) end })
return RenderEngine