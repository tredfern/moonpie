-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.alignment")

local layouts = {}

function layouts.children(node, width)
  local x, y = 0, 0
  local line_height, max_width, max_height = 0, 0, 0

  for _, v in pairs(node.children) do
    v:layout(node)

    if x > 0 and x + v.box:width() > width then
      x = 0
      y = y + line_height
      max_height = max_height + line_height
      line_height = 0
    end

    local a = v.align or "left"
    v.box.x, v.box.y = align(a, x, width, v.box:width()), y
    x = v.box.x + v.box:width()

    line_height = math.max(v.box:height(), line_height)
    max_width = math.max(max_width, x)
  end

  max_height = max_height + line_height

  return max_width, max_height
end

function layouts.max_width(node, p)
  return node.width or
    (p.box.content.width
      - node.box.margin.left - node.box.margin.right
      - node.box.padding.left - node.box.padding.right
      - node.box.border.left - node.box.border.right)
end

function layouts.standard(node, parent)
  parent = parent or node.parent
  node.box.content.width = layouts.max_width(node, parent)
  node.box.content.height = 0

  local w, h = layouts.children(node, node.box.content.width)

  if node.display == "inline" then
    node.box.content.width = node.width or w
  end
  node.box.content.height = node.height or h
end


local template = require "moonpie.template"
function layouts.text(node, parent)
  local max_width = layouts.max_width(node, parent)
  local f = node.font or love.graphics.getFont()
  node.image = love.graphics.newText(f)
  node.image:setf(template(node.text, node), max_width, "left")

  return layouts.image(node)
end

function layouts.image(node)
  local w, h = node.image:getDimensions()
  node.box.content.width, node.box.content.height = node.width or w, node.height or h
end

return layouts
