-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local math_ext = {}

function math_ext.clamp(v, min, max)
  return (v < min and min) or (v > max and max) or v
end

function math_ext.percentToNumber(percent)
  local ns = string.match(percent, "([%d%.]+)%%")
  return tonumber(ns) / 100
end

function math_ext.isPercent(str)
  if type(str) ~= "string" then return false end
  local ns = string.match(str, "[%d%.]+%%")
  return ns ~= nil
end

function math_ext.between(val, min, max)
  return min <= val and val <= max
end

function math_ext.coinFlip()
  return love.math.random(1, 2) == 1
end

function math_ext.prandom(min, max)
  return love.math.random() * (max - min) + min
end

function math_ext.sign(num)
  if num > 0 then return 1 end
  if num < 0 then return -1 end
  return 0
end

function math_ext.floor(...)
  local pack = require "moonpie.tables.pack"
  local unpack = require "moonpie.utility.unpack"
  local values = pack(...)
  for i = 1, #values do
    values[i] = math.floor(values[i])
  end

  return unpack(values)
end

math_ext.vector = require "moonpie.math.vector"
math_ext.rectangle = require "moonpie.math.rectangle"
math_ext.tween = require "moonpie.ext.tween"
math_ext.line = require "moonpie.math.bresenham"

return math_ext
