-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Deque = {}

function Deque:new()
  local dq = {}
  self.__index = self
  setmetatable(dq, self)
  return dq
end

function Deque:isempty()
  return #self == 0
end

function Deque:pushfront(o)
  self[#self + 1] = o
end

function Deque:popfront()
  return table.remove(self)
end

function Deque:pushback(o)
  table.insert(self, 1, o)
end

function Deque:popback()
  return table.remove(self, 1)
end

return Deque
