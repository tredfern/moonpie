-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Queue = {}

function Queue:new(base)
  local q = base or {}
  setmetatable(q, Queue)
  self.__index = self
  return q
end

function Queue:enqueue(value)
  self[#self + 1] = value
  if self.maximum and #self > self.maximum then
    self:dequeue()
  end
end

function Queue:dequeue()
  return table.remove(self, 1)
end

function Queue:front()
  return self[1]
end

function Queue:isempty()
  return #self == 0
end

function Queue:clear()
  for i, _ in ipairs(self) do
    self[i] = nil
  end
end

return Queue
