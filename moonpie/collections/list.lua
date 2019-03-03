-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local list = {}

function list:new(table)
  local b = table or {}
  setmetatable(b, self)
  self.__index = self
  return b
end

function list:add(item)
  self[#self + 1] = item
end

function list:remove(item)
  local i = self:index_of(item)
  if i then
    table.remove(self, i)
  end
end

function list:index_of(item)
  for i,v in ipairs(self) do
    if item == v then return i end
  end
  return nil
end

function list:find(search)
  for _, v in ipairs(self) do
    if search(v) then
      return v
    end
  end
  return nil
end

function list:find_last(search)
  for i = #self, 1, -1 do
    if search(self[i]) then
      return self[i]
    end
  end
  return nil
end

function list:first(n)
  if n then
    return self:slice(1, n)
  end

  return self[1]
end

function list:last(n)
  if n then
    return self:slice(#self - n + 1, n)
  end

  return self[#self]
end

function list:slice(start, count)
  local l = list:new()

  for i=start,start + count - 1 do
    l:add(self[i])
  end

  return l
end

function list:contains(item)
  return self:index_of(item) ~= nil
end

function list:where(filter)
  local result = list:new()
  for _, v in ipairs(self) do
    if filter(v) then
      result:add(v)
    end
  end
  return result
end

function list:isempty()
  return #self == 0
end

function list:clear()
  for i, _ in ipairs(self) do
    self[i] = nil
  end
end

return list
