-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local vector = {}

function vector.new(x, y)
  local v = {
    x = x,
    y = y
  }
  setmetatable(v, { __index = vector })
  return v
end

function vector.from_angle(radians, mag)
  return vector.new(
    math.cos(radians) * mag,
    math.sin(radians) * mag
  )
end

function vector:multiply(scale)
  self.x = self.x * scale
  self.y = self.y * scale
end

function vector:divide(scale)
  self.x = self.x / scale
  self.y = self.y / scale
end

function vector:add(v2)
  self.x = self.x + v2.x
  self.y = self.y + v2.y
end

function vector:dot(v2)
  return self.x * v2.x + self.y * v2.y
end

function vector:invert()
  self.x = -self.x
  self.y = -self.y
end

function vector:magnitude()
  return math.sqrt(self.x^2 + self.y^2)
end

function vector:magnitude_squared()
  return self.x^2 + self.y^2
end

function vector:normalize()
  self:divide(self:magnitude())
end

function vector:get_angle()
  return math.atan2(self.y, self.x)
end

function vector:unpack()
  return self.x, self.y
end


return vector