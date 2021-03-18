-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local region = require("moonpie.ui.region")
local rectangle = require "moonpie.math.rectangle"

local function getBoxRectangle(element, property)
  local boxRectangle
  if type(element[property]) == "table" then
    boxRectangle = {
      left = element[property].left or 0,
      top = element[property].top or 0,
      right = element[property].right or 0,
      bottom = element[property].bottom or 0,
    }
  else
    local v = tonumber(element[property]) or 0
    boxRectangle = {
      left = v, top = v, right = v, bottom = v,
    }
  end
  boxRectangle.landr = boxRectangle.left + boxRectangle.right
  boxRectangle.tandb = boxRectangle.top + boxRectangle.bottom
  return boxRectangle
end

local function calculateValues(box)
  box.updateRegion = true
  box.width = box.margin.landr + box.border.landr + box.padding.landr + box.content.width
  box.height = box.margin.tandb + box.border.tandb + box.padding.tandb + box.content.height
  box.backgroundPosition = rectangle.new(
    box.margin.left + box.border.left,
    box.margin.top + box.border.top,
    box.padding.landr + box.content.width,
    box.padding.tandb + box.content.height)
  box.borderPosition = rectangle.new(
    box.margin.left, box.margin.top,
    box.border.landr + box.padding.landr + box.content.width,
    box.border.tandb + box.padding.tandb + box.content.height
  )
  box.contentPosition = rectangle.new(
    box.margin.left + box.border.left + box.padding.left,
    box.margin.top + box.border.top + box.padding.top,
    box.content.width,
    box.content.height
  )
end

local function getRegion(box)
  if box.cachedRegion and not box.updateRegion then
    return box.cachedRegion
  end

  local r = { left = 0, top = 0 }
  local cx, cy = 0, 0
  if box.parent then
    r = box.parent:region()
    cx = box.parent.border.left + box.parent.padding.left
    cy = box.parent.border.top + box.parent.padding.top
  end

  box.cachedRegion = region(
    r.left + cx + box.x + box.margin.left,
    r.top + cy + box.y + box.margin.top,
    r.left + cx + box.x + box.width - box.margin.right,
    r.top + cy + box.y + box.height - box.margin.bottom
  )

  box.updateRegion = false
  return box.cachedRegion
end

return function(element, parent)
  element = element or {}
  local box = {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    border = getBoxRectangle(element, "border"),
    margin = getBoxRectangle(element, "margin"),
    padding = getBoxRectangle(element, "padding"),
    parent = parent,
    update = calculateValues,
    setContentSize = function(self, w, h)
      self.content.width = w
      self.content.height = h
      self:update()
    end,
    setPosition = function(self, x, y)
      self.x = x
      self.y = y
      self:update()
    end,
    setParent = function(self, p)
      self.parent = p
      self:update()
    end,
    region = getRegion
  }
  calculateValues(box)
  return box
end
