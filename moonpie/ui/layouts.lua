-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.ui.alignment")
local math_ext = require("moonpie.math")
local layouts = {}

function layouts.horizontal_orientation(node, parent, width)
  local x, y = 0, 0
  local line_height, max_width, max_height = 0, 0, 0
  local new_line_width = width

  for _, v in pairs(node.children) do
    if v.position == "absolute" then
      layouts.absolute_position(v)
    else
      -- TODO: Getting messy
      if x > 0 and x + v.box:width() > new_line_width then
        -- New Line
        x = 0
        y = y + line_height
        max_height = max_height + line_height
        line_height = 0
      end

      local horiz, vert = v.align or "left", v.vertical_align or "top"
      v.box.x = align(horiz, x, layouts.calc_width(node, parent, max_width), v.box:width())
      v.box.y = align(vert, y, layouts.calc_height(node, parent, line_height), v.box:height())
      x = v.box.x + v.box:width()

      line_height = math.max(v.box:height(), line_height)
      max_width = math.max(max_width, x)
    end
  end
  max_height = max_height + line_height

  return max_width, max_height
end

function layouts.vertical_orientation(node, parent)
  local x, y = 0, 0
  local max_width, max_height = 0, 0

  local set_width = math_ext.find_max(node.children, function(n) return n.box.content.width end)

  for _, v in ipairs(node.children) do
    if v.position == "absolute" then
      layouts.absolute_position(v)
    else
      local horiz, vert = v.align or "left", v.vertical_align or "top"
      v.box.content.width = set_width
      v.box.x = align(horiz, x, layouts.calc_width(node, parent, 0), v.box:width())
      v.box.y = align(vert, y, layouts.calc_height(node, parent, 0), v.box:height())
      y = v.box.y + v.box:height()

      max_height = max_height + v.box:height()
      max_width = math.max(max_width, v.box:width())
    end
  end

  return max_width, max_height
end

function layouts.children(node, parent, width)
  for _, v in pairs(node.children) do
    v:layout(node)
  end
  if node.child_orientation == "vertical" then
    return layouts.vertical_orientation(node, parent, width)
  else
    return layouts.horizontal_orientation(node, parent, width)
  end
end

function layouts.absolute_position(node)
  node.box.x = node.x or 0
  node.box.y = node.y or 0
end

function layouts.max_width(node, p)
  local boundary = node.box.margin.left + node.box.margin.right
    + node.box.padding.left + node.box.padding.right
    + node.box.border.left + node.box.border.right

  if math_ext.is_percent(node.width) then
    return math_ext.percent_to_number(node.width) * p.box.content.width - boundary
  end
  -- TODO: Messy line, basically handles either width,
  -- parent.width - extra stuff,
  -- or just get the screen display because we shouldn't be here
  return node.width or (p and p.box.content.width - boundary) or love.graphics.getWidth()
end

function layouts.calc_height(node, parent, content)
  if math_ext.is_percent(node.height) then
    local boundary = node.box.margin.top + node.box.margin.bottom
      + node.box.padding.top + node.box.padding.bottom
      + node.box.border.top + node.box.border.bottom
    return math_ext.percent_to_number(node.height) * parent.box.content.height - boundary
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

  local w, h = layouts.children(node, parent, node.box.content.width)

  node.box.content.width = layouts.calc_width(node, parent, w)
  node.box.content.height = layouts.calc_height(node, parent, h)
end

function layouts.text(node, parent)
  local Font = require "moonpie.graphics.font"
  local max_width = layouts.max_width(node, parent)
  local f = Font.pick(node)
  node.image = love.graphics.newText(f)
  node.image:setf(node.text or "", max_width, "left")

  return layouts.image(node, parent)
end

function layouts.image(node, parent)
  local w, h = node.image:getDimensions()
  if node.width then
    node.box.content.width = layouts.calc_width(node, parent, w)
  else
    node.box.content.width = w
  end
  if node.height then
    node.box.content.height = layouts.calc_height(node, parent, h)
  else
    node.box.content.height = h
  end
end

return layouts
