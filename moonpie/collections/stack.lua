-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Stack = { }

function Stack:new()
  local s = {}
  setmetatable(s, self)
  self.__index = self
  return s
end

function Stack:push(value)
  self[#self + 1] = value
end

function Stack:pop()
  return table.remove(self)
end

function Stack:top()
  return self[#self]
end

function Stack:isEmpty()
  return #self == 0
end

function Stack:clear()
  while not self:isEmpty() do
    self:pop()
  end
end


return Stack
