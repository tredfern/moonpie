-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.ui.alignment")
local math_ext = require("moonpie.math")
local tables = require "moonpie.tables"
local layouts = {}

function layouts.should_wrap(node, x, line_width)
  return x > 0 and x + node.box.width > line_width
end

function layouts.horizontal_orientation(node, parent, width)
  local x, y = 0, 0
  local line_height, max_width, max_height = 0, 0, 0
  local new_line_width = width

  for _, v in pairs(node.children) do
    if v.position == "absolute" then
      layouts.absolute_position(v)
    else
      if layouts.should_wrap(v, x, new_line_width) then
        -- New Line
        x = 0
        y = y + line_height
        max_height = max_height + line_height
        line_height = 0
      end

      local horiz, vert = v.align or "left", v.vertical_align or "top"
      v.box:set_position(
        align(horiz, x, layouts.calc_width(node, parent, max_width), v.box.width),
        align(vert, y, layouts.calc_height(node, parent, line_height), v.box.height)
      )
      x = v.box.x + v.box.width

      line_height = math.max(v.box.height, line_height)
      max_width = math.max(max_width, x)

      if v.display == "inline-block" then
        -- inline-block elements should wrap to next line
        x = new_line_width + 1
      end
    end
  end
  max_height = max_height + line_height

  return max_width, max_height
end

function layouts.vertical_orientation(node, parent)
  local x, y = 0, 0
  local max_width, max_height = 0, 0

  local set_width = tables.max(node.children, function(n) return n.box.content.width end)

  for _, v in ipairs(node.children) do
    if v.position == "absolute" then
      layouts.absolute_position(v)
    else
      local horiz, vert = v.align or "left", v.vertical_align or "top"

      v.box:set_content_size(set_width, v.box.content.height)
      v.box:set_position(
        align(horiz, x, layouts.calc_width(node, parent, 0), v.box.width),
        align(vert, y, layouts.calc_height(node, parent, 0), v.box.height)
      )
      y = v.box.y + v.box.height

      max_height = max_height + v.box.height
      max_width = math.max(max_width, v.box.width)
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

function layouts.calc_max_height(node)
  if node == nil or node.box == nil then return 0 end
  local parent = node.parent

  -- If node has height assigned to a value, then use that
  if node.box.content.height > 0 then
    return node.box.content.height
  end
  return layouts.calc_max_height(parent)
end

function layouts.calc_height(node, parent, content)
  if math_ext.is_percent(node.height) then
    local boundary = node.box.margin.top + node.box.margin.bottom
      + node.box.padding.top + node.box.padding.bottom
      + node.box.border.top + node.box.border.bottom

    local max_height = layouts.calc_max_height(parent)

    return math_ext.percent_to_number(node.height) * max_height - boundary
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
  if node.display and string.match(node.display, "^inline") then
    return content_width
  end

  -- Everything else, take as much space as you can
  return layouts.max_width(node, p)
end

function layouts.standard(node, parent)
  parent = parent or node.parent
  node.box:set_content_size(
    layouts.max_width(node, parent),
    layouts.calc_height(node, parent, 0)
  )

  local w, h = layouts.children(node, parent, node.box.content.width)

  node.box:set_content_size(
    layouts.calc_width(node, parent, w),
    layouts.calc_height(node, parent, h)
  )
end

function layouts.text(node, parent)
  local Font = require "moonpie.graphics.font"
  local max_width = layouts.max_width(node, parent)
  local f = Font.pick(node)
  node.image = love.graphics.newText(f)

  -- handle wrapping behavior
  if node.textwrap and node.textwrap == "none" then
    node.image:set(node.text)
  else
    node.image:setf(node.text or "", max_width, "left")
  end

  return layouts.image(node, parent)
end

function layouts.image(node, parent)
  local w, h = node.image:getDimensions()
  if node.width then
    w = layouts.calc_width(node, parent, w)
  end
  if node.height then
    h = layouts.calc_height(node, parent, h)
  end
  node.box:set_content_size(w, h)
end

return layouts
