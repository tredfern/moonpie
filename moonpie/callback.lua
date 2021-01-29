-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Callback = {}
local list = require "moonpie.collections.list"

function Callback:new()
  local c = {}
  c.items = list:new()
  setmetatable(c, {
    __index = self,
    __call = self.trigger
 })
  return c
end

function Callback:add(f, m)
  if type(f) == "table" then
    self.items:add(function(...) f[m](f, ...) end)
  else
    self.items:add(f)
  end
end

function Callback:remove(f)
  self.items:remove(f)
end

function Callback:trigger(...)
  for i = 1, #self.items do
    if self.items[i] then
      self.items[i](...)
    end
  end
end



return Callback