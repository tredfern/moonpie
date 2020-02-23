-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local math_ext = {}

function math_ext.clamp(v, min, max)
  return (v < min and min) or (v > max and max) or v
end

function math_ext.percent_to_number(percent)
  local ns = string.match(percent, "([%d%.]+)%%")
  return tonumber(ns) / 100
end

function math_ext.is_percent(str)
  if type(str) ~= "string" then return false end
  local ns = string.match(str, "[%d%.]+%%")
  return ns ~= nil
end

function math_ext.find_max(list, func)
  local m
  for _, v in ipairs(list) do
    if m then
      m = math.max(m, func(v))
    else
      m = func(v)
    end
  end
  return m
end

math_ext.vector = require "moonpie.math.vector"
math_ext.rectangle = require "moonpie.math.rectangle"
math_ext.tween = require "moonpie.ext.tween"

return math_ext
