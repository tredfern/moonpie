-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local List = require "moonpie.collections.list"
local RenderEngine = { }

function RenderEngine:new()
  local engine = setmetatable({
    tree = List:new()
  }, RenderEngine)
  self.__index = self
  return engine
end

function RenderEngine:add(...)
  self.tree:add(...)
end

function RenderEngine:render()
  local out = List:new()
  for _, v in ipairs(self.tree) do
    out:add(self:render_element(v))
  end
  return out
end

function RenderEngine:render_element(element)
  if type(element) == "function" then
    local r = element()
    return self:render_element(r)
  end
  return element
end


return function(...)
  local r = RenderEngine:new()
  r:add(...)
  return r
end
