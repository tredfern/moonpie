-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local indexed_set = {}

function indexed_set:new()
  local set = {}
  set.indices = {}
  self.__index = self
  setmetatable(set, self)
  return set
end

function indexed_set:add(...)
  for _, v in ipairs({...}) do
    if self:contains(v) then error("indexed_set does not support duplicate keys") end
    self[#self + 1] = v
    self.indices[v] = #self
  end
end

function indexed_set:contains(k)
  return self.indices[k] ~= nil
end

function indexed_set:remove(item)
  local last = self[#self]
  self[self.indices[item]] = last
  self.indices[last] = self.indices[item]
  self[#self] = nil
  self.indices[item] = nil
end

return indexed_set