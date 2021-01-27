-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local list = require "moonpie.collections.list"
local qt_node = class({})

function qt_node:constructor(props)
  self.x = props.x
  self.y = props.y
  self.width = props.width
  self.height = props.height
  self.depth = props.depth
end

function qt_node:add(item)
  self.items = self.items or {}
  self.items[#self.items + 1] = item
end

function qt_node:contains(x, y, width, height)
  return self.x < x + width and
    x < self.x + self.width and
    self.y < y + height and
    y < self.y + self.height
end


local quad_tree = class({})

function quad_tree:constructor(props)
  self.width = props.width
  self.height = props.height
  self.max_depth = props.max_depth
  self.root = qt_node:new { x = 1, y = 1, width = self.width, height = self.height, depth = 1 }
end

function quad_tree:add(item)
  local leaf_nodes = self:get_leaf_nodes(item.x, item.y, item.width, item.height, self.root)
  for _, v in ipairs(leaf_nodes) do
    v:add(item)
  end
end

function quad_tree:get_leaf_nodes(x, y, width, height, node, results)
  results = results or {}
  if node:contains(x, y, width, height) then
    if node.depth < self.max_depth then
      -- Check children
      if not node.tl then
        -- create nodes
        local sw, sh = node.width / 2, node.height / 2
        local next_depth = node.depth + 1
        node.tl = qt_node:new { x = node.x , y = node.y, width = sw, height = sh, depth = next_depth  }
        node.tr = qt_node:new { x = node.x + sw, y = node.y, width = sw, height = sh, depth = next_depth }
        node.bl = qt_node:new { x = node.x , y = node.y + sh, width = sw, height = sh, depth = next_depth }
        node.br = qt_node:new { x = node.x + sw, y = node.y + sh, width = sw, height = sh, depth = next_depth }
      end

      self:get_leaf_nodes(x, y, width, height, node.tl, results)
      self:get_leaf_nodes(x, y, width, height, node.tr, results)
      self:get_leaf_nodes(x, y, width, height, node.bl, results)
      self:get_leaf_nodes(x, y, width, height, node.br, results)

      return results
    else
      results[#results + 1] = node
      return results
    end
  end
end

function quad_tree:find(x, y, width, height)
  local items = list:new()
  local leaf_nodes = self:get_leaf_nodes(x, y, width, height, self.root)

  for _, v in ipairs(leaf_nodes) do
    for _, item in ipairs(v.items) do
      if not items:contains(item) then
        items:add(item)
      end
    end
  end

  return items
end



return quad_tree