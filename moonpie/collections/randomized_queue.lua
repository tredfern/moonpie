-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local RandomizedQueue = {}

function RandomizedQueue:new(t)
  t = t or {}
  local rq = {}
  self.__index = self
  setmetatable(rq, self)
  for _, v in ipairs(t) do
    rq:enqueue(v)
  end
  return rq
end

function RandomizedQueue:isEmpty()
  return #self == 0
end

function RandomizedQueue:enqueue(o)
  self[#self + 1] = o
end

function RandomizedQueue:dequeue()
  local i = love.math.random(#self)
  local r = self[i]
  self[i] = self[#self]
  self[#self] = nil
  return r
end

function RandomizedQueue:sample()
  return self[love.math.random(#self)]
end

return RandomizedQueue
