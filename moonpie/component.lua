-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local box_model = require(BASE .. "box_model")
local Component = {}

function Component:new()
  local c = {}
  setmetatable(c, self)
  self.__index = self
  return c
end

function Component:update(...)
  self.children = {...}
end

function Component:render()
  for _, v in ipairs(self.children) do
    v.render()
  end
end

function Component:layout()
  for _, ctrl in ipairs(self.children) do
    ctrl.box = box_model(ctrl)
  end
end

function Component:content_size()
  self:layout()
  return self.width, self.height
end

return Component
