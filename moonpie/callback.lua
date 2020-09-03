-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Callback = {}
local list = require "moonpie.collections.list"

function Callback:new()
  local c = {}
  c.items = list:new()
  setmetatable(c, { __index = self })
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
  for _, v in ipairs(self.items) do
    v(...)
  end
end


return Callback