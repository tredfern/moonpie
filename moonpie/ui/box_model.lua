-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local region = require("moonpie.ui.region")
local rectangle = require "moonpie.math.rectangle"

local function get_rekt(element, property)
  local rekt
  if type(element[property]) == "table" then
    rekt = {
      left = element[property].left or 0,
      top = element[property].top or 0,
      right = element[property].right or 0,
      bottom = element[property].bottom or 0,
    }
  else
    local v = tonumber(element[property]) or 0
    rekt = {
      left = v, top = v, right = v, bottom = v,
    }
  end
  rekt.landr = rekt.left + rekt.right
  rekt.tandb = rekt.top + rekt.bottom
  return rekt
end

local function calculate_values(box)
  box.update_region = true
  box.width = box.margin.landr + box.border.landr + box.padding.landr + box.content.width
  box.height = box.margin.tandb + box.border.tandb + box.padding.tandb + box.content.height
  box.background_position = rectangle.new(
    box.margin.left + box.border.left,
    box.margin.top + box.border.top,
    box.padding.landr + box.content.width,
    box.padding.tandb + box.content.height)
  box.border_position = rectangle.new(
    box.margin.left, box.margin.top,
    box.border.landr + box.padding.landr + box.content.width,
    box.border.tandb + box.padding.tandb + box.content.height
  )
  box.content_position = rectangle.new(
    box.margin.left + box.border.left + box.padding.left,
    box.margin.top + box.border.top + box.padding.top,
    box.content.width,
    box.content.height
  )
end

local function get_region(box)
  if box.cached_region and not box.update_region then
    return box.cached_region
  end

  local r = { left = 0, top = 0 }
  local cx, cy = 0, 0
  if box.parent then
    r = box.parent:region()
    cx = box.parent.border_position.x + box.parent.padding.left
    cy = box.parent.border_position.y + box.parent.padding.top
  end
  box.cached_region = region(
    r.left + cx + box.x + box.border_position.x,
    r.top + cy + box.y + box.border_position.y,
    r.left + cx + box.x + box.border_position:right(),
    r.top + cy + box.y + box.border_position:bottom()
  )

  box.update_region = false
  return box.cached_region
end

return function(element, parent)
  element = element or {}
  local box = {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    border = get_rekt(element, "border"),
    margin = get_rekt(element, "margin"),
    padding = get_rekt(element, "padding"),
    parent = parent,
    update = calculate_values,
    set_content_size = function(self, w, h)
      self.content.width = w
      self.content.height = h
      self:update()
    end,
    set_position = function(self, x, y)
      self.x = x
      self.y = y
      self:update()
    end,
    set_parent = function(self, p)
      self.parent = p
      self:update()
    end,
    region = get_region
  }
  calculate_values(box)
  return box
end
