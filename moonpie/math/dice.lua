-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local cup = { modifier = 0 }
function cup:roll()
  local sum = 0
  for _, v in ipairs(self) do
    sum = sum + v()
  end
  return sum + self.modifier
end

local die = {}

function die.new(sides)
  local d = {}
  d.sides = sides
  setmetatable(d, { __call = die.roll, __tostring = die.string })
  return d
end

function die.roll(self)
  return love.math.random(1, self.sides)
end

function die.string(self)
  return string.format("d%d", self.sides)
end

local dice = {
  d3 = die.new(3),
  d4 = die.new(4),
  d6 = die.new(6),
  d8 = die.new(8),
  d10 = die.new(10),
  d12 = die.new(12),
  d20 = die.new(20),
  d100 = die.new(100),
}

function dice.cup(...)
  local c = {...}
  setmetatable(c, { __index = cup, __call = cup.roll })
  return c
end

function dice.parse(str)
  local c = {}
  string.gsub(str, "(%d)d(%d)", function(count, sides)
    for _=1,count do
      c[#c +1] = die.new(sides)
    end
  end)
  string.gsub(str, "([-+]%d)$", function(mod)
    c.modifier = mod
  end)

  setmetatable(c, { __index = cup, __call = cup.roll })
  return c
end


return dice