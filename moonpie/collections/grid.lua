-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Grid = {}

function Grid:new(w, h)
  local g = {
    width = w,
    height = h
  }
  self.__index = self
  setmetatable(g, self)
  return g
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

return Grid
