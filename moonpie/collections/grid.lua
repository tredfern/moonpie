-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local Grid = class({})

function Grid:constructor(w, h)
  self.width = w
  self.height = h

  local mt = getmetatable(self)
  mt.__call = Grid.get
end

function Grid:get_index(x, y)
  return x + y * self.width
end

function Grid:set(x, y, v)
  self[self:get_index(x, y)] = v
end

function Grid:get(x, y)
  return self[self:get_index(x, y)]
end

function Grid:neighbors(x, y)
  return {
    left = self:get(x - 1, y),
    up = self:get(x, y - 1),
    right = self:get(x + 1, y),
    down = self:get(x, y + 1)
  }
end

return Grid
