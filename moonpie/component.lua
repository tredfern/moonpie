-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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

return Component
