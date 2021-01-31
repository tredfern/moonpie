-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Vector = {}

function Vector.new(x, y)
  local v = {
    x = x,
    y = y
  }
  setmetatable(v, { __index = Vector })
  return v
end

function Vector.from_angle(radians, mag)
  return Vector.new(
    math.cos(radians) * mag,
    math.sin(radians) * mag
  )
end

function Vector:multiply(scale)
  self.x = self.x * scale
  self.y = self.y * scale
end

function Vector:divide(scale)
  self.x = self.x / scale
  self.y = self.y / scale
end

function Vector:add(v2)
  self.x = self.x + v2.x
  self.y = self.y + v2.y
end

function Vector:dot(v2)
  return self.x * v2.x + self.y * v2.y
end

function Vector:invert()
  self.x = -self.x
  self.y = -self.y
end

function Vector:magnitude()
  return math.sqrt(self.x^2 + self.y^2)
end

function Vector:magnitude_squared()
  return self.x^2 + self.y^2
end

function Vector:normalize()
  self:divide(self:magnitude())
end

function Vector:get_angle()
  return math.atan2(self.y, self.x)
end

function Vector:unpack()
  return self.x, self.y
end


return Vector