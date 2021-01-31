-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Rectangle = {}

function Rectangle.new(x, y, width, height)
  local r = {
    x = x, y = y,
    width = width, height = height
  }

  setmetatable(r, { __index = Rectangle })
  return r
end

function Rectangle:left()
  return self.x
end

function Rectangle:right()
  return self.x + self.width
end

function Rectangle:top()
  return self.y
end

function Rectangle:bottom()
  return self.y + self.height
end

function Rectangle:intersects(rect)
  return self:left() < rect:right() and
    rect:left() < self:right() and
    self:top() < rect:bottom() and
    rect:top() < self:bottom()
end

return Rectangle