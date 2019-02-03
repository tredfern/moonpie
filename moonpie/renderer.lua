-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Renderer = {}
local Block = { }
local Inline = {}

function Renderer:new()
  local r = {}
  setmetatable(r, self)
  self.__index = self
  return r
end

function Renderer:update(...)
  self.root = Block:new(...)
end


function Block:new(...)
  local b = {}
  b.children = {...}
  setmetatable(b, self)
  self.__index = self
  return b
end

return Renderer
