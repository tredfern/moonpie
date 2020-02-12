-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local die = {}

function die.new(sides)
  local d = {}
  d.sides = sides
  setmetatable(d, { __call = die.roll })
  return d
end

function die.roll(self)
  return math.random(1, self.sides)
end

local dice = {
  d6 = die.new(6)
}

return dice