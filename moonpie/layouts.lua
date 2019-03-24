-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.alignment")
local math_ext = require("moonpie.math_ext")

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

    local horiz, vert = v.align or "left", v.vertical_align or "top"
    v.box.x = align(horiz, x, width, v.box:width())
    v.box.y = align(vert, y, line_height, v.box:height())
    x = v.box.x + v.box:width()

    line_height = math.max(v.box:height(), line_height)
    max_width = math.max(max_width, x)
  end

  max_height = max_height + line_height

  return max_width, max_height
end

function layouts.max_width(node, p)
  local boundary = node.box.margin.left + node.box.margin.right
    + node.box.padding.left + node.box.padding.right
    + node.box.border.left + node.box.border.right

  if math_ext.is_percent(node.width) then
    return math_ext.percent_to_number(node.width) * p.box.content.width - boundary
  end
  return node.width or (p.box.content.width - boundary)
end

function layouts.calc_height(node, parent, content)
  if math_ext.is_percent(node.height) then
    return math_ext.percent_to_number(node.height) * parent.box.content.height
  else
    return node.height or content
  end
end

function layouts.calc_width(node, p, content_width)
  -- specified widths take precedence
  if node.width then
    if math_ext.is_percent(node.width) then
      local boundary = node.box.margin.left + node.box.margin.right
        + node.box.padding.left + node.box.padding.right
        + node.box.border.left + node.box.border.right
      return math_ext.percent_to_number(node.width) * p.box.content.width - boundary
    end
    return node.width
  end

  -- inline elements use content width
  if node.display == "inline" then
    return content_width
  end

  -- Everything else, take as much space as you can
  return layouts.max_width(node, p)
end

function layouts.standard(node, parent)
  parent = parent or node.parent
  node.box.content.width = layouts.max_width(node, parent)
  node.box.content.height = layouts.calc_height(node, parent, 0)

  local w, h = layouts.children(node, node.box.content.width)

  node.box.content.width = layouts.calc_width(node, parent, w)
  node.box.content.height = layouts.calc_height(node, parent, h)
end

function layouts.text(node, parent)
  local max_width = layouts.max_width(node, parent)
  local f = node.font or love.graphics.getFont()
  node.image = love.graphics.newText(f)
  node.image:setf(node.text or "", max_width, "left")

  return layouts.image(node)
end

function layouts.image(node)
  local w, h = node.image:getDimensions()
  node.box.content.width, node.box.content.height = node.width or w, node.height or h
end

return layouts
