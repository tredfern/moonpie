-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.ui.alignment")
local math_ext = require("moonpie.math")
local tables = require "moonpie.tables"
local layouts = {}

function layouts.shouldWrap(node, x, line_width)
  return x > 0 and x + node.box.width > line_width
end

function layouts.horizontalOrientation(node, parent, width)
  local x, y = 0, 0
  local lineHeight, maxWidth, maxHeight = 0, 0, 0
  local newLineWidth = width

  for _, v in pairs(node.children) do
    if v.position == "absolute" then
      layouts.absolutePosition(v)
    else
      if layouts.shouldWrap(v, x, newLineWidth) then
        -- New Line
        x = 0
        y = y + lineHeight
        maxHeight = maxHeight + lineHeight
        lineHeight = 0
      end

      local horiz, vert = v.align or "left", v.verticalAlign or "top"
      v.box:setPosition(
        align(horiz, x, layouts.calculateWidth(node, parent, maxWidth), v.box.width),
        align(vert, y, layouts.calculateHeight(node, parent, lineHeight), v.box.height)
      )
      x = v.box.x + v.box.width

      lineHeight = math.max(v.box.height, lineHeight)
      maxWidth = math.max(maxWidth, x)

      if v.display == "inline-block" then
        -- inline-block elements should wrap to next line
        x = newLineWidth + 1
      end
    end
  end
  maxHeight = maxHeight + lineHeight

  return maxWidth, maxHeight
end

function layouts.verticalOrientation(node, parent)
  local x, y = 0, 0
  local maxWidth, maxHeight = 0, 0

  local set_width = tables.max(node.children, function(n) return n.box.content.width end)

  for _, v in ipairs(node.children) do
    if v.position == "absolute" then
      layouts.absolutePosition(v)
    else
      local horiz, vert = v.align or "left", v.verticalAlign or "top"

      v.box:setContentSize(set_width, v.box.content.height)
      v.box:setPosition(
        align(horiz, x, layouts.calculateWidth(node, parent, 0), v.box.width),
        align(vert, y, layouts.calculateHeight(node, parent, 0), v.box.height)
      )
      y = v.box.y + v.box.height

      maxHeight = maxHeight + v.box.height
      maxWidth = math.max(maxWidth, v.box.width)
    end
  end

  return maxWidth, maxHeight
end

function layouts.children(node, parent, width)
  for _, v in pairs(node.children) do
    v:layout(node)
  end
  if node.child_orientation == "vertical" then
    return layouts.verticalOrientation(node, parent, width)
  else
    return layouts.horizontalOrientation(node, parent, width)
  end
end

function layouts.absolutePosition(node)
  node.box.x = node.x or 0
  node.box.y = node.y or 0
end

function layouts.maxWidth(node, p)
  local boundary = node.box.margin.left + node.box.margin.right
    + node.box.padding.left + node.box.padding.right
    + node.box.border.left + node.box.border.right

  if math_ext.isPercent(node.width) then
    return math_ext.percentToNumber(node.width) * p.box.content.width - boundary
  end
  -- TODO: Messy line, basically handles either width,
  -- parent.width - extra stuff,
  -- or just get the screen display because we shouldn't be here
  return node.width or (p and p.box.content.width - boundary) or love.graphics.getWidth()
end

function layouts.calculateMaxHeight(node)
  if node == nil or node.box == nil then return 0 end
  local parent = node.parent

  -- If node has height assigned to a value, then use that
  if node.box.content.height > 0 then
    return node.box.content.height
  end
  return layouts.calculateMaxHeight(parent)
end

function layouts.calculateHeight(node, parent, content)
  if math_ext.isPercent(node.height) then
    local boundary = node.box.margin.top + node.box.margin.bottom
      + node.box.padding.top + node.box.padding.bottom
      + node.box.border.top + node.box.border.bottom

    local maxHeight = layouts.calculateMaxHeight(parent)

    return math_ext.percentToNumber(node.height) * maxHeight - boundary
  else
    return node.height or content
  end
end

function layouts.calculateWidth(node, p, content_width)
  -- specified widths take precedence
  if node.width then
    if math_ext.isPercent(node.width) then
      local boundary = node.box.margin.left + node.box.margin.right
        + node.box.padding.left + node.box.padding.right
        + node.box.border.left + node.box.border.right
      return math_ext.percentToNumber(node.width) * p.box.content.width - boundary
    end
    return node.width
  end

  -- inline elements use content width
  if node.display and string.match(node.display, "^inline") then
    return content_width
  end

  -- Everything else, take as much space as you can
  return layouts.maxWidth(node, p)
end

function layouts.standard(node, parent)
  parent = parent or node.parent
  node.box:setContentSize(
    layouts.maxWidth(node, parent),
    layouts.calculateHeight(node, parent, 0)
  )

  local w, h = layouts.children(node, parent, node.box.content.width)

  node.box:setContentSize(
    layouts.calculateWidth(node, parent, w),
    layouts.calculateHeight(node, parent, h)
  )
end

function layouts.text(node, parent)
  local Font = require "moonpie.graphics.font"
  local maxWidth = layouts.maxWidth(node, parent)
  local f = Font.pick(node)
  node.image = love.graphics.newText(f)

  -- handle wrapping behavior
  if node.textwrap and node.textwrap == "none" then
    node.image:set(node.text)
  else
    node.image:setf(node.text or "", maxWidth, "left")
  end

  return layouts.image(node, parent)
end

function layouts.image(node, parent)
  local w, h = node.image:getDimensions()
  if node.width then
    w = layouts.calculateWidth(node, parent, w)
  end
  if node.height then
    h = layouts.calculateHeight(node, parent, h)
  end
  node.box:setContentSize(w, h)
end

return layouts
