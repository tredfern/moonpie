-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local PriorityQueue = {}

function PriorityQueue:new(q)
  local pq = q or {}
  setmetatable(pq, self)
  self.__index = self
  return pq
end

function PriorityQueue:isempty()
  return #self == 0
end

function PriorityQueue:size()
  return #self
end

function PriorityQueue:insert(v)
  self[#self + 1] = v
  self:swim(#self)
end

function PriorityQueue:front()
  return self[1]
end

function PriorityQueue:next()
  local v = self[1]
  self:exchange(1, #self)
  self[#self] = nil
  self:sink(1)
  return v
end

function PriorityQueue:swim(index)
  while index > 1 and self:less(self:parent_index(index), index) do
    self:exchange(self:parent_index(index), index)
    index = self:parent_index(index)
  end
end

function PriorityQueue:sink(index)
  while index * 2 <= self:size() do
    local j = index * 2
    if j < self:size() and self:less(j, j + 1) then self:exchange(j, j + 1) end
    if not self:less(index, j) then break end
    self:exchange(index, j)
    index = j
  end
end

function PriorityQueue:less(i, j)
  return self[i] < self[j]
end

function PriorityQueue:exchange(i, j)
  self[i], self[j] = self[j], self[i]
end

function PriorityQueue:parent_index(index)
  return math.floor(index / 2)
end

PriorityQueue.maximum = PriorityQueue:new()
PriorityQueue.minimum = PriorityQueue:new{
  less = function(self, i, j) return self[j] < self[i] end
}

return PriorityQueue
