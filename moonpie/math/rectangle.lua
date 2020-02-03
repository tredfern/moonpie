-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local rectangle = {}

function rectangle.new(x, y, width, height)
  local r = {
    x = x, y = y,
    width = width, height = height
  }

  setmetatable(r, { __index = rectangle })
  return r
end

function rectangle:left()
  return self.x
end

function rectangle:right()
  return self.x + self.width
end

function rectangle:top()
  return self.y
end

function rectangle:bottom()
  return self.y + self.height
end

function rectangle:intersects(rect)
  return self:left() < rect:right() and
    rect:left() < self:right() and
    self:top() < rect:bottom() and
    rect:top() < self:bottom()
end

return rectangle